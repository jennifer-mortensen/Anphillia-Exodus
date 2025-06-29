#include "X0_I0_SPELLS"
#include "moth_inc_spell2"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    object oCaster = GetAreaOfEffectCreator();
    int nDuration = MothGetCasterLevel(oCaster);
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
      if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
      {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, 327));
        if(!MyResistSpell(oCaster, oTarget))
        {
            nDamage = d4(nDuration);
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_SPELL, oCaster))
            {
              //MothImmobilize(oTarget,oCaster,327,nDuration/4);
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oTarget, RoundsToSeconds(nDuration / 4)); //J. Persinne; Changed to entangle effect.
            }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            if(nDamage > 0)
            {
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
              MothBloodyVisual(oTarget);
            }
        }
      }
    }
}
