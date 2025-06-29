#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oCaster = GetAreaOfEffectCreator();
    int nDuration = MothGetCasterLevel(oCaster,SPELL_INCENDIARY_CLOUD);
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eSpeed = EffectAbilityDecrease(ABILITY_STRENGTH,4);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_YELLOW);
    effect eLink = eVis2;
    float fDelay;
    if (nDuration > 21)
    {
      nDuration = 21;
    }
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_INCENDIARY_CLOUD));
        if(!MyResistSpell(oCaster, oTarget, fDelay))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            nDamage = d8(nDuration);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = 8 * nDuration;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothFogDC(), SAVING_THROW_TYPE_FIRE, oCaster);
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            if(nDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(2)));
                RemoveEffectsFromSpell(oTarget, SPELL_INCENDIARY_CLOUD);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, oTarget, RoundsToSeconds(2)));
            }
        }
    }
}
