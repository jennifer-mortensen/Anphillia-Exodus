#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamType = IP_CONST_DAMAGETYPE_SONIC;
    int nItemEffect = ITEM_VISUAL_SONIC;
    int nVisEffect2 = VFX_IMP_PULSE_WIND;
    int nVisEffect1 = VFX_IMP_SONIC;
    int iBaseType;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDuration = 10 * nCasterLvl;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    object oMyWeapon = OBJECT_INVALID;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    float fDuration = TurnsToSeconds(nDuration);
    int nDamConst;
    if(nCasterLvl < 10) //Moonlight; damage bonus now scales with levels
        nDamConst = DAMAGE_BONUS_1d4;
    else if (nCasterLvl < 20)
        nDamConst = DAMAGE_BONUS_1d6;
    else
        nDamConst = DAMAGE_BONUS_1d8;
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
     if(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget)==OBJECT_INVALID)
       {
        if(GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget)!=OBJECT_INVALID)
          {
           oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
          }
       }
     else
       oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
       if(GetWeaponRanged(oMyWeapon)==TRUE)
         {
          if(GetItemInSlot(INVENTORY_SLOT_ARROWS,oTarget)!=OBJECT_INVALID)
            {
             oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARROWS,oTarget);
            }
          else if(GetItemInSlot(INVENTORY_SLOT_BOLTS,oTarget)!=OBJECT_INVALID)
            {
             oMyWeapon = GetItemInSlot(INVENTORY_SLOT_BOLTS,oTarget);
            }
          else if(GetItemInSlot(INVENTORY_SLOT_BULLETS,oTarget)!=OBJECT_INVALID)
            {
             oMyWeapon = GetItemInSlot(INVENTORY_SLOT_BULLETS,oTarget);
            }
         }
    iBaseType = GetBaseItemType(oMyWeapon);
    }
    else
    {
    iBaseType = GetBaseItemType(oTarget);
    if(IPGetIsMeleeWeapon(oTarget) || (!(iBaseType < 300 || iBaseType > 323)))
    oMyWeapon = oTarget;
    else if (IPGetIsProjectile(oTarget) || (!(iBaseType < 300 || iBaseType > 323)))    //is ammo
    oMyWeapon = oTarget;
    else if (IPGetIsRangedWeapon(oTarget) || (!(iBaseType < 300 || iBaseType > 323)))    //is throw
    oMyWeapon = oTarget;
    else if (GetBaseItemType(oTarget)==BASE_ITEM_GLOVES)
    oMyWeapon = oTarget;
    }
   if(GetIsObjectValid(oMyWeapon) )
    {
        itemproperty ipLoop=GetFirstItemProperty(oMyWeapon);
        while (GetIsItemPropertyValid(ipLoop))  //because same damage types don`t stack
        {
          if (GetItemPropertyType(ipLoop) == ITEM_PROPERTY_DAMAGE_BONUS)
          {
            if (GetItemPropertyDurationType(ipLoop) == DURATION_TYPE_PERMANENT)
            {
              int nSubType = GetItemPropertySubType(ipLoop);
              //nothing happends
            }
          }
        ipLoop=GetNextItemProperty(oMyWeapon);
        }
        effect eVis1 = EffectVisualEffect(nVisEffect1);
        effect eVis2 = EffectVisualEffect(nVisEffect2);
        effect eVis = EffectLinkEffects(eVis1 ,eVis2);
        eVis = ExtraordinaryEffect(eVis);
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);

            itemproperty ipElemDam = ItemPropertyDamageBonus(nDamType, nDamConst);
            IPSafeAddItemProperty(oMyWeapon, ipElemDam, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

            itemproperty ipElemVis = ItemPropertyVisualEffect(nItemEffect);
            IPSafeAddItemProperty(oMyWeapon, ipElemVis, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        }
    }
    else
        FloatingTextStringOnCreature("<cðøþ>*No Weapon or Ammo found!*</c>",OBJECT_SELF,FALSE);
}
