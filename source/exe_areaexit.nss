#include "spawn_functions"

void main()
{
    object oPC = OBJECT_SELF;
    if(!GetIsPC(oPC))
        return;
    Spawn_OnAreaExit();
}
