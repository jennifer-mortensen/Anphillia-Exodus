#include "spawn_functions"
void main()
{
    object oPC=GetExitingObject();
    if(GetIsPC(oPC))
    {
        int nSubdual = GetLocalInt(oPC, "PREVIOUS_SUBDUAL_MODE");
        SetLocalInt(oPC, "SUBDUAL", nSubdual);
        switch(nSubdual)
        {
            case 0:
                DelayCommand(3.0, FloatingTextStringOnCreature("<cþŒ >*Full Damage Mode Activated*</c>", oPC, FALSE));
                DelayCommand(3.0, SendMessageToPC(oPC, "<c¥¥¥>[Server] You are now in Full Damage Mode.</c>"));
                break;
            case 1:
                DelayCommand(3.0, FloatingTextStringOnCreature("<cþŒ >*Subdual Mode Activated*</c>", oPC, FALSE));
                DelayCommand(3.0, SendMessageToPC(oPC, "<c¥¥¥>[Server] You are now in Subdual Mode.</c>"));
                break;
        }
        DeleteLocalInt(oPC, "PREVIOUS_SUBDUAL_MODE");
    }
    if(!GetIsPC(oPC))
        return;
    Spawn_OnAreaExit();
}
