int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetAbilityScore(oPC, ABILITY_INTELLIGENCE) >= 19)) return FALSE;
return TRUE;
}
