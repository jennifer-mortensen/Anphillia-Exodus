void main()
{
object oPC = GetLastUsedBy();
object oMod = GetModule();
if (GetIsInCombat(oPC)) return;
if (GetItemPossessedBy(oPC, "mothplot4")== OBJECT_INVALID)
   return;
//Proceed if the PC has the right power stone

object oItem;
object oObject;
oObject = GetObjectByTag("mothplot7");
oItem = GetItemPossessedBy(oPC, "mothplot4");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
if (GetIsObjectValid(oObject))
   DestroyObject(OBJECT_SELF);
   int nInt;
   nInt = GetLocalInt(oMod, "Mothsocket");
   nInt += 1;
   SetLocalInt(oMod, "Mothsocket", nInt);
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oObject));
   ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oObject));
   SendMessageToPC(oPC, "As you place the gem into its socket the earth trembles and the odd object descends into the ground. It is now completely gone");
}

