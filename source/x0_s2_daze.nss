#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = OBJECT_SELF;
    int nDuration = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,OBJECT_SELF);
    int nBuff = nDuration/2 + 1;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eSkillAnimal = EffectSkillIncrease(SKILL_SPOT, nBuff);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, nBuff);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nBuff);
    effect eSearch = EffectSkillIncrease(SKILL_LISTEN, nBuff);
    effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
    effect eLink = EffectLinkEffects(eSkillAnimal, eMove);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eSearch);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = ExtraordinaryEffect(eLink);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    TLVFXPillar(VFX_IMP_STARBURST_GREEN,GetLocation(oTarget), 4, 0.0f, 1.3f);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}


