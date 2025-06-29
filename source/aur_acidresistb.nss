void main()
{
    int nSpellID = 841;
    object oEffectCreator = GetAreaOfEffectCreator();
    object oTarget = GetExitingObject();
    effect eAoE;

    if(oTarget == oEffectCreator || !GetHasSpellEffect(nSpellID, oTarget))
        return;
    else
    {
        eAoE = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eAoE))
        {
            if(GetEffectSpellId(eAoE) == nSpellID)
            {
                RemoveEffect(oTarget, eAoE);
                return;
            }
            eAoE = GetNextEffect(oTarget);
        }
    }
}
