#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    object oCaster = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    int nMetaMagic = GetMetaMagicFeat();
    int nLevel = MothGetCasterLevel(oCaster);
    if (nLevel > 20)
    {
        nLevel = 20;
    }
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_BLADE_BARRIER));
        int nDamage = d6(nLevel);
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = nLevel * 6;
        }
        else if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2);
        }
        if (!MyResistSpell(oCaster, oTarget) )
        {
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(),SAVING_THROW_TYPE_SPELL,oCaster))
            {
                nDamage = nDamage/2;
            }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}

