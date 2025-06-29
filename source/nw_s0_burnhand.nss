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
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oTarget;
    effect eFire;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    if (nCasterLevel > 5)
    {
        nCasterLevel = (nCasterLevel-5)*1/3+5;
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BURNING_HANDS));
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDist) && oTarget != OBJECT_SELF)
            {
                nDamage = d4(nCasterLevel) + nCasterLevel;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDamage = nCasterLevel*4 + nCasterLevel;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2) + nCasterLevel;
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if(nDamage > 0)
                {
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
