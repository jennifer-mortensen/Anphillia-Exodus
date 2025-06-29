#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
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
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    effect eDaze = EffectDazed();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDaze);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_CHARM));
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if(!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    DelayCommand(fDelay, MothCharmPenalty(oTarget,OBJECT_SELF,SPELL_MASS_CHARM));
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
                    {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLvl/3));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}









