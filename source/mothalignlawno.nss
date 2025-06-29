int StartingConditional()
{
object oPC = GetPCSpeaker();
if ((GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)!=0)||
    (GetLevelByClass(CLASS_TYPE_BARD, oPC)!=0)||
    (GetLevelByClass(CLASS_TYPE_DRUID, oPC)!=0))
return FALSE;
return TRUE;
}
