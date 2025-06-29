#include "hc_inc"
#include "anph_inc"

void main()
{
    string sTeam;
    object oPC;

    oPC = GetEnteringObject ();

    sTeam = AnphGetPlayerTeam (oPC);
    if (sTeam == "Axfell")
    {
        object oTarget = GetObjectByTag("AxfellCouncilHallSouth");
        AssignCommand (oPC, JumpToObject(oTarget));
    }
    else
    {
        SendMessageToPC (oPC, "A magical force prevents you from entering.");
    }
}
