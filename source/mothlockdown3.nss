int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetAbilityScore(oPC, ABILITY_INTELLIGENCE) >= 15)) return FALSE;
return TRUE;
}
