#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eConfuse = EffectConfused();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    float fDelay;
    effect eLink = EffectLinkEffects(eMind, eConfuse);
    eLink = EffectLinkEffects(eLink, eDur);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    location lSpell = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/25;
    TLVFXPillar(VFX_FNF_LOS_NORMAL_20,lSpell, 1, fDelay1, 6.0f, 2.0f);
    TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 1, fDelay1+0.4, 6.0f, 2.0f);
    DelayCommand(0.1,TLVFXPillar(VFX_FNF_HOWL_WAR_CRY_FEMALE,lSpell, 1, 0.0f, 1.2f));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact,lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lSpell);
    while (GetIsObjectValid(oTarget))
    {
        if (MothGetIsFortAlly(oTarget)==FALSE)
        {
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CONFUSION));
           fDelay = GetRandomDelay();
           if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
           {
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                {
                   ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
                   nDuration = GetScaledDuration(MothGetCasterLevel(OBJECT_SELF), oTarget);
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lSpell);
    }
}

