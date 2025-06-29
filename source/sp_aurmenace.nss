#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void IceTalon()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    effect eFla = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eDiv = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    float fDelay;
    effect eLightning = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_CHEST);
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
                      nDamage = d6(nCasterLevel) + d6(4);
                    nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_COLD);
                    if(nDamage > 0)
                    {
                          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.5);
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
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

void MagicElectrifier()
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
                      nDamage = d6(nCasterLevel) + d6(4);
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

void ResRedemption()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    effect eFla = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDiv = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eFireStorm5 = EffectVisualEffect(VFX_FNF_FIRESTORM);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireStorm5, OBJECT_SELF);
    float fDelay;
    effect eLightning = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_CHEST);
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
                      nDamage = d6(nCasterLevel) + d4(6);

                    nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                    if(nDamage > 0)
                    {
                          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.5);
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
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

void AuraOfMenace()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    effect eFla = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eDiv = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eFireStorm5 = EffectVisualEffect(VFX_FNF_STORM);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireStorm5, OBJECT_SELF);
    float fDelay;
    effect eLightning = EffectBeam(VFX_BEAM_DISINTEGRATE, OBJECT_SELF, BODY_NODE_CHEST);
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
                      nDamage = d6(nCasterLevel) + d6(4);
                    nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_ACID);
                    if(nDamage > 0)
                    {
                          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.5);
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
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

void IronHorn()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF)/2;
    effect eFla = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eDiv = EffectVisualEffect(VFX_IMP_SONIC);
    effect eVis = EffectLinkEffects(eFla, eDiv);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eFireStorm2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eFireStorm3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eFireStorm4 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    PlaySound("as_an_crynight4");
    PlaySound("c_horror_bat2");
    PlaySound("codi_as_portalap");
    PlaySound("as_an_crynight4");
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm2, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm3, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm4, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                fDelay = GetRandomDelay(0.5, 1.0);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 436));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                      nDamage = d6(nCasterLevel) + d6(4);
                    if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SONIC, OBJECT_SELF, fDelay))
                    {
                        nDamage = nDamage/2;
                    }
                    if(nDamage > 0)
                    {
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

void main()
{
    int nID = GetSpellId();

    switch(nID)
    {
        case 599:
            IceTalon();
            return;
        case 596:
            MagicElectrifier();
            return;
        case 598:
            ResRedemption();
            return;
        case 846:
            AuraOfMenace();
            return;
        case 847:
            IronHorn();
            return;
    }

    switch(Random(5) + 1)
    {
        case 1:
            IceTalon();
            return;
        case 2:
            MagicElectrifier();
            return;
        case 3:
            ResRedemption();
            return;
        case 4:
            AuraOfMenace();
            return;
        case 5:
            IronHorn();
            return;
    }
}
