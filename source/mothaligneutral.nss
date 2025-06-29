int StartingConditional()
{
object oPC = GetPCSpeaker();
if (GetHitDice(oPC) >=  2) return FALSE;
if ((GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL &&
    GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL))
       return TRUE;
if ((GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL &&
    GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC))
       return TRUE;
if ((GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL &&
    GetAlignmentLawChaos(oPC) == ALIGNMENT_NEUTRAL))
       return TRUE;
return FALSE;
}

