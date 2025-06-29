/****************************************************
  Forge OnOpen Script
  ats_forge_open

  Last Updated: August 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script goes on the forge's OnOpen trigger.
  It locks the forge to prevent others from using it
  at the same time.
****************************************************/
#include "ats_inc_common"

void main()
{
    object oPlayer = GetLastOpenedBy();
    object oForge = OBJECT_SELF;

    SetLocalString(oForge, "ats_last_opener", ATS_GetUniquePlayerID(oPlayer));
    SetLocalObject(oForge, "ats_last_opener_object", oPlayer);
    SetLocked(oForge, TRUE);
}
