#include "moth_inc"
#include "zep_inc_phenos2"
#include "_inc_db"

void main()
{
    object oPC = GetExitingObject();
    object aRelic = GetItemPossessedBy(oPC, "axfellrelic");
    object cRelic = GetItemPossessedBy(oPC, "cleavenrelic");
    object oChannelMember;
    object oMod = GetModule();
    string sName = GetName(oPC);
    int relicStatus = GetLocalInt(oMod,"Relic_Status");
    string sStaffId = GetLocalString(oPC, "STAFF_MEMBER");

    MothRemovePolymorph(oPC);
    zep_Dismount(oPC);
    ExportSingleCharacter(oPC);
    SaveVirtualExperience(oPC);
    SetLocalInt(oMod, GetPlayerDatabaseName(oPC) + sName + "CURRENT_HIT_POINTS", GetCurrentHitPoints(oPC)); //Store on the module since we can't store variables on an exiting object.

    //J. Persinne; Staff and DM Channel Handling
    if(GetLocalInt(oPC, "STAFF_CHANNEL_ENABLED") == TRUE)
    {
        oChannelMember = GetFirstPC();
        while(oChannelMember != OBJECT_INVALID)
        {
            if(GetLocalInt(oChannelMember, "STAFF_CHANNEL_ENABLED") == TRUE && oChannelMember != oPC)
            {
                SendMessageToPC(oChannelMember, "<cÍ]]>" + GetName(oPC) + " (" + sStaffId + ") has left the staff channel.</c>");
            }
            oChannelMember = GetNextPC();
        }
    }
    if(GetLocalInt(oPC, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(oPC))
    {
        oChannelMember = GetFirstPC();
        while(oChannelMember != OBJECT_INVALID)
        {
            if((GetLocalInt(oChannelMember, "DM_CHANNEL_ENABLED") == TRUE || GetIsDM(oChannelMember)) && oChannelMember != oPC)
            {
                SendMessageToPC(oChannelMember, "<c ¿þ>" + GetName(oPC) + " (" + sStaffId + ") has left the DM channel.</c>");
            }
            oChannelMember = GetNextPC();
        }
    }
    //End Staff and DM Channel Handling
    ExecuteScript("exe_nwnxchatext", oPC); //NWNX Chat Handler

    //Relic handling
    switch(relicStatus)
    {

        case 1:
            if (GetIsObjectValid (aRelic)){
                SetLocalInt(oMod, "Relic_Status", 0);
                SetCustomToken(901, "<c þ >Safe"); // Axfell green is safe
                DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Axfell has recovered their relic!</c>");
                    aPC = GetNextPC();
                }

            }
        case 2:
            if (GetIsObjectValid (cRelic)){
                SetLocalInt(oMod, "Relic_Status", 0);
                SetCustomToken(900, "<c þ >Safe"); // Cleaven green is safe
                DeleteLocalInt(GetModule(), "MOTHCLVRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction]Cleaven has recovered their relic!</c>");
                    aPC = GetNextPC();
                }
            }
            break;

        case 5:
            if (GetIsObjectValid (aRelic)){
                SetLocalInt(oMod, "Relic_Status", 3);
                SetCustomToken(901, "<c þ >Safe"); // Axfell green is safe
                SetCustomToken(900, "<cþ  >Stolen"); // Cleaven red is stolen
                DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
                DeleteLocalInt(GetModule(), "MOTHCLVRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Axfell has recovered both relics!</c>");
                    aPC = GetNextPC();
                }
            }
            if (GetIsObjectValid (cRelic)){
                SetLocalInt(oMod, "Relic_Status", 3);
            }
            break;
        case 6:
            if (GetIsObjectValid (aRelic)){
                SetLocalInt(oMod, "Relic_Status", 4);
                SetCustomToken(901, "<cþ  >Stolen"); // Axfell red is stolen
                SetCustomToken(900, "<c þ >Safe"); // Cleaven green is safe
                DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
                DeleteLocalInt(GetModule(), "MOTHCLVRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Cleaven has recovered both relics!</c>");
                    aPC = GetNextPC();
                }
            }
            if (GetIsObjectValid (cRelic)){
                SetCustomToken(901, "<cþ  >Stolen"); // Axfell red is stolen
                SetCustomToken(900, "<c þ >Safe"); // Cleaven green is safe
                SetLocalInt(oMod, "Relic_Status", 4);
            }
            break;
    }
    //End relic handling
}
