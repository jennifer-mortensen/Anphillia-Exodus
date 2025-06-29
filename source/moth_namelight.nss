#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevel = MothGetCasterLevel(OBJECT_SELF)+10;
    object oTarget;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eSpot = EffectSkillIncrease(SKILL_SPOT, nLevel/4);
    effect eListen = EffectSkillIncrease(SKILL_LISTEN, nLevel/4);
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectSeeInvisible();
    effect eLink = EffectLinkEffects(eSpot, eListen);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    location lSpell = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 1, fDelay1, 6.0f, 2.0f);
    TLVFXPillar(VFX_FNF_LOS_HOLY_10,lSpell, 1, fDelay1+0.4, 6.0f, 2.0f);
    DelayCommand(0.1,TLVFXPillar(VFX_FNF_LOS_HOLY_30,lSpell, 1, 0.0f, 1.2f));
    DelayCommand(0.2,TLVFXPillar(VFX_FNF_LOS_HOLY_20,lSpell, 1, 0.0f, 0.9f));
    DelayCommand(0.3,TLVFXPillar(VFX_FNF_LOS_NORMAL_20,lSpell, 1, 0.0f, 0.3f));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    while(GetIsObjectValid(oTarget))
    {
       if(MothGetIsFortAlly(oTarget))
       {
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        RemoveEffectsFromSpell(oTarget, SPELL_TRUE_SEEING);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1)));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel)));
       }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}

