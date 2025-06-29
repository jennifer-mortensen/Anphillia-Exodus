#include "_inc_items"

void main()
{
    object oPC = GetLocalObject(OBJECT_SELF, "CREATURE_TO_APPLY_IMMUNTIES_TO");
    object oImmunityApplier = OBJECT_SELF;

    effect eEffect = GetFirstEffect(oPC); //Remove old immunity effects.
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectCreator(eEffect) == OBJECT_SELF)
        {
            RemoveEffect(oPC, eEffect);
       }
        eEffect = GetNextEffect(oPC);
    }

    int nBludgeoningImmunity = GetLocalInt(oPC, "BLUDGEONING_IMMUNITY");
    int nPiercingImmunity = GetLocalInt(oPC, "PIERCING_IMMUNITY");
    int nSlashingImmunity = GetLocalInt(oPC, "SLASHING_IMMUNITY");
    int nMagicalImmunity = GetLocalInt(oPC, "MAGICAL_IMMUNITY");
    int nAcidImmunity = GetLocalInt(oPC, "ACID_IMMUNITY");
    int nColdImmunity = GetLocalInt(oPC, "COLD_IMMUNITY");
    int nDivineImmunity = GetLocalInt(oPC, "DIVINE_IMMUNITY");
    int nElectricalImmunity = GetLocalInt(oPC, "ELECTRICAL_IMMUNITY");
    int nFireImmunity = GetLocalInt(oPC, "FIRE_IMMUNITY");
    int nNegativeImmunity = GetLocalInt(oPC, "NEGATIVE_IMMUNITY");
    int nPositiveImmunity = GetLocalInt(oPC, "POSITIVE_IMMUNITY");
    int nSonicImmunity = GetLocalInt(oPC, "SONIC_IMMUNITY");

    //Apply new immunity effects.

    if(nBludgeoningImmunity > 0)
    {
        if(nBludgeoningImmunity > DAMAGE_IMMUNITY_CAP)
            nBludgeoningImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, nBludgeoningImmunity)), oPC);
    }
    if(nPiercingImmunity > 0)
    {
        if(nPiercingImmunity > DAMAGE_IMMUNITY_CAP)
            nPiercingImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, nPiercingImmunity)), oPC);
    }
    if(nSlashingImmunity > 0)
    {
        if(nSlashingImmunity > DAMAGE_IMMUNITY_CAP)
            nSlashingImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, nSlashingImmunity)), oPC);
    }
    if(nMagicalImmunity > 0)
    {
        if(nMagicalImmunity > DAMAGE_IMMUNITY_CAP)
            nMagicalImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, nMagicalImmunity)), oPC);
    }
    if(nAcidImmunity > 0)
    {
        if(nAcidImmunity > DAMAGE_IMMUNITY_CAP)
            nAcidImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, nAcidImmunity)), oPC);
    }
    if(nColdImmunity > 0)
    {
        if(nColdImmunity > DAMAGE_IMMUNITY_CAP)
            nColdImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, nColdImmunity)), oPC);
    }
    if(nDivineImmunity > 0)
    {
        if(nDivineImmunity > DAMAGE_IMMUNITY_CAP)
            nDivineImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nDivineImmunity)), oPC);
    }
    if(nElectricalImmunity > 0)
    {
        if(nElectricalImmunity > DAMAGE_IMMUNITY_CAP)
            nElectricalImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, nElectricalImmunity)), oPC);
    }
    if(nFireImmunity > 0)
    {
        if(nFireImmunity > DAMAGE_IMMUNITY_CAP)
            nFireImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, nFireImmunity)), oPC);
    }
    if(nNegativeImmunity > 0)
    {
        if(nNegativeImmunity > DAMAGE_IMMUNITY_CAP)
            nNegativeImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nNegativeImmunity)), oPC);
    }
    if(nPositiveImmunity > 0)
    {
        if(nPositiveImmunity > DAMAGE_IMMUNITY_CAP)
            nPositiveImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, nPositiveImmunity)), oPC);
    }
    if(nSonicImmunity > 0)
    {
        if(nSonicImmunity > DAMAGE_IMMUNITY_CAP)
            nSonicImmunity = DAMAGE_IMMUNITY_CAP;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, nSonicImmunity)), oPC);
    }

    DeleteLocalObject(OBJECT_SELF, "CREATURE_TO_APPLY_IMMUNTIES_TO"); //We won't be needing this information once we're done with the script.
}
