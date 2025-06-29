#include "nw_i0_tool"
int StartingConditional()
{
    if(HasItem(GetPCSpeaker(), "mothlizardquest1"))
      {
        return TRUE;
      }
    return FALSE;
}
