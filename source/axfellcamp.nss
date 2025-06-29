#include "nw_i0_generic"
void main()
{
object oPC = GetItemActivator();
if (GetIsObjectValid(GetItemActivatedTarget())
|| GetIsInCombat(oPC))
{SendMessageToPC(oPC, "<cðøþ>*A camp cannot be made now!*</c>");return;}
if (GetLocalInt(oPC,"MothCamper")==TRUE){return;}
location lTarget = GetItemActivatedTargetLocation();
object oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "campfr001", lTarget);
location lTarget1 = GenerateNewLocationFromLocation(lTarget,3.0,0.0,10.0);
object oSpawn1 = CreateObject(OBJECT_TYPE_PLACEABLE, "mothbedroll", lTarget1);
location lTarget2 = GenerateNewLocationFromLocation(lTarget,3.0,75.0,75.0);
object oSpawn2 = CreateObject(OBJECT_TYPE_PLACEABLE, "mothtent", lTarget2);
location lTarget3 = GenerateNewLocationFromLocation(lTarget,1.0,150.0,150.0);
object oSpawn3 = CreateObject(OBJECT_TYPE_PLACEABLE, "mothaxflag", lTarget3);
location lTarget4 = GenerateNewLocationFromLocation(lTarget,3.0,175.0,175.0);
object oSpawn4 = CreateObject(OBJECT_TYPE_PLACEABLE, "mothtent2", lTarget4);
location lTarget5 = GenerateNewLocationFromLocation(lTarget,3.0,250.0,250.0);
object oSpawn5 = CreateObject(OBJECT_TYPE_PLACEABLE, "mothbedroll", lTarget5);
SetLocalInt(oPC,"MothCamper",TRUE);
DelayCommand(HoursToSeconds(5),DeleteLocalInt(oPC,"MothCamper"));
DelayCommand(HoursToSeconds(5),DestroyObject(oSpawn));
DelayCommand(HoursToSeconds(5),DestroyObject(oSpawn1));
DelayCommand(HoursToSeconds(5),DestroyObject(oSpawn2));
DelayCommand(HoursToSeconds(5),DestroyObject(oSpawn3));
DelayCommand(HoursToSeconds(5),DestroyObject(oSpawn4));
DelayCommand(HoursToSeconds(5),DestroyObject(oSpawn5));

}

