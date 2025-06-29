#include "moth_inc_tracker"
#include "spawn_functions"
void main()
{
  object oPC = GetExitingObject();
  if(GetIsPC(oPC)==TRUE)
  {
  MothWoodlandExit(oPC);

  }
    if(!GetIsPC(oPC))
        return;
    Spawn_OnAreaExit();
}
