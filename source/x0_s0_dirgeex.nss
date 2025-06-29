#include "x2_inc_spellhook"
void main()
{

    object oTarget = GetExitingObject();
    object oCaster = GetAreaOfEffectCreator();
    if (oCaster == oTarget)
        return;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_DIRGE, oTarget))
    {
        DeleteLocalInt(oTarget, "X0_L_LASTPENALTY");
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) )
        {
            if (GetEffectCreator(eAOE) == oCaster)
            {
                if(GetEffectSpellId(eAOE) == SPELL_SPIKE_GROWTH)
                {
                    RemoveEffect(oTarget, eAOE);
                }
            }
            eAOE = GetNextEffect(oTarget);
        }
    }
}



