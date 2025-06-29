#include "moth_inc"
void SE_RespawnDoor(object oSelf);
void SE_RespawnDoor(object oSelf)
{
    PlayAnimation(ANIMATION_DOOR_CLOSE);
    int nHealAmount = GetMaxHitPoints(oSelf) - GetCurrentHitPoints(oSelf);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHealAmount), oSelf);
}
void main()
{
        object oSelf = OBJECT_SELF;
        SetIsDestroyable(FALSE);
        //SetPlotFlag(oSelf,TRUE);
        float fDelay = GetLocalFloat(oSelf, "RESPAWN_TIMER");
        if(fDelay == 0.0)
        fDelay = fGateRespawnTime;
        DelayCommand(fDelay, SE_RespawnDoor(oSelf));
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
        WriteTimestampedLogEntry ("Gate Destroyed by:" + sPlayerName +", Handle:" + GetName(oPC)  +", CD KEY:" + sCDK);
        object oPC2 = GetFirstPC();
        while (GetIsObjectValid(oPC2))
        {
            AssignCommand (oPC2, PlaySound("as_an_wolfhowl1"));
            SendMessageToPC(oPC2, "<c  þ>[Faction] Cleavens have destroyed the Axfell Temple Door!</c>");
            oPC2 = GetNextPC();
        }
}
