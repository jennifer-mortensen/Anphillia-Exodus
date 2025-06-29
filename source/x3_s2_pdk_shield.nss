#include "x0_i0_spells"
void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nDuration = (nChr*5)+1;
    int nAC = nCasterLevel/2;
    int nBonus = nAC+2;
    if (GetLocalInt(oPC, "PDKHeroicTracking"))
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You can only use this ability once every 6 Turns!</c>");
        return;
    }
    if (oPC == oTarget)
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot aid yourself using this ability!</c>");
        return;
    }
    if (MothGetIsFortAlly(oTarget)==FALSE)
    {
        SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot aid an enemy using this ability!</c>");
        return;
    }
    if(GetObjectType(oTarget)!=OBJECT_TYPE_CREATURE)
    {
         SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot target an object</c>");
         return;
    }
    if(!LineOfSightObject(oPC,oTarget)){return;}
    effect eAC = EffectACIncrease(nBonus);
    eAC = ExtraordinaryEffect(eAC);
    effect eVFX = EffectVisualEffect(VFX_IMP_PDK_HEROIC_SHIELD);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 807, FALSE));
    RemoveEffectsFromSpell(oTarget, 807);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(495), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_RALLYING_CRY), oTarget);
    SetLocalInt(oPC, "PDKHeroicTracking", TRUE);
    DelayCommand(TurnsToSeconds(6), DeleteLocalInt(oPC, "PDKHeroicTracking"));
    DelayCommand(TurnsToSeconds(6), FloatingTextStringOnCreature("<cðøþ>*Heroic Shield Focus Regained!*</c>",oPC,FALSE));
}
