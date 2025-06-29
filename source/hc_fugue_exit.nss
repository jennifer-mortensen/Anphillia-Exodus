#include "tk_hips_inc"
#include "spawn_functions"
void main()
{
    object oPC=GetExitingObject();
    SetLocalInt (oPC, "FromFugue", 1);
    SetPlotFlag(oPC,FALSE);
    WriteTimestampedLogEntry ("Fugue Saving all characters...");
    ExportAllCharacters ();
    WriteTimestampedLogEntry ("Fugue Saving Complete.");
    SetLocalInt(oPC, "HIPS_PSEUDOBEAT_RUNNING", FALSE);
    DelayCommand(3.0, TK_HiPS_OnFeatChange(oPC));

    //if(!GetIsPC(oPC))
    //    return;
    //Spawn_OnAreaExit();
}
