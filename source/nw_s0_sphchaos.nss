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
    int nDamage;
    int nDuration = nCasterLvl/2;
    float fDelay;
    effect eExplode1 = EffectVisualEffect(VFX_FNF_MASS_MIND_AFFECTING);
    effect eExplode2 = EffectVisualEffect(481);
    effect eExplode3 = EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    eExplode = EffectLinkEffects(eExplode,eExplode3);
    effect eVis1 = EffectVisualEffect(VFX_IMP_STARBURST_RED);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NIGHTMARE_HEAD_HIT);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eBlindness = EffectBlindness();
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    if (nCasterLvl > 20)
    {
        nCasterLvl = (nCasterLvl-20)*2/3+20;
    }
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
                nDamage = d8(nCasterLvl);
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_CHAOS, OBJECT_SELF, fDelay))
                {
                   if(!GetHasSpellEffect(GetSpellId(),oTarget))
                     {
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlindness, oTarget,6.0));
                     }
                }
                else
                {
                 nDamage = nDamage/2;
                }
                eDam = EffectDamage(nDamage+nMothBonus3, DAMAGE_TYPE_MAGICAL);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay+0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay+0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

