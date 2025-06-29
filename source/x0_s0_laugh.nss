#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = nCasterLvl/2;
    float fDelay;
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eVis = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eLaugh = EffectDazed();
    location lTarget = GetSpellTargetLocation();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,lTarget);
    while(GetIsObjectValid(oTarget))
    {
     if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
     {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
        TLVFXPillar(VFX_FNF_HOWL_ODD,lTarget, 1, fDelay, 3.0f, 1.5f);
        if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_MIND_SPELLS))
           {
                if (!GetIsImmune(oTarget,IMMUNITY_TYPE_MIND_SPELLS))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(nDuration));
                    AssignCommand(oTarget, ClearAllActions());
                    AssignCommand(oTarget, PlayVoiceChat(VOICE_CHAT_LAUGH));
                    AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
                    DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLaugh, oTarget, RoundsToSeconds(nDuration)));
                }
           }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,lTarget);
   }
}





