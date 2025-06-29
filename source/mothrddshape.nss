#include "x2_inc_itemprop"
#include "x2_inc_shifter"
void main()
{
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    int    nLevel = GetLocalInt(OBJECT_SELF,"MothRDDlvls");
    effect ePoly;
    int    nPoly;
    int    nSpell = GetSpellId();
    if ((nLevel >= 2) && (nLevel <= 4))
    {
        if(nSpell == 707)
           {
           nPoly = 110;
           }
        else if(nSpell == 708)
           {
            nPoly = 132;
           }
        else
           {
            nPoly = 127;
           }
    }
    else if ((nLevel >= 5) && (nLevel <= 6))
    {
        if(nSpell == 707)
           {
             nPoly = 111;
           }
        else if(nSpell == 708)
           {
             nPoly = 133;
           }
        else
           {
             nPoly = 128;
           }
    }
    else if ((nLevel >= 7) && (nLevel <= 8))
    {
        if(nSpell == 707)
           {
             nPoly = 112;
           }
        else if(nSpell == 708)
           {
            nPoly = 134;
           }
        else
           {
            nPoly = 129;
           }
    }
    else if ((nLevel >= 9) && (nLevel <= 10))
    {
        if(nSpell == 707)
           {
           nPoly = 113;
           }
        else if(nSpell == 708)
           {
            nPoly = 135;
           }
        else
           {
            nPoly = 130;
           }
    }
    else if ((nLevel >= 11) && (nLevel <= 12))
    {
        if(nSpell == 707)
           {
           nPoly = 114;
           }
        else if(nSpell == 708)
           {
            nPoly = 136;
           }
        else
           {
            nPoly = 131;
           }
    }
    else if ((nLevel >= 13) && (nLevel <= 14))
    {
        if(nSpell == 707)
           {
           nPoly = 115;
           }
        else if(nSpell == 708)
           {
            nPoly = 136;
           }
        else
           {
            nPoly = 131;
           }
    }
    else if ((nLevel >= 15) && (nLevel <= 19))
    {
        if(nSpell == 707)
           {
           nPoly = 116;
           }
        else if(nSpell == 708)
           {
            nPoly = 136;
           }
        else
           {
            nPoly = 131;
           }
    }
    else if ((nLevel >= 20) && (nLevel <= 24))
    {
        if(nSpell == 707)
           {
           nPoly = 117;
           }
        else if(nSpell == 708)
           {
            nPoly = 136;
           }
        else
           {
            nPoly = 131;
           }
    }
    else if (nLevel == 25)
    {
        if(nSpell == 707)
           {
           nPoly = 118;
           }
        else if(nSpell == 708)
           {
            nPoly = 136;
           }
        else
           {
            nPoly = 131;
           }
    }
    else if (nLevel >= 26)
    {
        if(nSpell == 707)
           {
           nPoly = 119;
           }
        else if(nSpell == 708)
           {
            nPoly = 136;
           }
        else
           {
            nPoly = 131;
           }
    }
    int bWeapon = ShifterMergeWeapon(nPoly);
    int bArmor  = ShifterMergeArmor(nPoly);
    int bItems  = ShifterMergeItems(nPoly);
    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld  = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old  = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old  = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld   = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    object oGloveOld  = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    object oHideOld  = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }
    ePoly = EffectPolymorph(nPoly);
    ePoly = ExtraordinaryEffect(ePoly);
    ClearAllActions();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF);
    /*if(nSpell != 707)
    {
     SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,OBJECT_SELF);
     SetCreatureTailType(12,OBJECT_SELF);
     ExecuteScript("x2_s3_darkfire",OBJECT_SELF);
    }*/
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    SetIdentified(oWeaponNew, TRUE);
    //Moth: Always merge hide to get PC Tool Feats
    IPWildShapeCopyItemProperties(oHideOld,oArmorNew);
    if (bWeapon)
    {
        {
        IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
        }
    }
    if (bArmor)
    {
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oShield,oArmorNew);
    }
    if (bItems)
    {
        IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
        IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
        IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
        IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);
        IPWildShapeCopyItemProperties(oGloveOld,oArmorNew);
    }
}








