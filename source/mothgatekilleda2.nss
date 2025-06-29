#include "moth_inc"
void main()
{
        object oSelf = OBJECT_SELF;
        object oMod = GetModule();
        SetIsDestroyable(FALSE);
        float fDelay = GetLocalFloat(oSelf, "RESPAWN_TIMER");
        if(fDelay == 0.0)
        fDelay = fGateRespawnTime;
        DelayCommand(fDelay, MothRespawnGate(oSelf));
        SetLocalInt(oMod,"MOTHAXFGATEDOWN",1);
        DelayCommand(fDelay,DeleteLocalInt(oMod,"MOTHAXFGATEDOWN"));
        object oPC = GetLastKiller();
        string sCDK = GetLocalString(GetModule(), GetName(oPC) + "CDKey");
        string sPlayerName = GetLocalString(GetModule(), GetName(oPC) + "PlayerName");
        while (GetIsObjectValid(GetMaster(oPC)))
        {
           oPC=GetMaster(oPC);
        }
        if (!GetIsPC(oPC)) return;
        object oTarget;
        oTarget = OBJECT_SELF;
        AdjustReputation(oPC, oTarget, -100);
        WriteTimestampedLogEntry ("Inner Gate Destroyed by:" + sPlayerName +", Handle:" + GetName(oPC)  +", CD KEY:" + sCDK);
        object oPC2 = GetFirstPC();
        while (GetIsObjectValid(oPC2))
        {
            AssignCommand (oPC2, PlaySound("as_an_wolfhowl1"));
            SendMessageToPC(oPC2, "<c  þ>[Faction] Cleavens have destroyed the Axfell Inner Gate!</c>");
            oPC2 = GetNextPC();
        }
}
