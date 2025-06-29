#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = GetLevelByClass(CLASS_TYPE_HARPER,OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eSkillAnimal = EffectSkillIncrease(SKILL_ALL_SKILLS, nDuration);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE);
    effect eLink = ExtraordinaryEffect(EffectLinkEffects(eSkillAnimal, eDur));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration*2));
}
