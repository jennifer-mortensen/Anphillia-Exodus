#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"

void RunAcidArrowImpact(object oTarget, object oCaster, int nMetamagic);

void main()
{
    object oTarget = GetSpellTargetObject();

    if(GetTag(oTarget) == "ASSAULT_LADDER_SPRINGBOARD")
        oTarget = GetLocalObject(oTarget, "MY_LADDER");

    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = (MothGetCasterLevel(OBJECT_SELF)/5);
    int nDamage;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2;
    }
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    effect eVis      = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eDur      = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eArrow = EffectVisualEffect(245);
    eDur = ExtraordinaryEffect(eDur);
    if (GetIsReactionTypeFriendly(oTarget) == FALSE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        float fDist = GetDistanceToObject(oTarget);
        float fDelay = (fDist/25.0);


        if(MyResistSpell(OBJECT_SELF, oTarget) == FALSE)
        {
             nDamage = d6(nDuration);
             if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                 nDamage = 6 * nDuration;
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                 nDamage = nDamage + nDamage / 2;
                }
            effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay+0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay+3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay+3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(nDuration)));
            object oSelf = OBJECT_SELF;
            DelayCommand(6.0f,RunAcidArrowImpact(oTarget, oSelf,nMetaMagic));
        }
        else
        {
            effect eSmoke = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
            DelayCommand(fDelay+0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oTarget));
        }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);

}
void RunAcidArrowImpact(object oTarget, object oCaster, int nMetaMagic)
{
    if (GZGetDelayedSpellEffectsExpired(SPELL_MELFS_ACID_ARROW,oTarget,oCaster))
    {
        return;
    }
    if (GetIsDead(oTarget) == FALSE)
    {
        int nDamage = MaximizeOrEmpower(6,3,nMetaMagic);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
        effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
        eDam = EffectLinkEffects(eVis,eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f,RunAcidArrowImpact(oTarget,oCaster,nMetaMagic));
    }
}

