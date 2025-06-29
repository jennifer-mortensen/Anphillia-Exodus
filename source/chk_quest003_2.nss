//::///////////////////////////////////////////////
//:: FileName chk_quest003_2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/17/2004 2:52:49 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "FortSupplies"))
		return FALSE;

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "Axfell_Quest_003") == 1))
		return FALSE;

	return TRUE;
}
