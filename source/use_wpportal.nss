#include "_inc_faction"

void main()
{
    string sWaypointTag = GetLocalString(OBJECT_SELF, "WAYPOINT_DESTINATION");
    object oWaypoint = GetWaypointByTag(sWaypointTag);
    object oPC = GetLastUsedBy();

    int nRequiresFaction = GetLocalInt(OBJECT_SELF, "REQUIRES_FACTION");
    int nFaction = GetLocalInt(OBJECT_SELF, "FACTION");
    string sMessage = GetLocalString(OBJECT_SELF, "FAILURE_MESSAGE");

    if(nRequiresFaction)
    {
        switch(nFaction)
        {
            case FACTION_AXFELL:
                if(!GetIsObjectValid(GetItemPossessedBy(oPC, "axfellwarriorrin")))
                {
                    if(sMessage != "")
                        FloatingTextStringOnCreature(sMessage, oPC, FALSE);
                     return;
                }
                break;
            case FACTION_CLEAVEN:
                if(!GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenmilitiari")))
                {
                    if(sMessage != "")
                        FloatingTextStringOnCreature(sMessage, oPC, FALSE);
                     return;
                }
                break;
        }
    }

    if(!GetIsInCombat(oPC))
    {
        ActionStartConversation(oPC, "", TRUE);
    }
    else
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oWaypoint));
    }
}
