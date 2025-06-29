#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster)-2;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode1 = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisBad = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVisGood = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eDam, eHeal;
    int nModifer = 2;
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nModifer);
    effect eStr_Low = EffectAttackDecrease(nModifer,ATTACK_BONUS_MISC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eGood = EffectLinkEffects(eStr, eDur);
    effect eBad = EffectLinkEffects(eStr_Low, eDur2);
    if (nCasterLvl > 10)
    {
         nCasterLvl = (nCasterLvl-10) * 1 /4  + 10;
    }
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    while (GetIsObjectValid(oTarget))
    {
       if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
       {
            nDamage = d6(nCasterLvl);
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 6 * nCasterLvl;
            }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
               nDamage = nDamage + (nDamage / 2);
            }
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DOOM, FALSE));
                eHeal = EffectHeal(nDamage);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisGood, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGood, oTarget,TurnsToSeconds(nCasterLvl)));
            }
            else
            if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
            {
                if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                {
                    if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                    {
                        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DOOM));
                        if(MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF, fDelay))
                          {
                           nDamage /= 2;
                          }
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisBad, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBad, oTarget,RoundsToSeconds(nCasterLvl)));
                    }
                }
            }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
}
