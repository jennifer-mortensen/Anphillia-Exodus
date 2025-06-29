void main()
{
object oMOD = GetModule();
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oMOD,"MothPuzzleMaelstrom3");
if (DoOnce==TRUE) return;
SetLocalInt(oMOD,"MothPuzzleMaelstrom3", TRUE);
DeleteLocalInt(oMOD,"MothPuzzleMaelstrom1");
DeleteLocalInt(oMOD,"MothPuzzleMaelstrom2");
DeleteLocalInt(oMOD,"MOTHAMBERTIMER");
object oMassOfWater = GetObjectByTag("mothmaelstromquest01");
object oWaterPortal = GetObjectByTag("mothmaelportal");
SetUseableFlag(oMassOfWater,TRUE);
DestroyObject(oWaterPortal);
}
