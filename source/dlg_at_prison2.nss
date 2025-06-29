#include "_inc_faction"

void main()
{
    object oPC = GetPCSpeaker();
    string sPortalDestination;
    int nFaction;
    location lLocation = GetLocation(oPC);

    if(GetIsOfFaction(oPC, FACTION_AXFELL))
    {
        sPortalDestination = "axf_jail_prison_2";
        nFaction = FACTION_CLEAVEN;
    }
    else if(GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
        sPortalDestination = "clv_jail_prison_2";
        nFaction = FACTION_AXFELL;
    }
    else
    {
        FloatingTextStringOnCreature("You cannot create a prison portal until you have chosen a faction.", oPC, FALSE);
        return;
    }

    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "prisport", lLocation);
    DelayCommand(0.5, SetLocalInt(oPortal, "REQUIRES_FACTION", TRUE));
    DelayCommand(0.5, SetLocalInt(oPortal, "FACTION", nFaction));
    DelayCommand(0.5, SetLocalString(oPortal, "FAILURE_MESSAGE", "The energies of this portal block you from entering."));
    DelayCommand(0.5, SetLocalString(oPortal, "WAYPOINT_DESTINATION", sPortalDestination));

    DestroyObject(oPortal, 60.0f);
}
