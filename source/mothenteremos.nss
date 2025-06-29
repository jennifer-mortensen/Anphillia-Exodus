void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
ActionStartConversation(oPC, "mothenteremos");
}

