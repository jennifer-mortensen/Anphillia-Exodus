#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_shifter"
void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    object oCaster = GetAreaOfEffectCreator();
    int nDamage;
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nDC = MothFogDC()+1;
    if(GetAppearanceType(oCaster) == 428 || GetAppearanceType(oCaster) == 429)
    {
     nCasterLvl = GetHitDice(oCaster);
     nDC = ShifterGetSaveDC(oCaster,SHIFTER_DC_HARD,TRUE)+6;
    }
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_WALL_OF_FIRE));
            if(!MyResistSpell(oCaster, oTarget))
            {
                nDamage = d3(nCasterLvl);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = nCasterLvl*3;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget,nDC, SAVING_THROW_TYPE_FIRE,oCaster);
                if(nDamage > 0)
                {
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 1.0);
                }
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
