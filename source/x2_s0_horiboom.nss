#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF)/2;
    int nRounds = d4();
    float fDelay;
    int nMetaMagic = GetMetaMagicFeat();
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eDeaf1 = EffectDeaf();
    effect eDeaf2 = EffectVisualEffect(VFX_DUR_GLOW_BROWN);
    effect eDeaf = EffectLinkEffects(eDeaf1,eDeaf2);
    effect eImmune = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,lTarget);
    while(GetIsObjectValid(oTarget))
    {
     if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
     {
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
        TLVFXPillar(VFX_FNF_LOS_NORMAL_20,lTarget, 1, fDelay, 4.0f, 1.8f);
        if (!MyResistSpell(OBJECT_SELF, oTarget))
           {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            int nDam = d2(nCasterLvl) + nCasterLvl;
            if (nMetaMagic == METAMAGIC_EXTEND)
            {
                nRounds = nRounds*2;
            }
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDam = 2 * nCasterLvl + nCasterLvl;
            }
            if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDam = nDam + nDam/2;
            }
            effect eDam = EffectDamage(nDam, DAMAGE_TYPE_SONIC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()+2, SAVING_THROW_TYPE_SONIC))
            {
                MothRemoveAnySong(oTarget,fDelay);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(nRounds));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmune, oTarget, RoundsToSeconds(nRounds));
            }
           }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,lTarget);
   }
}





