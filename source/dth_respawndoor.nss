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
        object oPC = GetLastKiller();
        while (GetIsObjectValid(GetMaster(oPC)))
        {
           oPC=GetMaster(oPC);
        }
        if (!GetIsPC(oPC)) return;
        object oTarget;
        oTarget = OBJECT_SELF;
        AdjustReputation(oPC, oTarget, -100);
}
