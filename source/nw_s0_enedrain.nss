#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(496);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eLevelDrain;
    effect eDam, eHeal;
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20 + (nCasterLvl - 20)*1/3;
    }
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    while (GetIsObjectValid(oTarget))
    {
       if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
       {
            nDamage = d12(nCasterLvl);
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_DRAIN, FALSE));
                eHeal = EffectHeal(nDamage);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget));
            }
            else
            if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
            {
                if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                {
                    if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                    {
                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_DRAIN));
                        if(MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                          {
                           nDamage /= 2;
                          }
                        if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                        {
                            eLevelDrain = EffectNegativeLevel(d4());
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLevelDrain, oTarget));
                        }
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
            }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
}
