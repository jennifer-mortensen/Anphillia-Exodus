#include "x2_inc_itemprop"
#include "X2_inc_switches"
void main()
{
  object oItem   = GetSpellCastItem();
  object oPC     = OBJECT_SELF;
  object oTarget = GetSpellTargetObject();
  string sTag    = GetTag(oItem);
  if (oTarget == OBJECT_INVALID || GetObjectType(oTarget) != OBJECT_TYPE_ITEM)
  {
       FloatingTextStringOnCreature("<c ¥ >*Invalid Target!*</c>",oPC);
       return;
  }
  int nType = GetBaseItemType(oTarget);
  if (IPGetItemHasItemOnHitPropertySubType(oTarget, 19))
  {
       FloatingTextStringOnCreature("<c ¥ >*You can only have one Poison-effects per item!*</c>",oPC);
       return;
  }
  int nRow = StringToInt(GetStringRight(sTag,3));
  if (nRow ==0)
  {
     FloatingTextStringOnCreature("<c ¥ >*Coating failed!*</c>",oPC);
     WriteTimestampedLogEntry ("Error: Item with tag " +GetTag(oItem) + " has the PoisonWeapon spellscript attached but tag does not contain 3 letter receipe code at the end!");
     return;
  }
   int nSaveDC     =  StringToInt(Get2DAString(X2_IP_POISONWEAPON_2DA,"SaveDC",nRow));
   int nDuration   =  7;
   int nPoisonType =  StringToInt(Get2DAString(X2_IP_POISONWEAPON_2DA,"PoisonType",nRow)) ;
   int nApplyDC    =  StringToInt(Get2DAString(X2_IP_POISONWEAPON_2DA,"ApplyCheckDC",nRow)) ;
   string sRow     =  GetStringLeft(sTag,9);
   if (sRow =="MothVenom")
   {
    FloatingTextStringOnCreature("<c þ >*Crafted Poisons have an extended Duration!*</c>",oPC);         //"Nothing happens
    nDuration = nDuration*2;
   }
   int bHasFeat = GetHasFeat(960, oPC);
   if (!bHasFeat)
   {
       AssignCommand(oPC,ClearAllActions(TRUE));
       if (GetModuleSwitchValue(MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT) == TRUE)
       {
            FloatingTextStringOnCreature("<c ¥ >*Coating failed!*</c>",oPC);
            return;
       }

       int nDex = GetAbilityModifier(ABILITY_DEXTERITY,oPC) ;
       int nCheck = d10(1)+14+nDex;
       if (nCheck < nApplyDC)
       {
            FloatingTextStringOnCreature("<c ¥ >*Coating failed!*</c>",oPC);
            return;
       }
       else
       {
            FloatingTextStringOnCreature("<c ¥ >*Coating succeeded!*</c>",oPC);
       }
   }
   else
   {
       FloatingTextStringOnCreature("<c ¥ >*Auto Success!*</c>",oPC);
    }
   itemproperty ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,nSaveDC,nPoisonType);
   effect eVis = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
   if(IPGetItemHasItemOnHitPropertySubType(oTarget,19)==TRUE)
      {
       nDuration=0;
       FloatingTextStringOnCreature("<c ¥ >*You can only have one Poison-effects per item!*</c>",oPC);
      }
   if(nDuration>0)
     {
       AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,TurnsToSeconds(nDuration));
       FloatingTextStringOnCreature("<c ¥ >*Your weapon is coated with Poison!*</c>",oPC,FALSE);
       IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_ACID),TurnsToSeconds(nDuration),X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,FALSE);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oTarget));
     }
   else
   {
       FloatingTextStringOnCreature("<c ¥ >*Coating failed!*</c>",oPC);
       return;
   }
}
