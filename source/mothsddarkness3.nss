#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    //Declare major variables
    int nRounds;
    int nDC = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,GetAreaOfEffectCreator())+21;
    effect eStun = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    effect eFind;
    object oTarget;
    object oCreator;
    float fDelay;
    if (!GetIsObjectValid(GetAreaOfEffectCreator()))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, GetAreaOfEffectCreator()))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DARKNESS));
                if (!GetHasSpellEffect(SPELL_DARKNESS,oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget,nDC, SAVING_THROW_TYPE_NONE))
                    {
                        if (GetIsImmune(oTarget, IMMUNITY_TYPE_BLINDNESS) == FALSE)
                        {
                            nRounds = 2;
                            fDelay = GetRandomDelay(0.75, 1.75);
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(nRounds)));
                        }
                    }
                }
        }
        oTarget = GetNextInPersistentObject();
    }
}
