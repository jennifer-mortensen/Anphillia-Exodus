#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_shifter"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nDC = MothFogDC()+1;
    if(GetAppearanceType(oCaster) == 428 || GetAppearanceType(oCaster) == 429)
    {
     nCasterLvl = GetHitDice(oCaster);
     nDC = ShifterGetSaveDC(oCaster,SHIFTER_DC_HARD,TRUE)+6;
    }
    int nDamage;
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_WALL_OF_FIRE));
        if(!MyResistSpell(oCaster, oTarget))
        {
                nDamage = d4(nCasterLvl);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = nCasterLvl*4;
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
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
}
