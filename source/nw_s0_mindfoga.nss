#include "X0_I0_SPELLS"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oCaster = GetAreaOfEffectCreator();
    int nDuration = MothGetCasterLevel(oCaster);
    effect eDam;
    object oTarget;
    int nSave = nDuration/6 + 1;
    effect eVis = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eSpeed = EffectSavingThrowDecrease(SAVING_THROW_WILL,nSave,SAVING_THROW_TYPE_ALL);
    eSpeed = ExtraordinaryEffect(eSpeed);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_BLUE);
    effect eLink = eVis2;
    float fDelay;
    if (nDuration > 21)
    {
      nDuration = 21;
    }
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_MIND_FOG));
        if(!MyResistSpell(oCaster, oTarget, fDelay))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            nDamage = d6(nDuration);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = 6 * nDuration;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
            if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_SPELL, oCaster, fDelay))
            {
             nDamage = nDamage/2;
            }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            if(nDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(2)));
                RemoveEffectsFromSpell(oTarget, SPELL_MIND_FOG);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpeed, oTarget, RoundsToSeconds(2)));
            }
        }
    }
}
