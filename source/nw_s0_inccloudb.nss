void main()
{
    object oTarget = GetExitingObject();
    object oCaster = GetAreaOfEffectCreator();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_INCENDIARY_CLOUD, oTarget))
    {
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE)
        {
            if (GetEffectCreator(eAOE) == oCaster)
            {
                if(GetEffectType(eAOE) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
                {
                    if(GetEffectSpellId(eAOE) == SPELL_INCENDIARY_CLOUD)
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

