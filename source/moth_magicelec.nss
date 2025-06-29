#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    effect eFla = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eDiv = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eFireStorm5 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireStorm5, OBJECT_SELF);
    PlaySound("sim_exp2light");
    float fDelay;
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm2, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm3, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm4, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                fDelay = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), GetLocation(oTarget))/20;
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                      nDamage = d4(nCasterLevel) + d4(3);
                      if (nMetaMagic == METAMAGIC_MAXIMIZE)
                      {
                         nDamage = 4 * nCasterLevel + 12;
                      }
                      else if (nMetaMagic == METAMAGIC_EMPOWER)
                      {
                         nDamage = nDamage + (nDamage/2);
                      }
                    nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_ELECTRICITY);
                    if(nDamage > 0)
                    {
                          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.5);
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
                else
                {
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5);
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}







