#include "hc_inc_helper"
void main()
{
    SendMessageToPC(OBJECT_SELF,"That player is banned until server restart.");
    SendMessageToAllDMs(GetName(OBJECT_SELF)+" just banned "+GetName(oMyTarget));
    SetLocalInt(oMod,"BANNED"+GetPCPublicCDKey(oMyTarget),TRUE);
    BootPC(oMyTarget);
}
