#include "hc_inc"
#include "anph_inc"

int StartingConditional()
{
    int iFaction01 = 0;
    int iFaction02 = 0;
    int iFaction03 = 0;
    int iFaction04 = 0;
    int iFaction05 = 0;
    int iFaction06 = 0;
    int iFaction07 = 0;
    int iFaction08 = 0;
    int iFaction09 = 0;
    string sPCTeam;

    object oPC = GetFirstPC();
    while (GetIsObjectValid (oPC) == TRUE)
    {
        sPCTeam = AnphGetPlayerTeam (oPC);
        if (sPCTeam == GetLocalString(GetModule(), "FACTION_01_NAME"))
        {
            iFaction01++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_02_NAME"))
        {
            iFaction02++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_03_NAME"))
        {
            iFaction03++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_04_NAME"))
        {
            iFaction04++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_05_NAME"))
        {
            iFaction05++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_06_NAME"))
        {
            iFaction06++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_07_NAME"))
        {
            iFaction07++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_08_NAME"))
        {
            iFaction08++;
        } else if (sPCTeam == GetLocalString(GetModule(), "FACTION_09_NAME"))
        {
            iFaction09++;
        }
        oPC = GetNextPC ();
    }

    /* SetCustomToken(5550, IntToString(iFaction01));
    SetCustomToken(5551, IntToString(iFaction02));
    SetCustomToken(5552, IntToString(iFaction03));
    SetCustomToken(5553, IntToString(iFaction04));
    SetCustomToken(5554, IntToString(iFaction05));
    SetCustomToken(5555, IntToString(iFaction06));
    SetCustomToken(5556, IntToString(iFaction07));
    SetCustomToken(5557, IntToString(iFaction08));
    SetCustomToken(5558, IntToString(iFaction09)); */

    SetLocalInt(oMod, "FactionCount_01", iFaction01);
    SetLocalInt(oMod, "FactionCount_02", iFaction02);
    SetLocalInt(oMod, "FactionCount_03", iFaction03);
    SetLocalInt(oMod, "FactionCount_04", iFaction04);
    SetLocalInt(oMod, "FactionCount_05", iFaction05);
    SetLocalInt(oMod, "FactionCount_06", iFaction06);
    SetLocalInt(oMod, "FactionCount_07", iFaction07);
    SetLocalInt(oMod, "FactionCount_08", iFaction08);
    SetLocalInt(oMod, "FactionCount_09", iFaction09);

    int nFaction;
    int nCount = 0;
    string sMessage = "There are currently\n";
    for (nFaction = 1; nFaction < (ANPH_NUMBER_OF_FACTIONS + 1); nFaction++)
    {
       if (GetLocalInt(oMod, "FACTION_0" + IntToString(nFaction) + "_ACCESSIBLE_FOR_PLAYERS"))
       {
          if (nCount == 0)
          {
             sMessage = sMessage + ".) " + IntToString(GetLocalInt(oMod, "FactionCount_0" + IntToString(nFaction))) + " " + GetLocalString(oMod, "FACTION_0" + IntToString(nFaction) + "_NAME");
          }
          else
          {
             sMessage = sMessage + "\n.) " + IntToString(GetLocalInt(oMod, "FactionCount_0" + IntToString(nFaction))) + " " + GetLocalString(oMod, "FACTION_0" + IntToString(nFaction) + "_NAME");
          }
          nCount++;
       }
    }
    sMessage = sMessage + "\nonline. If you have any doubts on which side to join, it is best to pick the one with fewer warriors";
    SetCustomToken(5550, sMessage);

    DeleteLocalInt(oMod, "FactionCount_01");
    DeleteLocalInt(oMod, "FactionCount_02");
    DeleteLocalInt(oMod, "FactionCount_03");
    DeleteLocalInt(oMod, "FactionCount_04");
    DeleteLocalInt(oMod, "FactionCount_05");
    DeleteLocalInt(oMod, "FactionCount_06");
    DeleteLocalInt(oMod, "FactionCount_07");
    DeleteLocalInt(oMod, "FactionCount_08");
    DeleteLocalInt(oMod, "FactionCount_09");

    return TRUE;
}
