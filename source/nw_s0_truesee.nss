#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    effect eSpot = EffectSkillIncrease(SKILL_SPOT, nLevel/4 + 10);
    effect eListen = EffectSkillIncrease(SKILL_LISTEN, nLevel/4 + 10);
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectSeeInvisible();
    effect eLink = EffectLinkEffects(eSpot, eListen);
    eLink = EffectLinkEffects(eLink, eDur);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveEffectsFromSpell(oTarget, 765);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1)));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nLevel+3)));
}

