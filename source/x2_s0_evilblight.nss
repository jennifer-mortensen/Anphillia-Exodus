#include "X0_I0_SPELLS"
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
    effect eExplode1 = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    effect eExplode3 = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    eExplode = EffectLinkEffects(eExplode,eExplode3);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eDam;
    effect eDisease = ExtraordinaryEffect(EffectCurse(3,3,3,3,3,3));
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 10)
    {
         nCasterLvl = (nCasterLvl-10) * 1 /4  + 10;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    nDamage = d4(nCasterLvl);
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 4 * nCasterLvl;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage / 2;
                    }
                    nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_NONE);
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                    if(nDamage > 0)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
                    {
                    if (!GetHasSpellEffect(GetSpellId(), oTarget))
                        {
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisease, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        }
                    }
                 }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}


