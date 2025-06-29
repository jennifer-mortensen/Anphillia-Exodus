#include "x0_i0_spells"
void main()
{
    object oTarget = OBJECT_SELF;
    if(GetIsPC(oTarget))
    {
    int nBluff = GetSkillRank(SKILL_BLUFF,oTarget)/3;
    effect eMS = EffectSkillIncrease(SKILL_MOVE_SILENTLY,1+nBluff); //Moonlight; Awry Self now boosts Move Silently instead of Hide.
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eMS, eDur);
    eLink = ExtraordinaryEffect(eLink);
    int nLevel1 = GetLevelByClass(CLASS_TYPE_ASSASSIN,oTarget);
    int nLevel2 = GetLevelByClass(CLASS_TYPE_BARBARIAN,oTarget);
    int nLevel3 = GetLevelByClass(CLASS_TYPE_ROGUE,oTarget);
    int nLevel4 = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oTarget);
    int nLevel  = nLevel1+nLevel2+nLevel3+nLevel4;
    if(!GetHasSpellEffect(GetSpellId(), oTarget))
    {
        RemoveEffectsFromSpell(oTarget,GetSpellId());
        SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nLevel));
    }
    }
    else
    {
    effect eAOE = EffectAreaOfEffect(AOE_MOB_UNEARTHLY);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oTarget, HoursToSeconds(100));
    }
}
