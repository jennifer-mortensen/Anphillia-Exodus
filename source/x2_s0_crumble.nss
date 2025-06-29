#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster)+3;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode1= EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eExplode2= EffectVisualEffect(VFX_FNF_PWKILL);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    effect eVis1= EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eVis2= EffectVisualEffect(234);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 28)
    {
        nCasterLvl = 28;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CRUMBLE));
            fDelay = GetRandomDelay(0.5, 1.5);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                if(GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
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
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget));
                }
                if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
                {
                    nDamage = d6(nCasterLvl);
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 6 * nCasterLvl;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage/2;
                    }
                    if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                    {
                        nDamage = nDamage/2;
                    }
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    }
}

