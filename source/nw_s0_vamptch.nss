#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    if(oTarget == OBJECT_SELF){return;}
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevelBase = MothGetCasterLevel(OBJECT_SELF);
    int nPaleMaster = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    int nCasterLevel = nCasterLevelBase+nPaleMaster;
    int nDice = 6;
    int nDDice = nCasterLevel /2;
    if ((nDDice) == 0)
    {
        nDDice = 1;
    }
    else if (nDDice>10)
    {
        nDDice = 11;
    }
    int nDamage = d6(nDDice);
    nDamage = MaximizeOrEmpower(nDice,nDDice,nMetaMagic);
    int nDuration = nCasterLevel;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    int nMax = GetCurrentHitPoints(oTarget) + 10;
    if(nMax < nDamage)
    {
        nDamage = nMax;
    }
    //If Demonflesh Golem or Vampire
    if(GetAppearanceType(OBJECT_SELF) == 288
       || GetAppearanceType(OBJECT_SELF) == 289
    )
    {
      nDamage = d8(10)+GetHitDice(OBJECT_SELF);
    }
    effect eHeal = EffectTemporaryHitpoints(nDamage);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHeal, eDur);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
        {
            //If Demonflesh Golem or Vampire
            SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, FALSE));
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_VAMPIRIC_TOUCH, TRUE));
            if(GetAppearanceType(OBJECT_SELF) == 288 ||GetAppearanceType(OBJECT_SELF) == 289)
            {
               if(!MyResistSpell(OBJECT_SELF, oTarget))
               {
                   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                   ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                   RemoveTempHitPoints();
                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
               }
            }
            else
            {
            if(!MyResistSpell(OBJECT_SELF, oTarget))
              {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, OBJECT_SELF);
                    RemoveTempHitPoints();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
              }
            }
        }
    }
}
