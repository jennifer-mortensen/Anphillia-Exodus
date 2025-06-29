// Dependencies: ats_inc_common
#include "ats_inc_common"
void ATS_UpdateOldItems(object oPlayer)
{
    //Updates old malachite from v0.56 and v0.55
    if(GetItemPossessedBy(oPlayer, "ATS_R_GEM1_N_MAL") != OBJECT_INVALID)
    {
        object oCurrentItem = GetFirstItemInInventory(oPlayer);
        while(oCurrentItem != OBJECT_INVALID)
        {
            if(GetTag(oCurrentItem) == "ATS_R_GEM1_N_MAL")
            {
                DelayCommand(0.5, ATS_CreateItemOnPlayer("ats_r_gem1_n_mal", oPlayer,GetNumStackedItems(oCurrentItem)));
                DestroyObject(oCurrentItem);
            }
            oCurrentItem = GetNextItemInInventory(oPlayer);

        }

    }
}
//void main(){}
