#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster)+2;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fRadiusBase = 6.67;
    float fRadiusBonus = 0.15*nCasterLvl;
    float fRadius = fRadiusBase + fRadiusBonus;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 10)
    {
         nCasterLvl = (nCasterLvl-10) * 1 /4  + 10;
    }
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CALL_LIGHTNING));
            fDelay = GetRandomDelay(0.4, 1.75);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d6(nCasterLvl);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 6 * nCasterLvl;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                   nDamage = nDamage + nDamage / 2;
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_ELECTRICITY);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
