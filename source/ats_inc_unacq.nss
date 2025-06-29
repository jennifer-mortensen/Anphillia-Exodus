#include "ats_inc_nodrop"

void ATS_OnUnAcquireItem(object oItemLost, object oLostBy, object oAcquiredFrom)
{
    object oPlayer = GetLocalObject(oItemLost, "ats_obj_possessor");
    if(GetIsObjectValid(oPlayer) == FALSE)
        oPlayer = oAcquiredFrom;
//    ATS_CheckForRemovedNoDropItems(oPlayer, oItemLost);

}
