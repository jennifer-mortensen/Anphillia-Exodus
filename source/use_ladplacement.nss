#include "_inc_assault"
#include "spawn_functions"

void UpdateLadderSetStatus(object oPC, string sLadderID, float fLayTime, float fSecondsSpentLaying)
{
    object oGuardSpawn = GetWaypointByTag(GetLocalString(OBJECT_SELF, "MY_GUARD_SPAWN_POINT"));

    if(GetLocalInt(oPC, "CANCELED_LADDER_LAY") == TRUE) //The PC has ceased setting a ladder; delete the flag that told us so, enable the ground, and then exit out.
    {
        DeleteLocalInt(oPC, "CANCELED_LADDER_LAY");
        NESS_ActivateSpawn(oGuardSpawn); //It's now fine for guards to spawn atop the walls.
        SetUseableFlag(OBJECT_SELF, TRUE);
        DeleteLocalInt(OBJECT_SELF, "LADDER_BEING_SET");
        return;
    }
    else if(GetLocalInt(GetLadderBaseFromID(sLadderID), "STILL_BEING_LAID") == TRUE && (!GetIsObjectValid(oPC) || GetIsDead(oPC) || GetArea(oPC) != GetArea(OBJECT_SELF)))
    {   //The player has logged out, died, or been whisked away by a DM.  Whatever the case, they've failed to set a ladder...
        DestroyObject(GetLadderBaseFromID(sLadderID));
        DeleteLocalObject(OBJECT_SELF, "MY_LADDER_LAYER");
        SetUseableFlag(OBJECT_SELF, TRUE);
        NESS_ActivateSpawn(oGuardSpawn);
        DeleteLocalInt(OBJECT_SELF, "LADDER_BEING_SET");
        if(GetIsObjectValid(oPC))
            SetCommandable(TRUE, oPC);
        return;
    }
    else if(fSecondsSpentLaying >= fLayTime) //The player has finished laying a ladder. Enable it for use and then exit out.
    {
        DeleteLocalObject(OBJECT_SELF, "MY_LADDER_LAYER");
        EnableAssaultLadder(sLadderID);
        DeleteLocalInt(OBJECT_SELF, "LADDER_BEING_SET");
        SetCommandable(TRUE, oPC);
        return;
    }

    //Update our status again in one second.
    DelayCommand(1.0, UpdateLadderSetStatus(oPC, sLadderID, fLayTime, fSecondsSpentLaying + 1.0));
}

void main()
{
    object oPC = GetLastUsedBy();
    string sID = GetAssaultObjectID(OBJECT_SELF);
    object oGuardSpawn = GetWaypointByTag(GetLocalString(OBJECT_SELF, "MY_GUARD_SPAWN_POINT"));
    object oLadderItem = GetItemPossessedBy(oPC, "ASSAULT_LADDER");
    object oGuard = GetGateGuardFromID(sID);
    location lLocation = GetLocation(GetWaypointByTag("WP_SPAWN_ASSAULT_LADDER_" + sID));

    //Run a series of checks to ensure that a ladder can be set...
    if(GetIsObjectValid(oGuard) && !GetIsDead(oGuard))
    {
        SendAssaultMessage("You must fell the guard that watches over this ground before a ladder can be set!", oPC);
        return;
    }
    if(!GetIsObjectValid(oLadderItem))
    {
        SendAssaultMessage("You must have an assault ladder kit to lay a ladder!", oPC);
        return;
    }
    if(GetAppearanceType(oPC) > 6)
    {
        SendAssaultMessage("You cannot lay a ladder while polymorphed!", oPC);
        return;
    }
    if(GetIsObjectValid(GetLadderBaseFromID(sID)))
    {
        SendAssaultMessage("A ladder has already been set here!", oPC);
        return;
    }
    if(GetLocalInt(OBJECT_SELF, "LADDER_BEING_SET") == 1)
    {
        SendAssaultMessage("A ladder is already being laid here!", oPC);
        return;
    }

    //The ladder can be set if we've gotten this far. Let's run the appropriate setup!

    float fLayTime = GetLadderLayTime(oPC);

    DestroyObject(oLadderItem); //Assault ladder kits can be used only once.
    SetUseableFlag(OBJECT_SELF, FALSE); //We don't want multiple ladders being set at once!
    SetLocalInt(OBJECT_SELF, "LADDER_BEING_SET", TRUE); //Just a failsafe in case the above doesn't quite do the trick.
    NESS_DeactivateSpawn(oGuardSpawn); //We don't want guards to spawn atop the wall while a ladder is being set.
    SetLocalObject(OBJECT_SELF, "MY_LADDER_LAYER", oPC);
    SendAssaultMessage("You have begun to lay a ladder! (Click the ladder object to cease ladder placement.)", oPC);

    //Ladder lay animations...
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fLayTime));
    DelayCommand(0.1, SetCommandable(FALSE, oPC));

    CreateAssaultLadder(sID, fLayTime);
    UpdateLadderSetStatus(oPC, sID, fLayTime, 0.0); //Begin a cyclical check function to keep track ladder laying status.
}
