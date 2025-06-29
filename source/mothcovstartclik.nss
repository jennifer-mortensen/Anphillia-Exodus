//Use a conversation start by click and not use. Good for large placeables.
void main()
{
object oPC = GetPlaceableLastClickedBy();
float fDist = GetDistanceBetween(OBJECT_SELF,oPC);
if (fDist <= 10.0)
{
AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, ""));
}
}

