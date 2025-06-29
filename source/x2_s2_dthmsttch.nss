#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    int nDice = nCasterLevel*2;
    int nDamage = d3(nDice);
    int nDuration = nCasterLevel;
    int nDC = 22 + (nCasterLevel/2);
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }
    effect eHeal = EffectTemporaryHitpoints(nDamage);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHeal, eDur);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(MothGetIsFortAlly(oTarget) && GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
        {
          SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 624,FALSE));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
          eHeal = EffectHeal(nDamage*4);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
          return;
        }
        else if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
        {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an Ally Undead or an Living Enemy!</c>");
        return;
        }
        else if(!MothGetIsFortAlly(oTarget))
        {
          if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
          {
            SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an Ally Undead or an Living Enemy!</c>");
            return;
          }
          if(GetRacialType(oTarget)==RACIAL_TYPE_CONSTRUCT)
          {
            SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an Ally Undead or an Living Enemy!</c>");
            return;
          }
          SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 624));
          if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE))
          {
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
          RemoveTempHitPoints();
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
          return;
          }
        }
        else
        {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an Ally Undead or an Living Enemy!</c>");
        return;
        }
    }
}
