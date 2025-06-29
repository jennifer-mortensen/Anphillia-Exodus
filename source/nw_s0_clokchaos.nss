#include "x2_inc_toollib"
#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    if (nCasterLevel > 10)
    {
         nCasterLevel = (nCasterLevel-10) * 1 /4  + 10;
    }
    float fDelay1 = GetDistanceBetweenLocations(lTargetLocation, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_IMP_DISEASE_S,lTargetLocation,3,fDelay1);
    TLVFXPillar(VFX_FNF_GAS_EXPLOSION_NATURE,lTargetLocation, 1, fDelay1, 5.0f, 1.5f);
    TLVFXPillar(VFX_IMP_PULSE_HOLY,GetLocation(OBJECT_SELF), 2, 0.0f, 3.0f);
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            int nRoll = d100();
            if(nRoll>34)
            {
            DelayCommand(fDelay, DoSpellBreach(oTarget, 1, 0, GetSpellId()));
            }
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                nDamage = d8(nCasterLevel);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 8 * nCasterLevel;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_ACID);
                effect eAcid = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}




