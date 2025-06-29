#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetExitingObject();
    effect eAOE;
    if(GetHasSpellEffect(SPELL_ENTANGLE, oTarget))
    {
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE))
        {
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator())
            {
                if(GetEffectType(eAOE) == EFFECT_TYPE_ENTANGLE)
                {
                    if(GetEffectSpellId(eAOE) == SPELL_ENTANGLE)
                    {
                        RemoveEffect(oTarget, eAOE);
                    }
                }
            }
            eAOE = GetNextEffect(oTarget);
        }
    }
}

