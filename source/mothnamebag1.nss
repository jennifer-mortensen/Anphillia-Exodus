void main()
{
    object oPC = GetItemActivator();
    object oBag = GetItemActivatedTarget();
    if(GetIdentified(oBag)==FALSE)
    {
        SendMessageToPC(oPC, "<c�� >*Target must be Identified!*</c>");
        return;
    }
    if(GetItemPossessor(oBag)!=oPC)
    {
        SendMessageToPC(oPC, "<c�� >*Target must be in your inventory!*</c>");
        return;
    }
    else
    {
        AssignCommand(oPC,ActionStartConversation(oPC,"mothbagconv",TRUE,FALSE));
    }
}
