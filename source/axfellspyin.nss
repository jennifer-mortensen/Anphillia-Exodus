void main()
{
object oPC = GetPCSpeaker();
object oTarget = GetWaypointByTag("axfellspy1");
location lTarget = GetLocation(oTarget);
SetLocalInt(oPC,"ismothspy",TRUE);
AssignCommand(oPC, ClearAllActions());
DelayCommand(0.2, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
AssignCommand(OBJECT_SELF,ActionCastSpellAtObject(781,oPC,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
}
