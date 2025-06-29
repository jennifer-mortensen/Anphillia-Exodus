void main()
{

string sFail;
object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetGold(oPC) < 1000)
   {
   sFail="Not enough gold to rent the room.";

   SendMessageToPC(oPC, sFail);

   return;
   }

AssignCommand(oPC, TakeGoldFromCreature(1000, oPC, TRUE));

object oTarget;
oTarget = GetObjectByTag("BH_Room_4");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

}
