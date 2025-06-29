int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC &&
       GetHitDice(oPC)>5
    )
        return TRUE;
    else return FALSE;
}
