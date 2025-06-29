void main()
{
    object oPlayer = GetLastUsedBy();
    if(IsInConversation(OBJECT_SELF) == TRUE)
        FloatingTextStringOnCreature("Reliquary in use", oPlayer, FALSE);
    else
    {
        ClearAllActions();
        ActionStartConversation( oPlayer, "");
    }
}
