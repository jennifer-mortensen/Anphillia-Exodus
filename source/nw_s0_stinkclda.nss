
#include "X0_I0_SPELLS"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oCaster = GetAreaOfEffectCreator();
    int nDuration = MothGetCasterLevel(oCaster);
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eSpeed = EffectPoison(POISON_BLACK_LOTUS_EXTRACT);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
    effect eLink = eVis2;
    float fDelay;
    if (nDuration > 21)
    {
      nDuration = 21;
    }
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_STINKING_CLOUD));
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
            if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_ACID, oCaster, fDelay))
            {
             nDamage = nDamage/2;
            }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            if(nDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(2)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpeed, oTarget));
            }
        }
    }
}
