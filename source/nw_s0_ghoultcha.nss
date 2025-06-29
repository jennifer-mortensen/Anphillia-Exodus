#include "NW_I0_SPELLS"
#include "x2_inc_shifter"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nDC = MothFogDC();
    //If Demonflesh Golem
    if(GetAppearanceType(oCaster) == 468)
    {
      nCasterLvl = GetHitDice(oCaster);
      nDC = ShifterGetSaveDC(oCaster,SHIFTER_DC_HARD,TRUE)+9;
    }
    int nDecrease = nCasterLvl/5 + 1;
    object oTarget = GetEnteringObject();
    effect eVis1 = EffectVisualEffect(VFX_IMP_DOOM);
    effect eVis2 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eAttack = EffectAttackDecrease(nDecrease);
    effect eDamage = EffectDamageDecrease(nDecrease);
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, nDecrease);
    effect eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nDecrease);
    effect eDur = EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLUE);
    effect eLink = EffectLinkEffects(eDamage, eSave);
    eLink = EffectLinkEffects(eLink, eSave);
    eLink = EffectLinkEffects(eLink, eSkill);
    eLink = EffectLinkEffects(eLink, eDur);
    if(!MothGetIsFortAlly(oTarget) && oTarget != oCaster)
    {
        if(!MyResistSpell(oCaster, oTarget) && !MySavingThrow(SAVING_THROW_FORT, oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oCaster))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLvl/2));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}


