#include "nw_i0_spells"
#include "x2_i0_spells"
#include "moth_inc_craftin"
void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = oPC;
    object oMyWeapon;
    effect eVis1 = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis3 = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetHitDice(oPC);
    int nRegen = nDuration/6;
    int nCostBase = 100;
    int nCostExtra = nDuration*10;
    int nCost = nCostBase+nCostExtra;
    int nGold = GetGold(oPC);
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
        if(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget)!=OBJECT_INVALID)
        {
         oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
        }
        else
        {
         FloatingTextStringOnCreature("<cþ  >*You need to have a item in your Main hand!*</c>", oPC);
         return;
        }
     }
     if(GetIsObjectValid(oMyWeapon))
     {
        if(nGold>=nCost)
        {
        MothCheckBloodlineFury(oMyWeapon);
        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
        TakeGoldFromCreature(nCost,oPC,TRUE);
        DelayCommand(1.0,FloatingTextStringOnCreature("<cþ  >*Bloodline Fury Activated!*</c>",oPC));
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon)));
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration)));
        DelayCommand(1.0,AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyVampiricRegeneration(nRegen),oMyWeapon,TurnsToSeconds(nDuration)));
        SetLocalInt(oMyWeapon,"MothBloodlineFury",TRUE);
        }
        else
        {
        FloatingTextStringOnCreature("<cþ  >*Not enough Gold!*</c>", oPC);
        return;
        }
      }
      else
      {
        FloatingTextStringOnCreature("<cþ  >*You need to have a item in your Main hand!*</c>", oPC);       return;
      }
}


