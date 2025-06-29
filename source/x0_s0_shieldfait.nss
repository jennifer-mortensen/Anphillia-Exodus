#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    int nLimit;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nValue = 2 + (nCasterLvl/7);
    if (nValue > 6)
     nValue = 6;
    effect eReduction;
    effect eAC = EffectACIncrease(nValue, AC_DEFLECTION_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eLink = EffectLinkEffects(eAC, eDur);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 421, FALSE));
    if(oTarget == OBJECT_SELF&&
    MothGetHasGreatAbility(ABILITY_WISDOM,OBJECT_SELF)&&
    //GetHasFeat(FEAT_EPIC_CLERIC) && //J. Persinne; this check removed because it was redundant.  It is not possible to be a pure cleric with Great Wisdom V without also having the epic cleric feat.
    (MothGetIsPureClass(CLASS_TYPE_CLERIC,OBJECT_SELF) || MothGetIsPureClass(CLASS_TYPE_DRUID, OBJECT_SELF))&& //J. Persinne; druids can now benefit from greater shield of faith.
    GetLocalInt(OBJECT_SELF,"MOTHGREATFAITH")==FALSE
    )
    {
     nValue = nCasterLvl/10;
     nLimit = 20*nDuration;
     eDur = EffectVisualEffect(495);
     eAC = EffectACIncrease(nValue, AC_DODGE_BONUS);
     eReduction = EffectDamageReduction(nCasterLvl, DAMAGE_POWER_PLUS_TWENTY, nLimit);
     effect eLink2 = EffectLinkEffects(eAC, eDur);
     eLink2 = EffectLinkEffects(eLink2, eReduction);
     eLink2 = ExtraordinaryEffect(eLink2);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration));
     SetLocalInt(OBJECT_SELF,"MOTHGREATFAITH",TRUE);
     return;
    }
    else if(MothAllowSelfSheildOfFaith(oTarget,OBJECT_SELF))
    {
     if (nMetaMagic == METAMAGIC_EXTEND)
     {
       nDuration = nDuration * 2;
     }
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    }
    else
    {
       SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a valid target. Target needs to be an ally!</c>");
    }
}
