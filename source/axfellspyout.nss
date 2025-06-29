void main()
{
object oPC = GetEnteringObject();
    if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        return;
    }
    if (GetLocalInt(oPC,"ismothspy") == TRUE)
    {
    object oTarget = GetWaypointByTag("mirrorspyhome");
    location lTarget = GetLocation(oTarget);
    AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(781,oPC,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
    SetCutsceneMode(oPC,TRUE,FALSE);
    DelayCommand(20.0,SetCutsceneMode(oPC,FALSE,FALSE));
    DelayCommand(20.1,AssignCommand(oPC, ClearAllActions()));
    DelayCommand(20.2,AssignCommand(oPC, JumpToLocation(lTarget)));
    }
    else{}
}

