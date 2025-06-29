/****************************************************
  Forge OnUsed Script
  ats_forge_use

  Last Updated: August 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script goes on the forge's OnUsed trigger.
  It locks the forge if the forge is already
  being used.
****************************************************/
#include "ats_inc_common"

void main()
{
    object oForge = OBJECT_SELF;
    string sLastOpener = GetLocalString(oForge, "ats_last_opener");
    object oLastUser = GetLastUsedBy();
    object oLastOpenerObject = GetLocalObject(oForge, "ats_last_opener_object");

    if((GetIsObjectValid(oLastOpenerObject) == FALSE) ||
       (sLastOpener == ATS_GetUniquePlayerID(oLastUser)) ||
       (GetIsOpen(oForge) == FALSE && IsInConversation(oForge) == FALSE))
    {
        SetLocked(oForge, FALSE);
    }
    else
    {
        FloatingTextStringOnCreature("The forge is already in use.", oLastUser, FALSE);
        SetLocked(oForge, TRUE);
    }
}
