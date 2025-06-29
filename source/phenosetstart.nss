#include "x2_i0_spells"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetHasEffect(EFFECT_TYPE_POLYMORPH, oPC) == TRUE)
    {
        return FALSE;
    }
    if(GetPhenoType(oPC)!=PHENOTYPE_NORMAL &&
       GetPhenoType(oPC)!=PHENOTYPE_BIG
    )
    {
        return FALSE;
    }
    else return TRUE;
}
