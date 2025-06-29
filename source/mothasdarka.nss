#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    effect eStun = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    effect eDamage;
    object oTarget;
    object oCreator;
    float fDelay;
    int nRounds;
    int nDamage;
    int nAssassin = GetLevelByClass(CLASS_TYPE_ASSASSIN,oCaster);
    int nInt = GetAbilityModifier(ABILITY_INTELLIGENCE,oCaster);
    int nDC = 18 + nAssassin + nInt;
    oTarget = GetEnteringObject();
    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
    {
      SignalEvent(oTarget, EventSpellCastAt(oCaster,606));
      if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE,oCaster))
        {
        if (GetIsImmune(oTarget, IMMUNITY_TYPE_BLINDNESS) == FALSE)
            {
             nDamage = d2(nAssassin)+nInt;
             eDamage = EffectDamage(nDamage,DAMAGE_TYPE_NEGATIVE);
             nRounds = 2+nInt;
             fDelay = GetRandomDelay(0.75, 1.75);
             DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
             DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(nRounds)));
             DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
           }
         }
    }
}
