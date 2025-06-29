#include "nw_i0_spells"
#include "x2_i0_spells"
#include "moth_inc_craftin"
void main()
{
object oPC = GetPCSpeaker();
object oTarget = oPC;
object oMyWeapon = OBJECT_INVALID;
effect eVis = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
int nCost = 75;
int nGold = GetGold(oPC);
int nDuration = GetLevelByClass(CLASS_TYPE_PALADIN,oPC) + GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC)/3+5;
int iBaseType;
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    iBaseType = GetBaseItemType(oMyWeapon);
    }
    else
    {
    iBaseType = GetBaseItemType(oTarget);
    if(IPGetIsMeleeWeapon(oTarget) || (!(iBaseType < 300 || iBaseType > 323)))
    oMyWeapon = oTarget;
    if (IPGetIsProjectile(oTarget))
    oMyWeapon = oTarget;
    else if (IPGetIsRangedWeapon(oTarget))
    oMyWeapon = oTarget;
    }
if(GetIsObjectValid(oMyWeapon) )
{
SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
MothCheckStones(oMyWeapon);
if (nDuration>0 && nGold>=nCost)
{
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
TakeGoldFromCreature(nCost,oPC,TRUE);
DelayCommand(1.0,FloatingTextStringOnCreature("<c ¥ >*Divine Touch Stone Effect Applied!*</c>",oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon)));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration)));
DelayCommand(1.0,AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyOnHitProps(IP_CONST_ONHIT_DOOM,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS),oMyWeapon,HoursToSeconds(nDuration)));
}
return;
}
else
{
FloatingTextStrRefOnCreature(83615, oPC);
return;
}
}


