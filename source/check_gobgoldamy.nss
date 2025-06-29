//::///////////////////////////////////////////////
//:: FileName check_gobgoldamy
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/23/2004 7:27:20 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "mothgoldammy"))
        return FALSE;

    return TRUE;
}
