void main()
{
object oPC=GetLastSpeaker();
AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 1000.0));
if (GetGender(oPC)==GENDER_MALE){PlaySound("as_pl_yawningm1");}
else if (GetGender(oPC)==GENDER_FEMALE){PlaySound("as_pl_yawningf1");}
}
