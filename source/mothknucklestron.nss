#include "nw_i0_spells"
#include "x2_i0_spells"
void main()
{
object oPC = GetPCSpeaker();
object oTarget = oPC;
object oMyWeapon = OBJECT_INVALID;
int nType = IP_CONST_DAMAGETYPE_POSITIVE;
effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WATER);
effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
int nDuration = GetLevelByClass(CLASS_TYPE_MONK,oPC);
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
        if(GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget)!=OBJECT_INVALID)
           {
           oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
           }
    }
if(GetIsObjectValid(oMyWeapon) )
{
SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
DelayCommand(1.0,FloatingTextStringOnCreature("<cðøþ>*Sensei's Knuckles Effect Applied!*</c>",oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon)));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration)));
DelayCommand(1.0,IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(nType,IP_CONST_DAMAGEBONUS_2d6),TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE));
return;
}
else
{
FloatingTextStringOnCreature("<cþ  >*This is not a valid target. The target must be a pair of gloves!*</c>", oPC);
return;
}
}

