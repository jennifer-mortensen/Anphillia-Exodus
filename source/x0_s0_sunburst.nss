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
    int nDamage = 0;
    int nDC = MothDC();
    float fDelay;
    float nSize =  RADIUS_SIZE_COLOSSAL;
    effect eExplode = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eHitVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eLOS = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 25)
    {
        nCasterLvl = 25;
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLOS, GetSpellTargetLocation());
    int bDoNotDoDamage = FALSE;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBURST));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                    nDamage = MaximizeOrEmpower(6, nCasterLvl+5, nMetaMagic);
                }
                else
                {
                    nDamage = MaximizeOrEmpower(6, 6, nMetaMagic);
                }
                if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_MALE || GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_FEMALE || GetStringLowerCase(GetSubRace(oTarget)) == "vampire" )
                {
                    if (!ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_SPELL))
                    {
                        effect eDead = EffectDamage(GetCurrentHitPoints(oTarget));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, oTarget);
                        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oTarget));
                        bDoNotDoDamage = TRUE;
                    }
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_SPELL);
                if ((nDamage > 0) && (bDoNotDoDamage == FALSE))
                {
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    if (!ReflexSave(oTarget, MothDC(), SAVING_THROW_TYPE_SPELL))
                    {
                        effect eBlindness = EffectBlindness();
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlindness, oTarget);
                    }
                }
             }
             bDoNotDoDamage = FALSE;
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

