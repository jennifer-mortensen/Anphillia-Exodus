int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_DEXTERITY) > 32))
        return FALSE;
    return TRUE;
}
