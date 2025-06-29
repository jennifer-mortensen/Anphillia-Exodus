#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = 5;
    int nDuration = MothGetCasterLevel(OBJECT_SELF)+2;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_CATS_GRACE, FALSE));
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nRaise = 5;
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nRaise = 7;
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    eRaise = EffectAbilityIncrease(ABILITY_CONSTITUTION, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);
    if(GetIsObjectValid(oScroll))
    {
    eLink = ExtraordinaryEffect(eLink);
    nRaise = 5;
    }
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
