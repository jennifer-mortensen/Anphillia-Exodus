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
    effect eHeal;
    effect eFla = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDiv = EffectVisualEffect(VFX_IMP_STARBURST_RED);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    PlaySound("as_pl_x2screamm2");
    PlaySound("as_pl_x2screamm3");
    PlaySound("as_pl_x2screamm4");
    PlaySound("as_pl_x2screamm1");
    float fDelay;
    effect eLightning = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_CHEST);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm2, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm3, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm4, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
            nDamage = d6(nCasterLevel) + d6(4);
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
             nDamage = 4 * nCasterLevel + 12;
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
             nDamage = nDamage + (nDamage/2);
            }
            if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                if(MothGetIsFortAlly(oTarget))
                {
                fDelay = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), GetLocation(oTarget))/20;
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                eHeal = EffectHeal(nDamage*2);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.5);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
            else
            {
               if(!MothGetIsFortAlly(oTarget))
               {
                fDelay = GetRandomDelay(0.5, 1.0);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF, fDelay))
                    {
                        nDamage = nDamage/2;
                    }
                    if(nDamage > 0)
                    {
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                          fDelay = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), GetLocation(oTarget))/20;
                          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.5);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
               }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}







