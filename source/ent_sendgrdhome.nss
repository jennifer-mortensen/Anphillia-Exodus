//Place this script on the OnEnter event of a trigger to force guards that enter to return to their spawn points.

void SendGuardHome(object oGuard, object oHomeWP)
{
    float fDistanceToLocation;
    fDistanceToLocation = GetDistanceBetween(oGuard, oHomeWP);

    if(fDistanceToLocation >= 1.5)
    {
        AssignCommand(oGuard, ClearAllActions());
        AssignCommand(oGuard, ActionForceMoveToObject(oHomeWP, TRUE));
        DelayCommand(6.0, SendGuardHome(oGuard, oHomeWP)); //We're not to our destination yet, so we'll check our guard's progress again in one round.
    }
    else
    {
        //We've reached our location.  Now let's face ourselves in the proper direction!
        AssignCommand(oGuard, ClearAllActions());
        AssignCommand(oGuard, SetFacing(GetFacing(oHomeWP)));
        DeleteLocalInt(oGuard, "IS_BEING_SENT_HOME");
    }
}

void main()
{
    object oGuard = GetEnteringObject();

    if(GetIsDMPossessed(oGuard))
        return;

    string sTag = GetTag(oGuard);
    int nBeingSentHome = GetLocalInt(oGuard, "IS_BEING_SENT_HOME");

    if((sTag == "AXFELL_GATEKEEPER" || sTag == "CLEAVEN_GATE_GUARD" || GetStringLeft(sTag, 10) == "GATE_GUARD") && nBeingSentHome == FALSE)
    {
        object oWaypoint = GetLocalObject(oGuard, "MY_SPAWN_POINT");
        SetLocalInt(oGuard, "IS_BEING_SENT_HOME", FALSE);
        SendGuardHome(oGuard, oWaypoint);
    }
}
