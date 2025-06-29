//evil bligth  793 demon hand
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
void RunHandImpactDemon(object oTarget, object oCaster)
{
    if (GZGetDelayedSpellEffectsExpired(793,oTarget,oCaster))
    {
        return;
    }
    effect eVis = EffectVisualEffect(475);
    DoSpellBreach(oTarget,1,3,793);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    DelayCommand(9.0f,RunHandImpactDemon(oTarget,oCaster));
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eKnockdown = EffectSpellFailure(nDuration/2,SPELL_SCHOOL_GENERAL);
    effect eVis = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eHand = EffectVisualEffect(475);
    effect eLink = EffectLinkEffects(eKnockdown, eVis);
    eLink = EffectLinkEffects(eLink, eHand);
    if (GetHasSpellEffect(793,oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE){return;}
    if(!MothGetIsFortAlly(oTarget))
    {
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink, oTarget,RoundsToSeconds(nDuration));
     RunHandImpactDemon(oTarget, OBJECT_SELF);
    }
}

