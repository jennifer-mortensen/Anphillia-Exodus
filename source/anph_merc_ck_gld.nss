
#include "nw_i0_tool"

int StartingConditional()
{
    object oMarker;
    string sMercTeam;

    oMarker = GetObjectByTag (GetTag (OBJECT_SELF) + "Marker");

    if (GetGold (GetPCSpeaker ()) >= GetMaxHitPoints (oMarker))
    {
        return TRUE;
    }

    return FALSE;
}
