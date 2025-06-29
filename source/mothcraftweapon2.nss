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
int nCost = 2000;
int nGold = GetGold(oPC);
int nDuration = GetLevelByClass(CLASS_TYPE_FIGHTER,oPC);
int iBaseType;
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    if(MatchShield(oMyWeapon)==FALSE){nDuration=0;}
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if(IPGetIsMeleeWeapon(oMyWeapon)==FALSE){nDuration=0;}
   }
if(GetIsObjectValid(oMyWeapon) )
{
if (nDuration>0 && nGold>=nCost)
{
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
TakeGoldFromCreature(nCost,oPC,TRUE);
DelayCommand(1.0,AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_KNOCKDOWN,40),oMyWeapon,TurnsToSeconds(nDuration)));
DelayCommand(1.0,FloatingTextStringOnCreature("<cڥ#>*Automatic Knockdown Applied!*</c>",oPC));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon)));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration)));
}
else
{
FloatingTextStrRefOnCreature(83615, oPC);
return;
}
}
}

