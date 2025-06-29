#include "x2_inc_toollib"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eHit;
    effect eVis;
    effect eDur;
    effect eDam;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nLevel = nDuration/3;
    int nHD;
    location lSpell = GetSpellTargetLocation();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    float fDelay = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_HOWL_MIND,lSpell, 1, fDelay, 2.0f, 0.5f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact,lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lSpell);
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetDistanceBetweenLocations(lSpell, GetLocation(oTarget))/20;
        nDamage = d2(nLevel);
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
           {
            nDamage = 2 * nLevel;
           }
        if (nMetaMagic == METAMAGIC_EMPOWER)
           {
            nDamage = nDamage + (nDamage/2);
           }
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
        nHD = GetHitDice(oTarget);
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(),SAVING_THROW_TYPE_MIND_SPELLS))
            {
            if(nHD<6)
            {
            eHit = EffectSleep();
            eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            eDur = EffectVisualEffect(VFX_DUR_PIXIEDUST);
            }
            else
            {
            eHit = EffectDazed();
            eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
            eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
            }
            effect eLink = EffectLinkEffects(eHit, eDur);
            if(!GetIsImmune(oTarget,IMMUNITY_TYPE_SLEEP && !GetHasFeat(FEAT_IMMUNITY_TO_SLEEP,oTarget)))
              {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
              }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lSpell);
    }
}

