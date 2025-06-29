#include "X0_I0_SPELLS"
void main()
{
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oCaster); // * get a bonus of +10 to make this useful for arcane archer
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 10)
    {
        nCasterLvl = 10 + ((nCasterLvl-10)/2);
    }
    else
    {
         nCasterLvl = 10;
    }
    object oTarget = GetSpellTargetObject();
    if (GetIsObjectValid(oTarget ))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
          int nTouch = TouchAttackRanged(oTarget, TRUE);
          if (nTouch > 0)
          {
            nDamage = ArcaneArcherDamageDoneByBow(nTouch ==2);
            int  nBonus = ArcaneArcherCalculateBonus() ;
            effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,IPGetDamagePowerConstantFromNumber(nBonus));
            effect eMagic = EffectDamage(nBonus, DAMAGE_TYPE_MAGICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);
          }
        }
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) == TRUE)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d8(nCasterLvl);
                nDamage = MothGetReflexAdjustedDamageTrap(nDamage, oTarget, 18+nCasterLvl, SAVING_THROW_TYPE_FIRE);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}



