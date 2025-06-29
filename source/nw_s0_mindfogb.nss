void main()
{
    object oTarget = GetExitingObject();
    object oCaster = GetAreaOfEffectCreator();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_MIND_FOG, oTarget))
    {
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE)
        {
            if (GetEffectCreator(eAOE) == oCaster)
            {
                if(GetEffectType(eAOE) == EFFECT_TYPE_SAVING_THROW_DECREASE)
                {
                    if(GetEffectSpellId(eAOE) == SPELL_MIND_FOG)
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
