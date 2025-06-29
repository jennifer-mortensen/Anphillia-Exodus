#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "_inc_gen"
#include "_inc_subrace"
void main()
{
    int nRounds;
    object oCaster = GetAreaOfEffectCreator();
    effect eStun = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    object oTarget;
    object oCreator;
    float fDelay;
    int nDC = MothFogDC()+4;
    int nHostile = SPELL_TARGET_STANDARDHOSTILE;

    oTarget = GetEnteringObject();
    if(spellsIsTarget(oTarget, nHostile, oCaster) && !GetIfLightBlindnessApplies(oTarget))
    {
            SignalEvent(oTarget, EventSpellCastAt(oCaster,SPELL_DARKNESS));
                if(!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SPELL,oCaster))
                {
                    if (GetIsImmune(oTarget, IMMUNITY_TYPE_BLINDNESS) == FALSE)
                    {
                        nRounds = 3;
                        fDelay = GetRandomDelay(0.75, 1.75);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(nRounds)));
                    }
                }

    }
}
