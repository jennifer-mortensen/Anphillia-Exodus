#include "moth_inc"
void main()
{
        object oSelf = OBJECT_SELF;
        SetIsDestroyable(FALSE);
        float fDelay = GetLocalFloat(oSelf, "RESPAWN_TIMER");
        if(fDelay == 0.0)
        fDelay = fGateRespawnTime;
        DelayCommand(fDelay, MothRespawnGate(oSelf));
}
