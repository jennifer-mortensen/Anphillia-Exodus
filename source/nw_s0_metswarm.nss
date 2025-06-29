#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nLos = 0;
    if(GetAppearanceType(OBJECT_SELF) == 1032||
       GetAppearanceType(OBJECT_SELF) == 1033
    )
    {
     nLos = 1;
    }
    effect eFire;
    effect eMeteor = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    float nRadius = 32.0;
    location lLocation = GetLocation(OBJECT_SELF);
    if (nCasterLevel > 20)
    {
        nCasterLevel = (nCasterLevel-20)*2/3+20;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lLocation);
    float fDelay;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nRadius, lLocation, nLos, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            fDelay = GetRandomDelay();
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_METEOR_SWARM));
            if(!MyResistSpell(OBJECT_SELF, oTarget, 0.5))
              {
                      nDamage = d6(nCasterLevel)+nMothBonus3;
                      nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_FIRE);
                      eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                      if(nDamage > 0)
                      {
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                      }
               }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, nRadius, lLocation, nLos, OBJECT_TYPE_CREATURE);
    }
}
