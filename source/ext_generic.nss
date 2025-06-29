#include "spawn_functions"

void main()
{
    object oPC = GetExitingObject();
    if(!GetIsPC(oPC))
        return;
    Spawn_OnAreaExit();
}
