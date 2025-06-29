#include "hc_inc"
#include "anph_persist_inc"

int StartingConditional()
{

    if (GetAnphString (GetTag (OBJECT_SELF) + "_team") == "")
    {
        return FALSE;
    }

    return TRUE;
}
