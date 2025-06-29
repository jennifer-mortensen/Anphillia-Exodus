//::///////////////////////////////////////////////
//:: FileName anph_has_nuts
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/22/2002 4:08:29 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(GetIsObjectValid (GetItemPossessedBy (GetPCSpeaker(), "magicnuts")))
        return TRUE;

    return FALSE;
}
