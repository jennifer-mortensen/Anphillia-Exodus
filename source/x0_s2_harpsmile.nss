#include "nw_i0_spells"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nLevel = GetLevelByClass(CLASS_TYPE_HARPER, OBJECT_SELF);
    int nSave = (nLevel/2)+5;
    int nThrow;
    string sSave;
    string sName = GetName(oTarget);
    /*switch(Random(3))
         {
          case 0: nThrow = SAVING_THROW_FORT; sSave="Fortitude"; break;
          case 1: nThrow = SAVING_THROW_REFLEX; sSave="Reflex"; break;
          case 2: nThrow = SAVING_THROW_WILL; sSave="Will"; break;
         }*/
    effect eDur = EffectVisualEffect(VFX_DUR_GLOW_ORANGE);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eSaving;
    effect eAB;
    effect eDmg;

    if(nLevel < 10)
    {
        eSaving =  EffectSavingThrowIncrease(SAVING_THROW_ALL, 2, SAVING_THROW_TYPE_ALL);
        eAB = EffectAttackIncrease(1);
        eDmg = EffectDamageIncrease(DAMAGE_BONUS_1,DAMAGE_TYPE_BLUDGEONING);
    }
    else
    {
        eSaving =  EffectSavingThrowIncrease(SAVING_THROW_ALL, 3, SAVING_THROW_TYPE_ALL);
        eAB = EffectAttackIncrease(2);
        eDmg = EffectDamageIncrease(DAMAGE_BONUS_2,DAMAGE_TYPE_BLUDGEONING);
    }

    effect eLink = EffectLinkEffects(eSaving, eDur);
    eLink = EffectLinkEffects(eLink, eAB);
    eLink = EffectLinkEffects(eLink, eDmg);
    eLink = ExtraordinaryEffect(eLink);
    SignalEvent(oTarget, EventSpellCastAt(oTarget, 478, FALSE));
    RemoveEffectsFromSpell(oTarget,478);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel*2));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    //if(oTarget != OBJECT_SELF)
    //{
    //    SendMessageToPC(OBJECT_SELF,"<cþ  >You increase "+sName+"'s "+sSave+" saving throws with "+IntToString(nSave)+" points for "+IntToString(nLevel)+" Hours!</c>");
    //}
    //SendMessageToPC(oTarget,"<cþ  >Your "+sSave+" saving throws are increased with "+IntToString(nSave)+" points for "+IntToString(nLevel)+" Hours!</c>");
}
