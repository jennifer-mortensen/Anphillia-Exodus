#include "nw_i0_spells"
#include "x2_i0_spells"
#include "ats_inc_common"
#include "ats_const_common"
// * Applies various temporary weapon buffs. Note that Touchstones and Monk Ki bonuses
//are handled by seperate induvidual scripts since itemproperty ItemPropertyOnHitProps
//must be constants.
void MothWeaponBuff(int nCost=250,
                    int nType=IP_CONST_DAMAGETYPE_BLUDGEONING,
                    int nDmg=IP_CONST_DAMAGEBONUS_1,
                    int nSpecial=FALSE,
                    int nAmmo=FALSE,
                    string sFeedback="",
                    int nClass=CLASS_TYPE_FIGHTER);
// * Changes appearances on simple items
// Modifies simple items to a next or previous appearance.
//
// nChange - Use nChange to set how many steps you wish to jump in the set appearance list(string s2da).
// Negative values in nChange will cycle back. Zero does nothing.
//
// nSlot - Set which inventory slot should be used (INVENTORY_SLOT_*)
//
// s2da - Set which 2da you wish to fetch the appearances from. Must match with the slot the item belongs to.
// Only used for objects that grant appearance changes outside the inventory.
//
// nReset - If set TRUE, this will restore the item to its initial state.
//
// If called with unmodified settings, this function will change the appearance of a cloak to the next appearance.
void MothSetNextOrPreviousSimpleItem(int nReset=FALSE,int nChange=0,int nSlot=INVENTORY_SLOT_CLOAK,string s2da="cloakmodel");
// * Returns TRUE if oItem is a Simple item.
int MothGetIsSimpleItem(object oItem);
// * Returns TRUE if nSlot is a creature item slot that can hold Simple Items.
int MothGetIsSimpleItemSlot(int nSlot);
// * Returns TRUE is the nRow value in s2da string is above 0, which means it has a model drawn ingame.
int MothGetIsAppearanceValid(int nRow,string s2da);
// * Sets appearance of oItem if it's a Simple Item.
void MothSetSimpleItemAppearance(object oPC,object oItem,int nNext,string sName,int nSlot,string s2da);
// * Wrapper to hold various settings,checks for changing apprearances of Simple Items.
void MothSetNextOrPreviousSimpleItem(int nReset=FALSE,int nChange=0,int nSlot=INVENTORY_SLOT_CLOAK,string s2da="cloakmodel");
// * Instant setting of Cloaks to non-appearance Cloaks.
void MothHideCloak();
// * Handles nonstacking of Touchstones.
void MothCheckStones(object oMyWeapon);
// * Handles nonstacking of Bloodlinefury
void MothCheckBloodlineFury(object oMyWeapon);
// * Returns TRUE if oItem is clohtes.
//This check will only work correctly if oItem is an Armor.
//Gets the armors weight, so it's not 100% reliable.
int MothGetIsClothing(object oItem);
// * Removes temp effect from an item.
void MothRemoveItemTempEffect(object oMyWeapon);
// * Returns FALSE if Bullrush Charge cannot be initiated.
int MothFighterBullrushChargeChecks(object oUser,object oTarget);
// * Returns FALSE if Tornado Charge cannot be initiated.
int MothFighterTornadoChargeChecks(object oUser,object oTarget);
// * Returns FALSE ifCThrustharge cannot be initiated.
int MothFighterThrustChecks(object oUser,object oTarget);
// * Handles the appliance of Tornado Charge.
void MothTornadoCharge(object oPC);
// *  return TRUE if oItem is an Armor. Includes Creature Armor (Hides).
int MothIPGetIsArmor(object oItem);

void MothWeaponBuff(int nCost=250,
                    int nType=IP_CONST_DAMAGETYPE_BLUDGEONING,
                    int nDmg=IP_CONST_DAMAGEBONUS_1,
                    int nSpecial=FALSE,
                    int nAmmo=FALSE,
                    string sFeedback="",
                    int nClass=CLASS_TYPE_FIGHTER)
{
    object oPC = GetPCSpeaker();
    object oTarget = oPC;
    object oWeapon = OBJECT_INVALID;
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nGold = GetGold(oPC);
    int nDuration = (GetLevelByClass(nClass,oPC) + 3) *2;
    int nBaseWeapon;
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
          if(GetItemInSlot(INVENTORY_SLOT_ARROWS,oTarget)!=OBJECT_INVALID && nAmmo==TRUE)
            {
             oWeapon = GetItemInSlot(INVENTORY_SLOT_ARROWS,oTarget);
            }
          else if(GetItemInSlot(INVENTORY_SLOT_BOLTS,oTarget)!=OBJECT_INVALID && nAmmo==TRUE)
            {
             oWeapon = GetItemInSlot(INVENTORY_SLOT_BOLTS,oTarget);
            }
          else if(GetItemInSlot(INVENTORY_SLOT_BULLETS,oTarget)!=OBJECT_INVALID && nAmmo==TRUE)
            {
             oWeapon = GetItemInSlot(INVENTORY_SLOT_BULLETS,oTarget);
            }
          else if(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget)!=OBJECT_INVALID && nAmmo==FALSE)
            {
             oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
            }
    nBaseWeapon = GetBaseItemType(oWeapon);
    }
    else
    {
    nBaseWeapon = GetBaseItemType(oTarget);
    if(IPGetIsMeleeWeapon(oTarget) || (!(nBaseWeapon < 300 || nBaseWeapon > 323)))
    oWeapon = oTarget;
    else if (IPGetIsProjectile(oTarget) || (!(nBaseWeapon < 300 || nBaseWeapon > 323)))    //is ammo
    oWeapon = oTarget;
    else if (IPGetIsRangedWeapon(oTarget) || (!(nBaseWeapon < 300 || nBaseWeapon > 323)))    //is throw
    oWeapon = oTarget;
    }
    if(GetIsObjectValid(oWeapon) )
    {
    if(IPGetIsBludgeoningWeapon(oWeapon)==TRUE){nType=IP_CONST_DAMAGETYPE_SLASHING;}
    if (nDuration>0 && nGold>=nCost)
    {
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
    TakeGoldFromCreature(nCost,oPC,TRUE);
    DelayCommand(1.0,FloatingTextStringOnCreature("<c ¥ >*"+sFeedback+"*</c>",oPC));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon)));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration)));
    DelayCommand(1.0,IPSafeAddItemProperty(oWeapon,ItemPropertyDamageBonus(nType,nDmg),TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE));
    if(nSpecial==TRUE && nAmmo==TRUE){DelayCommand(1.0,IPSafeAddItemProperty(oWeapon,ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE,IP_CONST_ONHIT_SAVEDC_26),TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE));}
    if(nSpecial==TRUE && nAmmo==FALSE){DelayCommand(1.0,IPSafeAddItemProperty(oWeapon,ItemPropertyKeen(),TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE));}
    }
    return;
    }
    else
    {
    FloatingTextStringOnCreature("<c ¥ >*Appliance Error!*</c>",oPC);
    return;
    }
}

//Returns TRUE if oItem is a Simple item.
int MothGetIsSimpleItem(object oItem)
{
  if(GetBaseItemType(oItem) == BASE_ITEM_CLOAK||
     GetBaseItemType(oItem) == BASE_ITEM_HELMET||
     GetBaseItemType(oItem) == BASE_ITEM_TORCH||
     GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD||
     GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD||
     GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD)
    {
      return TRUE;
    }
   else return FALSE;
}

//Returns TRUE if nSlot is a creature item slot that can hold Simple Items.
int MothGetIsSimpleItemSlot(int nSlot)
{
    if(nSlot ==INVENTORY_SLOT_ARMS||
       nSlot ==INVENTORY_SLOT_BELT||
       nSlot ==INVENTORY_SLOT_BOOTS||
       nSlot ==INVENTORY_SLOT_CLOAK||
       nSlot ==INVENTORY_SLOT_NECK||
       nSlot ==INVENTORY_SLOT_LEFTRING||
       nSlot ==INVENTORY_SLOT_LEFTHAND||
       nSlot ==INVENTORY_SLOT_RIGHTRING)
       {
       return TRUE;
       }
    else return FALSE;
}
//Returns TRUE is the nRow value in s2da string is above 0, which means it has a model drawn ingame.
int MothGetIsAppearanceValid(int nRow,string s2da)
{
    string sModel = Get2DAString(s2da, "MODEL", nRow);
    int nModel = StringToInt(sModel);
    if(nModel < 1)
    {
     return FALSE;
    }
   else return TRUE;
}

//Sets appearance of oItem if it's a Simple Item.
void MothSetSimpleItemAppearance(object oPC,object oItem,int nNext,string sName,int nSlot,string s2da)
{
    object oNew;
    int nType = GetBaseItemType(oItem);
    int nMax = StringToInt(Get2DAString("baseitems", "MaxRange", nType));
    int nMin = StringToInt(Get2DAString("baseitems", "MinRange", nType));
    if(sName =="")
    {
      sName = "Objects";
    }
    if(nNext>nMax)
    {
      nNext=nMin;
    }
    else if(nNext<nMin)
    {
      nNext=nMax;
    }
    SendMessageToPC(oPC,"<c ¥ >*"+sName+" Appearance Number is now set to "+IntToString(nNext)+".*</c>");
    if(!MothGetIsAppearanceValid(nNext,s2da) && MothGetIsSimpleItem(oItem))
    {
    oNew = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,00,nNext,TRUE);
    DestroyObject(oItem);
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
    SendMessageToPC(oPC,"<c ¥ >*"+sName+" Appearance not found! Try the next one.*</c>");
    return;
    }
    oNew = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL,00,nNext,TRUE);
    DestroyObject(oItem);
    AssignCommand(oPC, ActionEquipItem(oNew, nSlot));
    SendMessageToPC(oPC,"<c ¥ >*"+sName+" Appearance set!*</c>");
}
//Wrapper to hold various settings,checks for changing apprearances of Simple Items.
void MothSetNextOrPreviousSimpleItem(int nReset=FALSE,int nChange=0,int nSlot=INVENTORY_SLOT_CLOAK,string s2da="cloakmodel")
{
        object oPC = GetPCSpeaker();
        object oNew;
        string sName;
        object oItem = GetItemInSlot(nSlot, oPC);
        if(!GetIsObjectValid(oItem))
        {
         SendMessageToPC(oPC,"<c ¥ >*Invalid Item!*</c>");
         return;
        }
        if(nReset==TRUE)
        {
         MothSetSimpleItemAppearance(oPC,oItem,1,sName,nSlot,s2da);
         SendMessageToPC(oPC,"<c ¥ >*Appearance reset!*</c>");
         return;
        }
        if(!MothGetIsSimpleItemSlot(nSlot))
        {
         WriteTimestampedLogEntry("Function MothSetNextOrPreviousSimpleItem() have incorrect settings!");
         return;
        }
        switch(GetBaseItemType(oItem))
        {
         case BASE_ITEM_CLOAK: sName = "Cloak"; break;
         case BASE_ITEM_HELMET: sName = "Helmet"; break;
         case BASE_ITEM_LARGESHIELD: sName = "Large Shield"; break;
         case BASE_ITEM_SMALLSHIELD: sName = "Small Shield"; break;
         case BASE_ITEM_TOWERSHIELD: sName = "Tower Shield"; break;
         case BASE_ITEM_TORCH: sName = "Torch"; break;
         case BASE_ITEM_AMULET: sName = "Amulet"; break;
         case BASE_ITEM_BELT: sName = "Belt"; break;
         case BASE_ITEM_BOOK: sName = "Books"; break;
         case BASE_ITEM_BOOTS: sName = "Boots"; break;
         case BASE_ITEM_BRACER: sName = "Bracers"; break;
         case BASE_ITEM_LARGEBOX: sName = "Container"; break;
         case BASE_ITEM_RING: sName = "Ring"; break;
        }
        if(sName =="")
        {
         SendMessageToPC(oPC,"<c ¥ >*Only Simple Items can be modified!*</c>");
         return;
        }
        int nNext = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0);
        nNext = nNext+nChange;
        MothSetSimpleItemAppearance(oPC,oItem,nNext,sName,nSlot,s2da);
}
//Instant setting of Cloaks to non-appearance Cloaks.
void MothHideCloak()
{
    object oPC = GetPCSpeaker();
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    object oNew = CopyItemAndModify(oCloak,ITEM_APPR_TYPE_SIMPLE_MODEL,00,99,TRUE);
    DestroyObject(oCloak);
    AssignCommand(oPC, ActionEquipItem(oNew, INVENTORY_SLOT_CLOAK));
    SendMessageToPC(oPC,"<c ¥ >*Cloak Appearance hidden!*</c>");
}
void MothCheckStones(object oMyWeapon)
{
   IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ON_HIT_PROPERTIES,DURATION_TYPE_TEMPORARY,6);
   IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ON_HIT_PROPERTIES,DURATION_TYPE_TEMPORARY,7);
   IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ON_HIT_PROPERTIES,DURATION_TYPE_TEMPORARY,9);
}
void MothCheckBloodlineFury(object oMyWeapon)
{
   SetLocalInt(oMyWeapon,"MothBloodlineFury",FALSE);
   IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_REGENERATION_VAMPIRIC,DURATION_TYPE_TEMPORARY,-1);
}
//Returns TRUE if oItem is clohtes.
//This check will only work correctly if oItem is an Armor.
int MothGetIsClothing(object oItem)
{
    int nWeight = GetWeight(oItem);
    if(nWeight<=1)
    {
    return TRUE;
    }
   return FALSE;
}
void MothRemoveItemTempEffect(object oMyWeapon)
{
   if(!GetMeleeWeapon(oMyWeapon)){return;}
      IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ON_HIT_PROPERTIES,DURATION_TYPE_TEMPORARY,-1);
      IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ATTACK_BONUS,DURATION_TYPE_TEMPORARY,-1);
      IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ENHANCEMENT_BONUS,DURATION_TYPE_TEMPORARY,-1);
      IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_DAMAGE_BONUS,DURATION_TYPE_TEMPORARY,-1);
      IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_REGENERATION_VAMPIRIC,DURATION_TYPE_TEMPORARY,-1);
      IPRemoveMatchingItemProperties(oMyWeapon,ITEM_PROPERTY_ONHITCASTSPELL,DURATION_TYPE_TEMPORARY,-1);
}
//Returns TRUE if the oTarget is valid to the effects of the ability
int MothFighterBullrushChargeChecks(object oUser,object oTarget)
{
    if(!GetIsObjectValid(oTarget))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Invalid Target!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >This is not a valid Target!</c>");
    return FALSE;
    }
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Failed!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target must be a Creature!</c>");
    return FALSE;
    }
    if(GetLocalInt(oUser,"MOTHGENERALCHARGE"))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: No Stamina!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You do not have enough Stamina to execute this Charge!</c>");
    return FALSE;
    }
    if(GetLocalInt(oUser,"MOTHFIGTHERCHARGE")==TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: No Focus!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You do not have enough Focus to Charge!</c>");
    return FALSE;
    }
    if(GetIsImmune(oTarget,IMMUNITY_TYPE_KNOCKDOWN,oUser))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Immune!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target Immune to Charge!</c>");
    return FALSE;
    }
    if(MothGetIsFortAlly(oTarget,oUser))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Invalid Target!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target must be a Hostile Target!</c>");
    return FALSE;
    }
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser);
    object oMelee = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUser);
    if(!GetMeleeWeapon(oMelee))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: No Weapon!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need a Melee Weapon equipped to Charge!</c>");
    return FALSE;
    }
    if(!MatchShield(oShield))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: No Shield!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need a Shield equipped to Charge!</c>");
    return FALSE;
    }
    float fDistance = GetDistanceBetween(oUser,oTarget);
    if(fDistance>26.0)
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Out of Reach!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need to be closer to the Target!</c>");
    return FALSE;
    }
    if(!LineOfSightObject(oUser,oTarget))
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: No Line of Sight!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >No Line of Sight to the Target!</c>");
    return FALSE;
    }
    vector vUser = GetPosition(oUser);
    vector vTarget = GetPosition(oTarget);
    float fUserHeight = vUser.z;
    float fTargetHeight = vTarget.z;
    float fDifferance = fUserHeight - fTargetHeight;
    if(fDifferance > 1.0 || fDifferance < -1.0)
    {
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Failed!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You cannot Charge across height differances!</c>");
    return FALSE;
    }
  return TRUE;
}
int MothFighterTornadoChargeChecks(object oUser,object oTarget)
{
    if(!GetIsObjectValid(oTarget))
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: Invalid Target!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >This is not a valid Target!</c>");
    return FALSE;
    }
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: Failed!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target must be a Creature!</c>");
    return FALSE;
    }
    if(GetLocalInt(oUser,"MOTHGENERALCHARGE"))
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: No Stamina!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You do not have enough Stamina to execute this Charge!</c>");
    return FALSE;
    }
    if(GetLocalInt(oUser,"MOTHFIGTHERCHARGE2")==TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: No Focus!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You do not have enough Focus to Charge!</c>");
    return FALSE;
    }
    if(MothGetIsFortAlly(oTarget,oUser))
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: Invalid Target!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target must be a Hostile Target!</c>");
    return FALSE;
    }
    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser);
    object oMelee = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUser);
    if(!GetMeleeWeapon(oMelee))
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: No Weapon!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need a Melee Weapon equipped to Charge!</c>");
    return FALSE;
    }
    if(!MatchShield(oShield))
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: No Shield!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need a Shield equipped to Charge!</c>");
    return FALSE;
    }
    float fDistance = GetDistanceBetween(oUser,oTarget);
    if(fDistance>26.0)
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: Out of Reach!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need to be closer to the Target!</c>");
    return FALSE;
    }
    if(!LineOfSightObject(oUser,oTarget))
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: No Line of Sight!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >No Line of Sight to the Target!</c>");
    return FALSE;
    }
    vector vUser = GetPosition(oUser);
    vector vTarget = GetPosition(oTarget);
    float fUserHeight = vUser.z;
    float fTargetHeight = vTarget.z;
    float fDifferance = fUserHeight - fTargetHeight;
    if(fDifferance > 1.0 || fDifferance < -1.0)
    {
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: Failed!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You cannot Charge across height differances!</c>");
    return FALSE;
    }
  return TRUE;
}
int MothFighterThrustChecks(object oUser,object oTarget)
{
    if(!GetIsObjectValid(oTarget))
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: Invalid Target!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >This is not a valid Target!</c>");
    return FALSE;
    }
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: Failed!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target must be a Creature!</c>");
    return FALSE;
    }
    if(GetLocalInt(oUser,"MOTHFIGTHERCHARGE3")==TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: No Focus!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You do not have enough Focus to Charge!</c>");
    return FALSE;
    }
    if(MothGetIsFortAlly(oTarget,oUser))
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: Invalid Target!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >Target must be a Hostile Target!</c>");
    return FALSE;
    }
    float fDistance = GetDistanceBetween(oUser,oTarget);
    if(fDistance>26.0)
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: Out of Reach!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You need to be closer to the Target!</c>");
    return FALSE;
    }
    if(!LineOfSightObject(oUser,oTarget))
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: No Line of Sight!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >No Line of Sight to the Target!</c>");
    return FALSE;
    }
    vector vUser = GetPosition(oUser);
    vector vTarget = GetPosition(oTarget);
    float fUserHeight = vUser.z;
    float fTargetHeight = vTarget.z;
    float fDifferance = fUserHeight - fTargetHeight;
    if(fDifferance > 1.0 || fDifferance < -1.0)
    {
    FloatingTextStringOnCreature("<cðøþ>*Thrust: Failed!*</c>",oUser,TRUE);
    SendMessageToPC(oUser,"<c ¥ >You cannot Charge across height differances!</c>");
    return FALSE;
    }
  return TRUE;
}
void MothTornadoCharge(object oPC)
{
      effect eVis = EffectVisualEffect(460);
      effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_WIND);
      effect eHitVis = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
      effect eKnock = EffectKnockdown();
      eKnock = SupernaturalEffect(eKnock);
      float fFighter = IntToFloat(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC));
      float fRegainBase = 360.0;
      float fRegainBonus = fFighter*4;
      float fRegain = fRegainBase - fRegainBonus;
      float fKnockDown = fFighter/10.0;
      float fRadius = fKnockDown;
      if(fFighter == 40.0)
      {
        fRadius = fRadius + 0.5;
        fKnockDown = fKnockDown + 1.0;
      }
      ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis2, GetLocation(oPC));
      DelayCommand(1.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC));
      DoWhirlwindAttack(TRUE,TRUE);
      object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 1.5+fRadius, GetLocation(oPC), OBJECT_TYPE_CREATURE);
      while(GetIsObjectValid(oTarget))
      {
      if(!MothGetIsFortAlly(oTarget))
        {
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget,2.0+fKnockDown);
           float fDelay = GetRandomDelay(0.8, 1.2);
           int nBase = GetHitDice(oPC)/2;
           int nDamage = nBase + d6(4);
           nDamage=nDamage*2;
           if(nDamage > 0)
             {
              effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_SEVEN);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget);
             }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 1.5+fRadius, GetLocation(oPC), OBJECT_TYPE_CREATURE);
       }
}
// *  return TRUE if oItem is an Armor. Includes Creature Armor (Hides).
int MothIPGetIsArmor(object oItem)
{
    int nItem = GetBaseItemType(oItem);
    if(nItem == BASE_ITEM_ARMOR ||
       nItem == BASE_ITEM_CREATUREITEM)
   {
        return TRUE;
   }
   return FALSE;
}
void MothAutoMining(object oPlayer, object oVein, object oWeapon)
{
   if(!GetIsObjectValid(oPlayer))
   {
    return;
   }
   if(!GetIsObjectValid(oVein))
   {
    return;
   }
   if(ATS_GetTagBaseType(oWeapon) != CSTR_MINETOOL)
   {
    return;
   }
   if(GetLocalInt(oPlayer, "MOTHAUTOMINE") == FALSE) //J. Persinne; kick out if the player has canceled automining.
   {
    return;
   }
   SetLocalInt(oPlayer,"MOTHOREREADY",TRUE);
   AssignCommand(oPlayer, DoPlaceableObjectAction(oVein,PLACEABLE_ACTION_BASH));
   float fDist = GetDistanceBetween(oVein,oPlayer);
   if (fDist <= 2.0 && fDist != -1.0)
   {
   DelayCommand(5.0,MothAutoMining(oPlayer,oVein,oWeapon));
   }
}
//void main(){}
