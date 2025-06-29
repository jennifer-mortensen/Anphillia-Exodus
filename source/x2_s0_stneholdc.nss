#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"

void main()
{
   /*
    //Declare major variables
    int nRounds;
    int nMetaMagic = GetMetaMagicFeat();
    effect eHold = EffectParalyze();
    effect eDur = EffectVisualEffect(476 );
    eHold = EffectLinkEffects(eDur, eHold);
    effect eFind;
    object oTarget;
    object oCreator;
    float fDelay;

    //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // When the caster is no longer there, all functions calling
    // GetAreaOfEffectCreator will fail.
    //--------------------------------------------------------------------------
    if (!GetIsObjectValid(GetAreaOfEffectCreator()))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_STONEHOLD));
            if (!GetHasSpellEffect(SPELL_STONEHOLD,oTarget))
            {
                if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothFogDC(), SAVING_THROW_TYPE_MIND_SPELLS,oCaster))
                    {
                       nRounds = MaximizeOrEmpower(6, 1, nMetaMagic);
                       fDelay = GetRandomDelay(0.75, 1.75);
                       DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHold, oTarget, RoundsToSeconds(nRounds)));
                    }
                }
            }
        }
        oTarget = GetNextInPersistentObject();
    }*/
}
