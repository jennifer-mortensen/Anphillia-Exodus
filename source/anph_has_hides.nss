//::///////////////////////////////////////////////
//:: FileName anph_has_fbb
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/3/2002 3:14:05 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "AnimalHide"))
        return FALSE;

    return TRUE;
}
