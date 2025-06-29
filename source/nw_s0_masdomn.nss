#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eDom = EffectDazed();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eLink = EffectLinkEffects(eMind, eDom);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    location lTarget = GetSpellTargetLocation();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = nCasterLevel/2;
    int nHD = nCasterLevel*3/2;
    int nCnt = 0;
    int nRacial;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nCasterLevel;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
            nRacial = GetRacialType(oTarget);
            if(nRacial == RACIAL_TYPE_ANIMAL)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                if(!ResistSpell(OBJECT_SELF, oTarget))
                {
                 ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*2));
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
            else
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                if(!ResistSpell(OBJECT_SELF, oTarget))
                {
                   if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF))
                   {
                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*2));
                   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                   }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL,lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}
