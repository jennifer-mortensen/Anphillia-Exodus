#include "nw_i0_tool"
int StartingConditional()
{
    if(HasItem(GetPCSpeaker(), "motharbiter1"))
      {
        return TRUE;
      }
    return FALSE;
}
