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
    int nSuccessfulSave;
    effect eFla = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eDiv = EffectVisualEffect(VFX_IMP_SONIC);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    //effect eFireStorm2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    //effect eFireStorm4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    //PlaySound("as_an_crynight4");
    //PlaySound("c_horror_bat2");
    //PlaySound("codi_as_portalap");
    //PlaySound("as_an_crynight4");
    float fDelay;
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm2, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm3, GetLocation(OBJECT_SELF));
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm4, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
            if (oTarget != OBJECT_SELF)
            {
                fDelay = GetRandomDelay(0.5, 1.0);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 436));
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
                    if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SONIC, OBJECT_SELF, fDelay))
                    {
                        nDamage = nDamage/2;
                        nSuccessfulSave = TRUE;
                    }
                    else
                        nSuccessfulSave = FALSE;
                    if(nDamage > 0)
                    {
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireStorm, oTarget));
                          if(nSuccessfulSave == FALSE)
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oTarget, 6.0);
                    }
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}







