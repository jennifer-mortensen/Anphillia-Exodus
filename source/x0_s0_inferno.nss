#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    float fDist;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel/2;
    if(nDuration < 1){nDuration = 1;}
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oTarget;
    effect eFire;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDaze2 = EffectDazed();
    effect eDaze = EffectLinkEffects(eVis2,eDaze2);
    if (nCasterLevel > 15)
    {
    nCasterLevel = (nCasterLevel-15)*1/3+15;
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INFERNO));
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDist) && oTarget != OBJECT_SELF)
            {
                nDamage = d6(nCasterLevel);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDamage = 6 * nCasterLevel;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
                else if (nMetaMagic == METAMAGIC_EXTEND)
                {
                     nDuration = nDuration*2;
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if(nDamage > 0)
                {
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget,MothDC(), SAVING_THROW_TYPE_MIND_SPELLS))
                {
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget,RoundsToSeconds(nDuration)));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
