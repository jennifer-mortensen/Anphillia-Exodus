#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "moth_inc_spell2"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eLinka = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MAJOR);
    effect eLinkb = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR);
    effect eLinkc = EffectAbilityIncrease(ABILITY_STRENGTH,2);
    effect eLink = EffectLinkEffects(eLinka, eLinkb);
    eLink = EffectLinkEffects(eLink, eLinkc);
    effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_1d8, DAMAGE_TYPE_MAGICAL);
    int nDuration = MothGetCasterLevel(OBJECT_SELF)*3;
    int nMetaMagic = GetMetaMagicFeat();
    TLVFXPillar(VFX_IMP_SPELL_MANTLE_USE,GetLocation(OBJECT_SELF), 4, 0.3f, 1.8f);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration+5));
    DelayCommand(1.4,MothSetFavoredDamage(nDuration,eDamage,OBJECT_SELF));
}
