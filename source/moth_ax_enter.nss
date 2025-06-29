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
        object oTarget = GetObjectByTag("AxfellsWest");
        AssignCommand (oPC, JumpToObject(oTarget));
    }
    else
    {
        SendMessageToPC (oPC, "<c���>*A magical force prevents you from entering.</c>");
    }
}
