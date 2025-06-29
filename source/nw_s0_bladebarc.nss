#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    object oTarget;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    int nMetaMagic = GetMetaMagicFeat();
    int nLevel = MothGetCasterLevel(oCaster);
    if (nLevel > 20)
    {
        nLevel = 20;
    }
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_DOOR);
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_BLADE_BARRIER));
            if (!MyResistSpell(oCaster, oTarget) )
            {
                int nDamage = d6(nLevel);
                if(nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nLevel * 6;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(),SAVING_THROW_TYPE_SPELL,oCaster))
                {
                    nDamage = nDamage/2;
                }
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_DOOR);
     }
}

