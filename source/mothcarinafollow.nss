////////////////////////////////////////////////////
// Must be included in the OnClientEnter script
#include "nw_i0_plot"


void main()
{
    object oPC = GetEnteringObject();
    if (HasItem(oPC, "FollowThingie") == FALSE)
    {
        CreateItemOnObject("followthingie", oPC);
    }
}
