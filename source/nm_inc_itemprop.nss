#include "x2_inc_itemprop"
#include "nm_inc"

// ----------------------------------------------------------------------------
// Returns TRUE if oItem is a weapon
// ----------------------------------------------------------------------------
int IPGetIsWeapon(object oItem)
{
    if ( (IPGetIsRangedWeapon( oItem )) ||
         ( IPGetIsMeleeWeapon( oItem )) ||
         (  IPGetIsProjectile( oItem )) )
    {
        return TRUE;
    }
    return FALSE;
}

// ----------------------------------------------------------------------------
// Returns the 'targeted item' or 'equiped weapon'.
// ----------------------------------------------------------------------------
object IPGetTargetedItemOrEquippedWeapon()
{
    object oTarget = GetSpellTargetObject();
    if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        return oTarget;
    }

    object oWeapon1 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    if (GetIsObjectValid(oWeapon1) && IPGetIsWeapon(oWeapon1))
    {
      return oWeapon1;
    }

    oWeapon1 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
    if (GetIsObjectValid(oWeapon1) && IPGetIsWeapon(oWeapon1))
    {
        return oWeapon1;
    }

    oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);
    if (GetIsObjectValid(oWeapon1) && IPGetIsWeapon(oWeapon1))
    {
        return oWeapon1;
    }

    oWeapon1 = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);
    if (GetIsObjectValid(oWeapon1) && IPGetIsWeapon(oWeapon1))
    {
        return oWeapon1;
    }

    return OBJECT_INVALID;
}

// ----------------------------------------------------------------------------
// Returns TRUE if weapon is a blugeoning weapon
// Uses Get2DAString!
// ----------------------------------------------------------------------------
int IPGetIsBludgeoningWeaponCached(object oItem)
{
    int nBT = GetBaseItemType(oItem);
    int nWeapon =  ( StringToInt(GetCached2DAString("baseitems","WeaponType",nBT)));
    // 2 = bludgeoning
    return (nWeapon == 2);
}
