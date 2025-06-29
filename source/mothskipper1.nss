int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetAbilityScore(oPC, ABILITY_DEXTERITY) >= 30)) return FALSE;

return TRUE;
}
