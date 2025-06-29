void main()
{
object oPC = GetPCSpeaker();
string sPC = GetName(oPC);
object oTarget = GetObjectByTag("mothcullis12");
object oTarget2 = GetObjectByTag("mothcullis13");
object oTarget3 = GetObjectByTag("mothcullis14");
DelayCommand(6.0, AssignCommand(oTarget, ActionOpenDoor(oTarget)));
DelayCommand(3.0, AssignCommand(oTarget2, ActionOpenDoor(oTarget2)));
DelayCommand(5.0, AssignCommand(oTarget3, ActionOpenDoor(oTarget3)));
DelayCommand(7.0, DestroyObject(oTarget));
DelayCommand(4.0, DestroyObject(oTarget2));
DelayCommand(6.0, DestroyObject(oTarget3));
DelayCommand(8.0,DestroyObject(OBJECT_SELF));
SetLocked(oTarget, FALSE);
SetLocked(oTarget2, FALSE);
SetLocked(oTarget3, FALSE);
FloatingTextStringOnCreature("<cýõæ>"+sPC+" managed to get the lockdown lifted!</c>", oPC);

}
