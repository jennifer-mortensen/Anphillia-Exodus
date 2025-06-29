#include "x2_inc_spellhook"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    int nBonus = nLevel/4 + 6;
    object oScroll = GetSpellCastItem();
    if(GetIsObjectValid(oScroll))
    {
    nLevel = 6;
    nBonus = 8;
    }
    object oTarget = GetSpellTargetObject();
    effect eSearch = EffectSkillIncrease(SKILL_SEARCH, nBonus);
    effect eDisable = EffectSkillIncrease(SKILL_DISABLE_TRAP,nBonus);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nBonus);
    effect eOpen = EffectSkillIncrease(SKILL_OPEN_LOCK, nBonus/2);
    effect ePick = EffectSkillIncrease(SKILL_PICK_POCKET, nBonus);
    effect eTrap = EffectSkillIncrease(SKILL_SET_TRAP, nBonus);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, nBonus);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSearch, eDisable);
    eLink = EffectLinkEffects(eLink, eMove);
    eLink = EffectLinkEffects(eLink, eOpen);
    eLink = EffectLinkEffects(eLink, ePick);
    eLink = EffectLinkEffects(eLink, eTrap);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
