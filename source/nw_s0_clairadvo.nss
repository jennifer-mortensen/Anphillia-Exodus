#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    int nBonus = 15;
    if(GetIsObjectValid(oScroll))
    {
     nBonus=10;
    }
    effect eSpot = EffectSkillIncrease(SKILL_SPOT, nBonus);
    effect eListen = EffectSkillIncrease(SKILL_LISTEN, nBonus);
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSpot, eListen);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    object oTarget = GetSpellTargetObject();
    int nLevel = MothGetCasterLevel(OBJECT_SELF)*2;
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, FALSE));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel)));
}

