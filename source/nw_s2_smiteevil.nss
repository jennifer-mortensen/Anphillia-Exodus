#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    effect eVis = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    float fRandom1 = GetRandomDelay();
    float fRandom2 = GetRandomDelay();
    float fRandom3 = GetRandomDelay();
    float fRandom4 = GetRandomDelay();
    float fRandom5 = GetRandomDelay();
    location lTarget1 = GenerateNewLocationFromLocation(lTarget,5.0+fRandom1,0.0+fRandom1,10.0+fRandom1);
    location lTarget2 = GenerateNewLocationFromLocation(lTarget,5.0+fRandom3,150.0+fRandom3,150.0+fRandom3);
    location lTarget3 = GenerateNewLocationFromLocation(lTarget,5.0+fRandom5,250.0+fRandom5,250.0+fRandom5);
    TLVFXPillar(VFX_FNF_LOS_HOLY_20, lTarget,3,0.0f);
    TLVFXPillar(VFX_FNF_LOS_HOLY_30, lTarget1,3,0.0f);
    TLVFXPillar(VFX_FNF_LOS_HOLY_30, lTarget2,3,0.0f);
    TLVFXPillar(VFX_FNF_LOS_HOLY_30, lTarget3,3,0.0f);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetRandomDelay(1.5, 2.5);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    nDamage = d10(nCasterLvl);
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 10 * nCasterLvl;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage / 2;
                    }
                    if(GetIsPC(oTarget)==TRUE)
                    {
                      if(MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, fDelay))
                        {
                            nDamage = nDamage/2;
                        }
                    }
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
}

