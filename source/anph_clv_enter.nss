#include "hc_inc"
#include "anph_inc"

void main()
{
    int iTeam;
    object oPC;

    oPC = GetEnteringObject ();

    iTeam = AnphGetPlayerTeamInt (oPC);
    if (iTeam == 1)
    {
        object oTarget = GetObjectByTag("CleavenTunnelDoorEastInnerWaypt");
        AssignCommand (oPC, JumpToObject(oTarget));
    }
    else
    {
        SendMessageToPC (oPC, "A magical force prevents you from entering.");
    }
}
