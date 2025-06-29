#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "x2_I0_SPELLS"
void RunFirestormCombustImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic);
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDamage2;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = 10 + nCasterLevel;
    if (nDuration < 1)
        nDuration = 10;
    if(nCasterLevel > 20)
    {
        nCasterLevel = 20;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_FIRESTORM);
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                fDelay = GetRandomDelay(1.5, 2.5);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                      nDamage = d6(nCasterLevel);
                      nDamage2 = d4(nCasterLevel);
                      if (nMetaMagic == METAMAGIC_MAXIMIZE)
                      {
                         nDamage = 6 * nCasterLevel;
                         nDamage2 = 4 * nCasterLevel;
                      }
                      else if (nMetaMagic == METAMAGIC_EMPOWER)
                      {
                         nDamage = nDamage + (nDamage/2);
                         nDamage2 = nDamage2 + (nDamage2/2);
                      }
                      nDamage2 = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_DIVINE);
                      nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                    if(nDamage > 0)
                    {
                          effect eDivine = EffectDamage(nDamage2, DAMAGE_TYPE_DIVINE);
                          effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivine, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                    if (!GetHasSpellEffect(GetSpellId(),oTarget) && !GetHasSpellEffect(SPELL_COMBUST))  //Moonlight; apply combust-like effect to creatures caught within the fire storm; does not stack with combust.
                    {
                        TLVFXPillar(VFX_IMP_FLAME_M, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(498), oTarget, RoundsToSeconds(nDuration/2));
                        DelayCommand(8.0, RunFirestormCombustImpact(oTarget, OBJECT_SELF, nCasterLevel, nMetaMagic));
                    }
           }
         }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
void RunFirestormCombustImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic)
{
    if (GZGetDelayedSpellEffectsExpired(SPELL_FIRE_STORM, oTarget, oCaster))
    {
        return;
    }
    if (GetIsDead(oTarget) == FALSE)
    {
        int nDamage = nLevel;
        if (nDamage > 15)
        {
            nDamage = 15;
        }
        nDamage  += d6(3);
        if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2);
        }
        int nFire = FloatToInt((nDamage + 12) * 0.6); //Partition the combust-like damage into two parts: 60% fire and 40% divine.
        int nDivine = FloatToInt((nDamage + 12) * 0.4);
        effect eFire = EffectDamage(nFire, DAMAGE_TYPE_FIRE);
        effect eDivine = EffectDamage(nDivine, DAMAGE_TYPE_DIVINE);
        effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eFire,oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDivine,oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
        DelayCommand(8.0f,RunFirestormCombustImpact(oTarget,oCaster, nLevel,nMetaMagic));
   }
}

