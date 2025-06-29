#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF)*2;
    effect eBlind =  EffectBlindness();
    effect eDeaf = EffectDeaf();
    effect eImmune = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);
    effect eDur = EffectVisualEffect(VFX_DUR_FLIES);
    effect eLink = EffectLinkEffects(eBlind, eDeaf);
    eLink = EffectLinkEffects(eLink, eImmune);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eXpl1 = EffectVisualEffect(VFX_FNF_BLINDDEAF);
    effect eXpl2 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eXpl = EffectLinkEffects(eXpl1,eXpl2);
    effect eShake = EffectVisualEffect(356);
    location lSpell = GetSpellTargetLocation();
    float fRadius = 20.0;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShake, lSpell, RoundsToSeconds(1));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eXpl, lSpell);
    location lTarget2 = GenerateNewLocationFromLocation(lSpell,7.0,90.0,90.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eXpl1,lTarget2);
    location lTarget3 = GenerateNewLocationFromLocation(lSpell,7.0,180.0,180.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eXpl1,lTarget3);
    location lTarget4 = GenerateNewLocationFromLocation(lSpell,7.0,270.0,270.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eXpl1,lTarget4);
    location lTarget5 = GenerateNewLocationFromLocation(lSpell,7.0,359.9,359.9);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eXpl1,lTarget5);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lSpell);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_BLINDNESS_AND_DEAFNESS));
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if (!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC()))
                {
                    ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius,lSpell);
    }
}
