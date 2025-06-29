#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nDuration = MothGetCasterLevel(oCaster);
    nDuration = nDuration/4;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_FLIES);
    effect eSkill = EffectSkillIncrease(SKILL_HIDE, nDuration);
    effect eLink = EffectLinkEffects(eDur, eSkill);
    object oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        if(!GetHasSpellEffect(SPELL_VINE_MINE_CAMOUFLAGE, oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_VINE_MINE_CAMOUFLAGE, FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(4));
        }
    }
}
