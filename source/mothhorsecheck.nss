#include "nw_i0_plot"
int StartingConditional()
{
    int nPassed = 0;
    object oPC = GetPCSpeaker();
    if(GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC) <= 9 ||
       GetLevelByClass(CLASS_TYPE_PALADIN, oPC) <= 4
    )
    {
      if(HasItem(oPC,"horsetoken"))
      {
       nPassed = 1;
      }
    }
    if(nPassed == 0)
        return FALSE;
    return TRUE;
}
