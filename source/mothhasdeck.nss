#include "nw_i0_tool"
int StartingConditional()
{
    if(HasItem(GetPCSpeaker(), "mothdeck"))
        return FALSE;

    return TRUE;
}
