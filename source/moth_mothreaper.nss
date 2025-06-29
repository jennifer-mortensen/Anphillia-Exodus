#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamageBonus = nCasterLevel/2;
    int nDamage = d3(nCasterLevel)+nDamageBonus;
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 3 * nCasterLevel+nDamageBonus;
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2);
    }
    TLVFXPillar(VFX_IMP_DEATH_WARD,GetLocation(OBJECT_SELF), 3, 0.0f, 2.0f);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        if(!MothGetIsFortAlly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_NEGATIVE, OBJECT_SELF))
                {
                  nDamage = nDamage-20;
                }
                TLVFXPillar(VFX_IMP_EVIL_HELP, GetLocation(oTarget), 3, 0.0f, 3.0f);
                TLVFXPillar(VFX_IMP_HEAD_EVIL, GetLocation(oTarget), 3, 0.0f, 2.0f);
                RemoveEffectsFromSpell(oTarget, SPELL_IMPROVED_INVISIBILITY);
                RemoveEffectsFromSpell(oTarget, SPELLABILITY_EMPTY_BODY);
                RemoveEffectsFromSpell(oTarget, SPELL_DISPLACEMENT);
                RemoveEffectsFromSpell(oTarget, SPELL_PROTECTION__FROM_CHAOS);
                RemoveEffectsFromSpell(oTarget, SPELL_GHOSTLY_VISAGE);
                RemoveEffectsFromSpell(oTarget, SPELL_ETHEREAL_VISAGE);
                effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
        }
    }
    else
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        effect eHeal = EffectHeal(nDamage);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}




