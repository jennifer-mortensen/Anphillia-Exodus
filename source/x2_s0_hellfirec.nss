/*#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{


    //Declare major variables
    //Get the object that is exiting the AOE
    object oTarget = GetExitingObject();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(761, oTarget))
    {
        //The main script sets this int to the origin of the AoE. If this is the
        //Origin, they are disabled from leaving it.
        //VvVvV If added by Rabidness VvVvV
        if( GetLocalObject(oTarget , "oProtFireSource") == oTarget )
            return;

        //Search through the valid effects on the target.
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE))
        {
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator())
            {
                //If the effect was created by the AOE then remove it
                if(GetEffectSpellId(eAOE) == 761)
                {
                    RemoveEffect(oTarget, eAOE);
                    //only dispell one, this is to prevent a stacked group of
                    //AoEs all being dispelled by exiting one.
                    //VvV Rabidness addition VvV
                    return;
                }
            }
            //Get next effect on the target
            eAOE = GetNextEffect(oTarget);
        }
    }
}
