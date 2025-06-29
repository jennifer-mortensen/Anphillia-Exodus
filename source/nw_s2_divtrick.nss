void main()
{
    object oTarget = GetSpellTargetObject();
    int nDuration = 10 + GetAbilityModifier(ABILITY_CHARISMA);
    int nLevel = GetLevelByClass(CLASS_TYPE_CLERIC);
    /*if(nLevel<6)
    {
     SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You have too few Cleric levels to channel this Domain Power!</c>");
     return;
    }*/
    nLevel = 4 + nLevel/2;
    effect eSearch = EffectSkillIncrease(SKILL_SEARCH, nLevel);
    effect eDisable = EffectSkillIncrease(SKILL_DISABLE_TRAP, nLevel);
    effect eMove = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nLevel);
    effect eOpen = EffectSkillIncrease(SKILL_OPEN_LOCK, nLevel);
    effect ePick = EffectSkillIncrease(SKILL_SET_TRAP, nLevel);
    effect eHide = EffectSkillIncrease(SKILL_HIDE, nLevel);
    effect ePers = EffectSkillIncrease(SKILL_PERSUADE, nLevel);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eSearch, eDisable);
    eLink = EffectLinkEffects(eLink, eMove);
    eLink = EffectLinkEffects(eLink, eOpen);
    eLink = EffectLinkEffects(eLink, ePick);
    eLink = EffectLinkEffects(eLink, eHide);
    eLink = EffectLinkEffects(eLink, ePers);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = ExtraordinaryEffect(eLink);
    effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DIVINE_TRICKERY, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration+5));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
