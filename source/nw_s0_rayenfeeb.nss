#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(oCaster);
    int nDamage;
    int nMax;
    effect eDam;
    effect eVis1 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eRay = EffectBeam(VFX_BEAM_ODD, OBJECT_SELF, BODY_NODE_HAND);
    //If Epic Lizard
    if(GetAppearanceType(OBJECT_SELF) == 131 ||
       GetAppearanceType(OBJECT_SELF) == 133
    )
    {
        int nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        nCasterLevel == nShifter;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_ENFEEBLEMENT));
        eRay = EffectBeam(VFX_BEAM_ODD, OBJECT_SELF, BODY_NODE_HAND);
        if (!MyResistSpell(oCaster, oTarget))
        {
        if (nCasterLevel > 15)
        {
        nCasterLevel = 15;
        }
            nDamage = d4(nCasterLevel);
            nMax = 4;
            }
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = nMax * nCasterLevel;
            }
            if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + (nDamage/2);
            }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}

