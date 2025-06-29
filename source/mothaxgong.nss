#include "anph_inc"

void AnphSendWarningCall4 (object oPC)
{
    string sPCTeam;
    string sTeam = AnphGetPlayerTeam (oPC);
    object oArea = GetArea (oPC);
    AnphSendMessageToTeam (sTeam, "<c  ¥>[Player] "+GetName(oPC)+" is calling for a Axfell meeting in "
                           +GetName(oArea)+"!</c>");

    SendMessageToAllDMs("*** " + GetName (oPC) + " (" + sTeam + ") hit the gong " + GetName (oArea) + "! ***");
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oPlayer;
    oPlayer = GetFirstPC ();
    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPlayer) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPlayer);
        if (sPCTeam == sTeam)
        {
            AssignCommand (oPlayer, PlaySound("as_cv_gongring2"));
        }
        oPlayer = GetNextPC ();
    }
}
void main()
{

  AnphSendWarningCall4(GetLastUsedBy());
}

