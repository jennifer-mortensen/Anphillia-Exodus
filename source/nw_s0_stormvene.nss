#include "X0_I0_SPELLS"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    if(!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    object oTarget = GetEnteringObject();;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eDamageAcid;
    effect eDamageElectrical;
    effect eStun = EffectStunned();
    float fDelay;
    int nCasterLevel = MothGetCasterLevel(oCaster);
    int nDamageDiceAcid = 3;
    int nDamageDiceElectrical = 6;

    if(nCasterLevel > 20)
    {
        nDamageDiceAcid += (nCasterLevel - 20) * 1/3;
        nDamageDiceElectrical += (nCasterLevel - 20) * 1/3;
    }

    if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_STORM_OF_VENGEANCE));
        fDelay = GetRandomDelay(0.5, 2.0);
        if(!MyResistSpell(oCaster, oTarget, fDelay))
        {
            eDamageAcid = EffectDamage(d6(nDamageDiceAcid), DAMAGE_TYPE_ACID);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamageAcid, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(), SAVING_THROW_TYPE_NONE, oCaster, fDelay))
            {
                eDamageElectrical = EffectDamage(d6(nDamageDiceElectrical), DAMAGE_TYPE_ELECTRICAL);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamageElectrical, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(2)));
            }
        }
    }
}
