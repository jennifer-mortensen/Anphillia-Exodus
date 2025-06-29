#include "torch_combo"
void main()
{
    object oPC = GetLastUsedBy();
    if(StartingConditional()){
        SendMessageToPC(oPC, "You hear a distinct clicking sound in the wall, and then silence again");
    }
    DestroyObject(OBJECT_SELF, 0.0);
}
