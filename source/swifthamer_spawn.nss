void main()
{
    if(GetLocalInt(OBJECT_SELF, "doOnce")){
        return;
    }
    SetLocalInt(OBJECT_SELF, "doOnce", 1);


    int isDivine = GetLocalInt(GetModule(), "swifthammer_divine");
    int isPhysical = GetLocalInt(GetModule(), "swifthammer_physical");
    int isElemental = GetLocalInt(GetModule(), "swifthammer_elemental");
    int isMagical = GetLocalInt(GetModule(), "swifthammer_magical");

    location lLocation = GetLocation(GetWaypointByTag("swifthammer_spawn"));
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, "creature016", lLocation, FALSE, "swifthammer_creature");

    if(!isDivine){
        effect eDivine = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, 200);
        effect ePositive = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 200);
        effect eNegative = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 200);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDivine, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePositive, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNegative, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBeam(VFX_BEAM_HOLY, GetObjectByTag("wolf_statue_divine"), BODY_NODE_CHEST), oCreature);
    }

    if(!isPhysical){
        effect eSlash = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 200);
        effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 200);
        effect eBludge = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 200);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlash, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePierce, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBludge, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBeam(VFX_BEAM_BLACK, GetObjectByTag("wolf_statue_physical"), BODY_NODE_CHEST), oCreature);
    }

    if(!isElemental){
        effect eAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 200);
        effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 200);
        effect eElectrical = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 200);
        effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 200);
        effect eSonic = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 200);


        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAcid, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCold, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eElectrical, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFire, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSonic, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBeam(VFX_BEAM_LIGHTNING,  GetObjectByTag("wolf_statue_elemental"), BODY_NODE_HAND), oCreature);
    }

    if(!isMagical){
        effect eMagical = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, 200);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMagical, oCreature);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBeam(VFX_BEAM_MIND, GetObjectByTag("wolf_statue_magical"), BODY_NODE_CHEST), oCreature);

    }






}
