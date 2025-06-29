#include "spawn_main"

void main()
{
object oPC = GetExitingObject();
object oTake1 = GetItemPossessedBy(oPC,"mothtelebugbear");
if(GetIsObjectValid(oTake1))
  {
    DestroyObject(oTake1);
    SendMessageToPC(oPC,"<cþ¥ >The Teleporter vanishes from your backpack!</c>");
  }
    Spawn_OnAreaExit();
}
