#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_shifter"
void main()
{
    if (!X2PreSpellCastCode())
    {
       return;
    }
    object oTarget;
    effect eDeaf = EffectDeaf();
    effect eBlind = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_DUR_FLIES);
    effect eImmune = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);
    effect eLink = EffectLinkEffects(eDeaf, eDur);
    eLink = EffectLinkEffects(eLink, eBlind);
    eLink = EffectLinkEffects(eLink, eImmune);
    effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eImpact1 = EffectVisualEffect(VFX_FNF_BLINDDEAF);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF)/2;
    int nDC = MothDC();
    location lSpell = GetSpellTargetLocation();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSpell);
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
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSpell);
    }
}

