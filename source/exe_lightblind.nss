//Handles light blindness application.  Execute this script from the light blindness applier object (tag: LIGHT_BLINDNESS_APPLIER).
void main()
{
    object oPC = GetLocalObject(OBJECT_SELF, "OBJECT_TO_AFFECT");
    effect eAC = EffectACDecrease(1);
    effect eAB = EffectAttackDecrease(1);
    effect eLink = SupernaturalEffect(EffectLinkEffects(eAC, eAB));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPC);
    SetLocalInt(oPC, "LIGHT_BLINDNESS_APPLIED", 1);
    DeleteLocalObject(OBJECT_SELF, "OBJECT_TO_AFFECT");
}
