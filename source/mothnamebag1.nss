void main()
{
    object oPC = GetItemActivator();
    object oBag = GetItemActivatedTarget();
    if(GetIdentified(oBag)==FALSE)
    {
        SendMessageToPC(oPC, "<cþÞ >*Target must be Identified!*</c>");
        return;
    }
    if(GetItemPossessor(oBag)!=oPC)
    {
        SendMessageToPC(oPC, "<cþÞ >*Target must be in your inventory!*</c>");
        return;
    }
    else
    {
        AssignCommand(oPC,ActionStartConversation(oPC,"mothbagconv",TRUE,FALSE));
    }
}
