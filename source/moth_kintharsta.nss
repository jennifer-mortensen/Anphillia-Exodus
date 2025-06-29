#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLevel/4;
    int nDamStrike;
    int nMetaMagic = GetMetaMagicFeat();
    int nBeam;
    int nImpact;
    int nDamageType;
    int nSave;
    int nDice = d8();
    if(nDice==1)
    {
      nBeam = VFX_BEAM_LIGHTNING;
      nImpact = VFX_IMP_LIGHTNING_S;
      nDamageType = DAMAGE_TYPE_ELECTRICAL;
      nSave = SAVING_THROW_TYPE_ELECTRICITY;
    }
    else if(nDice==2)
    {
      nBeam = VFX_BEAM_FIRE;
      nImpact = VFX_IMP_FLAME_S;
      nDamageType = DAMAGE_TYPE_FIRE;
      nSave = SAVING_THROW_TYPE_FIRE;
    }
    else if(nDice==3)
    {
      nBeam = VFX_BEAM_COLD;
      nImpact = VFX_IMP_FROST_L;
      nDamageType = DAMAGE_TYPE_COLD;
      nSave = SAVING_THROW_TYPE_COLD;
    }
    else if(nDice==4)
    {
      nBeam = VFX_BEAM_HOLY;
      nImpact = VFX_COM_HIT_DIVINE;
      nDamageType = DAMAGE_TYPE_DIVINE;
      nSave = SAVING_THROW_TYPE_DIVINE;
    }
    else if(nDice==5)
    {
      nBeam = VFX_BEAM_MIND;
      nImpact = VFX_IMP_MAGBLUE;
      nDamageType = DAMAGE_TYPE_MAGICAL;
      nSave = SAVING_THROW_TYPE_SPELL;
    }
    else if(nDice==6)
    {
      nBeam = VFX_BEAM_EVIL;
      nImpact = VFX_IMP_NEGATIVE_ENERGY;
      nDamageType = DAMAGE_TYPE_NEGATIVE;
      nSave = SAVING_THROW_TYPE_NEGATIVE;
    }
    else if(nDice==7)
    {
      nBeam = VFX_BEAM_DISINTEGRATE;
      nImpact = VFX_IMP_STARBURST_GREEN;
      nDamageType = DAMAGE_TYPE_POSITIVE;
      nSave = SAVING_THROW_TYPE_POSITIVE;
    }
    else
    {
      nBeam = VFX_BEAM_ODD;
      nImpact = VFX_IMP_SONIC;
      nDamageType = DAMAGE_TYPE_SONIC;
      nSave = SAVING_THROW_TYPE_SONIC;
    }
    effect eLightning = EffectBeam(nBeam, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(nImpact);
    effect eDamage;
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    if (nCasterLevel > 10)
    {
         nCasterLevel = (nCasterLevel-10) * 1 /4  + 10;
    }
    int nDamage = d6(nCasterLevel) + nBonus;
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel + nBonus;
    }
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2);
    }
    if (spellsIsTarget(oFirstTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    {
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        if (!MyResistSpell(OBJECT_SELF, oFirstTarget))
        {
            nDamStrike = MothGetReflexAdjustedDamage(nDamage, oFirstTarget, MothDC(), nSave);
            eDamage = EffectDamage(nDamStrike, nDamageType);
            if(nDamStrike > 0)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
            }
        }
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);
    eLightning = EffectBeam(nBeam, oFirstTarget, BODY_NODE_CHEST);
    float fDelay = 0.2;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d6(nCasterLevel) + nBonus;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = 6 * nCasterLevel + nBonus;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                nDamStrike = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), nSave);
                eDamage = EffectDamage(nDamStrike /2, nDamageType);
                if(nDamStrike > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                }
            }
            oHolder = oTarget;
            eLightning = EffectBeam(nBeam, oHolder, BODY_NODE_CHEST);
            fDelay = fDelay + 0.1f;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
      }
 }

