void main()
{
    object activator = GetItemActivator();
    object target = GetItemActivatedTarget();
    object AFKStore = GetObjectByTag("AFKStore");
    AssignCommand(activator,ActionStartConversation(OBJECT_SELF, "afk_wand", TRUE));
}
