#include "hc_inc"
#include "anph_persist_inc"

int StartingConditional()
{
    int iResult;

    if (GetAnphString (GetTag (OBJECT_SELF) + "_team") == "")
    {
        return TRUE;
    }

    return FALSE;
}
