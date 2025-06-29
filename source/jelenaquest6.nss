void main()
{
object oPC = GetClickingObject();
string sString = GetTag(OBJECT_SELF);
ActionStartConversation(oPC,sString);
}
