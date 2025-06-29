void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "mothphobosheart")== OBJECT_INVALID)
   return;
ActionStartConversation(oPC, "mothphobosfinal");
}
