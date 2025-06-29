void main()
{
    int nSpellID = 845;
    object oEffectCreator = GetAreaOfEffectCreator();
    object oTarget = GetExitingObject();
    effect eAoE;

    if(!GetHasSpellEffect(nSpellID, oTarget) || oTarget == oEffectCreator)
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
