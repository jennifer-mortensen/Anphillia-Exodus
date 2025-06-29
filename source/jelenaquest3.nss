#include "nw_i0_tool"
int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "jelenaquestitem"))
        return FALSE;
    return TRUE;
}

