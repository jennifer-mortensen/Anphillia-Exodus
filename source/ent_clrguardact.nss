void main()
{
    object oGuard = GetEnteringObject();
    if(GetTag(oGuard) == "AXFELL_GATEKEEPER")
        AssignCommand(oGuard, ClearAllActions(TRUE));
}
