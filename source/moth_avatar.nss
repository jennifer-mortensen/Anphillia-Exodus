#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nSpell = GetSpellId();
    int nDamage, nDamageType, nSave, nFnF, nFnF2, nImp, nImp2;
    if(nSpell == 490)
    {
     nDamageType = DAMAGE_TYPE_COLD;
     nSave = SAVING_THROW_TYPE_COLD;
     nFnF = VFX_FNF_MYSTICAL_EXPLOSION;
     nFnF2 = VFX_FNF_HOWL_MIND;
     nImp = VFX_IMP_FROST_L;
     nImp2 = VFX_IMP_FROST_S;
    }
    if(nSpell == 491)
    {
     nDamageType = DAMAGE_TYPE_FIRE;
     nSave = SAVING_THROW_TYPE_FIRE;
     nFnF = VFX_FNF_FIREBALL;
     nFnF2 = VFX_FNF_HOWL_ODD;
     nImp = VFX_IMP_FLAME_M;
     nImp2 = VFX_IMP_FLAME_S;
    }
    if(nSpell == 492)
    {
     nDamageType = DAMAGE_TYPE_ELECTRICAL;
     nSave = SAVING_THROW_TYPE_ELECTRICITY;
     nFnF = VFX_FNF_ELECTRIC_EXPLOSION;
     nFnF2 = VFX_FNF_SOUND_BURST_SILENT;
     nImp = VFX_IMP_LIGHTNING_S;
     nImp2 = VFX_IMP_HEAD_ELECTRICITY;
    }
    int nDuration = nCasterLvl/2;
    float fDelay;
    effect eExplode1 = EffectVisualEffect(nFnF);
    effect eExplode2 = EffectVisualEffect(481);
    effect eExplode3 = EffectVisualEffect(nFnF2);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    eExplode = EffectLinkEffects(eExplode,eExplode3);
    effect eVis1 = EffectVisualEffect(nImp);
    effect eVis2 = EffectVisualEffect(nImp2);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 20)
    {
        nCasterLvl = (nCasterLvl-20)*2/3+20;
    }
    if(nCasterLvl > 32) //J. Persinne; failsafe in case caster level ends up bugged; this prevents some NPCs from dealing ~500 damage with avatar.
        nCasterLvl = 32;

    int nDC = MothDC();
    if(nDC > 100)
        nDC = 45;

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                nDamage = d10(nCasterLvl);
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, nSave);
                eDam = EffectDamage(nDamage+nMothBonus3, nDamageType);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay+0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay+0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

