float SpellDelay (object oTarget, int nShape);
#include "X0_I0_SPELLS"
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
    if (nCasterLevel > 15)
    {
        nCasterLevel = (nCasterLevel-15)/2 + 15;
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONE_OF_COLD));
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
                    nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_COLD);
                    if(nDamage>200){nDamage=196+d4();}
                    effect eCold = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
                    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
                    if(nDamage > 0)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCold, oTarget));
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

