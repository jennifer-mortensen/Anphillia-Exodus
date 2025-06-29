void main()
{
object oPC = GetEnteringObject();
if (GetItemPossessedBy(oPC, "mothphobosheart")== OBJECT_INVALID)
   return;
object oDoor;
oDoor = GetObjectByTag("phobosdoor2");
DelayCommand(0.2,ActionUnlockObject(oDoor));
DelayCommand(0.3,ActionOpenDoor(oDoor));
DelayCommand(0.4,SetLocked(oDoor, FALSE));
DelayCommand(1.3,DestroyObject(OBJECT_SELF));
SendMessageToPC(oPC,"The Golem Essence glow for a second then emits a pulse. The Force field is now down.");
}

