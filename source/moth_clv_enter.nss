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
        object oTarget = GetObjectByTag("FortCleavensEast");
        AssignCommand (oPC, JumpToObject(oTarget));
    }
    else
    {
        SendMessageToPC (oPC, "<cðøþ>*A magical force prevents you from entering.</c>");
    }
}
