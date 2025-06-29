#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    object oTarget = GetExitingObject();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(532, oTarget))
    {
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE)
        {
            if (GetEffectCreator(eAOE) == oCaster)
            {
                if(GetEffectType(eAOE) == EFFECT_TYPE_SKILL_INCREASE)
                {
                    if(GetEffectSpellId(eAOE) == 532)
                    {
                        RemoveEffect(oTarget, eAOE);
                        bValid = TRUE;
                    }
                }
            }
            eAOE = GetNextEffect(oTarget);
        }
    }
}
