//hc_dc_heartbeat
//Archaegeo June 27, 2002
// Called by the Death Corpse itself.
// Deletes the corpse if empty and gives items back if player is alive.

#include "hc_inc"
#include "hc_inc_transfer"

void main()
{
    object oDC=OBJECT_SELF;
    int i = 0;

    object oItem = GetFirstItemInInventory (oDC);
    if  (GetIsObjectValid (oItem))
    {
        return;
    }

    DestroyObject (oDC);
}
