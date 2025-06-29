#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
       return;
    }
    object oTarget;
    effect eMute = EffectSilence();
    effect eDur = EffectVisualEffect(VFX_DUR_BUBBLES);
    effect eImmune = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);
    effect eLink = EffectLinkEffects(eMute, eDur);
    eLink = EffectLinkEffects(eLink, eImmune);
    effect eVis = EffectVisualEffect(VFX_IMP_SILENCE);
    effect eImpact1 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    effect eShake = EffectVisualEffect(356);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    location lSpell = GetSpellTargetLocation();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    PlaySound("as_mg_telepin1");
    DelayCommand(0.4,PlaySound("as_mg_telepout1"));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShake, lSpell, RoundsToSeconds(1));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC()))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }
}

