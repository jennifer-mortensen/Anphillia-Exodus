#include "nw_i0_plot"

void main()
{
    object oUser = GetLastUsedBy();
    string sTag = GetTag(OBJECT_SELF);
    string sWaypoint;

    if (sTag == "axfell_portal")
    {
        sWaypoint = "axfell_prison_waypoint";
    }
    else if (sTag == "cleaven_portal")
    {
        sWaypoint = "cleaven_prison_waypoint";
    }
    else
    {
        DestroyObject(OBJECT_SELF);
    }

    if ((sTag == "axfell_portal" && HasItem(oUser, "cleavenmilitiari"))
        || (sTag == "cleaven_portal" && HasItem(oUser, "axfellwarriorrin")))
    {
        AssignCommand(oUser, ClearAllActions(TRUE));
        AssignCommand(oUser, JumpToObject(GetObjectByTag(sWaypoint)));
        DestroyObject(OBJECT_SELF);
    }
    else return;
}
