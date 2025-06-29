#include "nw_i0_tool"
int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "BugbearCrowbar"))
        return FALSE;
    return TRUE;
}
