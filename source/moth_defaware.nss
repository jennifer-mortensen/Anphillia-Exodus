#include "x2_i0_spells"
#include "x0_i0_spells"
#include "x2_inc_toollib"
void main()
{
        int nLevel = GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER);
        int nSave;
        int nImmunity = nLevel/3;
        nLevel = nLevel+3;
        if (nLevel < 11)
        {
            nSave = 2;
        }
        else
        {
            nSave = 3;
        }
        string sName = GetName(OBJECT_SELF);
        effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nSave);
        effect eCon = EffectAbilityIncrease(ABILITY_DEXTERITY, nSave);
        effect eSave1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,nImmunity);
        effect eSave2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,nImmunity);
        effect eSave3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,nImmunity);
        effect eSave = EffectLinkEffects(eSave1, eSave2);
        eSave = EffectLinkEffects(eSave, eSave3);
        effect eAC = EffectACIncrease(nSave);
        effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN);
        effect eLink = EffectLinkEffects(eCon, eStr);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eAC);
        eLink = EffectLinkEffects(eLink, eDur);
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        TLVFXPillar(VFX_IMP_AC_BONUS,GetLocation(OBJECT_SELF), 3, 0.0f, 1.0f);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
        DelayCommand(0.5,FloatingTextStringOnCreature("<c¼>*"+sName+" activates Defensive Awareness!*</c>",OBJECT_SELF));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nLevel*2)));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
}
