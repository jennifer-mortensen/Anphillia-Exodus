#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"

//Waters Edge
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDamage = d6(nCasterLevel);
    int nDamStrike;
    int nNumAffected = 0;
    int nMetaMagic = GetMetaMagicFeat();
    effect eLightning = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND);;
    effect eVis  = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eDamage;
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
     if (nCasterLevel > 20)
    {
        nCasterLevel = (nCasterLevel-20)*2/3+20;
    }
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;
    }
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2);
    }
    if (spellsIsTarget(oFirstTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    {
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, 332));
        if (!MyResistSpell(OBJECT_SELF, oFirstTarget))
        {
            nDamStrike = MothGetReflexAdjustedDamage(nDamage, oFirstTarget, MothDC(), SAVING_THROW_TYPE_COLD);
            eDamage = EffectDamage(nDamStrike, DAMAGE_TYPE_COLD);
            if(nDamStrike > 0)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
            }
        }
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);
    eLightning = EffectBeam(VFX_BEAM_COLD, oFirstTarget, BODY_NODE_CHEST);
    float fDelay = 0.2;
    int nCnt = 0;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget) && nCnt < nCasterLevel)
    {
        if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 332));
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d6(nCasterLevel) ;

                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 6 * nCasterLevel;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                nDamStrike = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_COLD);
                eDamage = EffectDamage(nDamStrike /2, DAMAGE_TYPE_COLD);
                if(nDamStrike > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                }
            }
            oHolder = oTarget;
            if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
            eLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST);
            }
            else
            {
                effect eNewLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST);
                if(GetIsEffectValid(eNewLightning))
                {
                    eLightning =  eNewLightning;
                }
            }

            fDelay = fDelay + 0.1f;
        }
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nCnt++;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
      }
 }
