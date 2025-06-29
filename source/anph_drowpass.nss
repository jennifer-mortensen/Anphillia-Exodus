#include "hc_inc"
#include "anph_inc"

void main()
{
    object oPC = GetEnteringObject();
    if (AnphGetPlayerTeamInt(oPC) != 4)
       SendMessageToPC(oPC, "You can't see anything special about this wall");
       return;
}
