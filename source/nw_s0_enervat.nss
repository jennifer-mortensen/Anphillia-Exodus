#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eStr;
    int nStr;
    effect eVis2;
    effect eLink;
    if (nCasterLevel > 10)
    {
         nCasterLevel = (nCasterLevel-10) * 1 /4  + 10;
    }
    nCasterLevel = nCasterLevel;
    int nDamage = d6(nCasterLevel);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2)-10;
    }
    effect eVisa = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisb = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eVisc = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
    effect eVis = EffectLinkEffects(eVisa,eVisb);
    eVis = EffectLinkEffects(eVis,eVisc);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eRay = EffectBeam(VFX_BEAM_DISINTEGRATE, OBJECT_SELF, BODY_NODE_HAND);
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERVATION));
            eRay = EffectBeam(VFX_BEAM_DISINTEGRATE, OBJECT_SELF, BODY_NODE_HAND);
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_NEGATIVE))
                {
                    nStr = d2()+1;
                    eStr = EffectAbilityDecrease(ABILITY_STRENGTH, nStr);
                    nDamage = nDamage*2;
                    eVis2 = EffectVisualEffect(VFX_IMP_DOOM);
                    eLink = EffectLinkEffects(eStr, eVis2);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(nCasterLevel));
                }
                effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
        }
    }
    else
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERVATION, FALSE));
        eRay = EffectBeam(VFX_BEAM_DISINTEGRATE, OBJECT_SELF, BODY_NODE_HAND);
        effect eHeal = EffectHeal(nDamage*2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}
