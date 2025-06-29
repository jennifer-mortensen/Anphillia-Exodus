//::///////////////////////////////////////////////
//:: Elemental Shape
//:: NW_S2_ElemShape
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows the Druid to change into elemental forms.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 22, 2002
//:://////////////////////////////////////////////


#include "x2_inc_itemprop"
#include "x3_inc_horse"
void main()
{
    if(GetLocalInt(OBJECT_SELF,"HasMountExp")== TRUE)
    {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell while Mounted.</c>");
        return ;
    }
    if(HorseGetIsMounted(OBJECT_SELF)== TRUE)
    {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell while Mounted.</c>");
        return ;
    }
    //Declare major variables
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect ePoly;
    int nPoly;
    int nDuration = GetLevelByClass(CLASS_TYPE_DRUID); //GetCasterLevel(OBJECT_SELF);
    int bElder = FALSE;
    if(GetLevelByClass(CLASS_TYPE_DRUID) >= 20)
    {
        bElder = TRUE;
    }
    /*int nDuration2 = 0;
    if (nDuration >= 30)
    {
       nDuration2 = 4;
    }
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 2+nDuration2);
    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 2+nDuration2);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2+nDuration2);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 2+nDuration2);
    effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2+nDuration2);
    effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, 2+nDuration2);
    effect eAcc = EffectACIncrease(2+nDuration2,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect eDmg = EffectDamageIncrease(4+nDuration2,DAMAGE_TYPE_BLUDGEONING);
    effect eHpp = EffectTemporaryHitpoints(22+nDuration2);
            effect eLink = EffectLinkEffects(eStr, eCha);
            eLink = EffectLinkEffects(eLink, eCon);
            eLink = EffectLinkEffects(eLink, eDex);
            eLink = EffectLinkEffects(eLink, eInt);
            eLink = EffectLinkEffects(eLink, eWis);
            eLink = EffectLinkEffects(eLink, eAcc);
            eLink = EffectLinkEffects(eLink, eDmg);
            eLink = EffectLinkEffects(eLink, eHpp);
            eLink = ExtraordinaryEffect(eLink);  */
    //Determine Polymorph subradial type
    if(bElder == FALSE)
    {
        if(nSpell == 397)
        {
            nPoly = POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL;
        }
        else if (nSpell == 398)
        {
            nPoly = POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL;
        }
        else if (nSpell == 399)
        {
            nPoly = POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL;
        }
        else if (nSpell == 400)
        {
            nPoly = POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL;
        }
    }
    else
    {
        if(nSpell == 397)
        {
            nPoly = POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL;
        }
        else if (nSpell == 398)
        {
            nPoly = POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL;
        }
        else if (nSpell == 399)
        {
            nPoly = POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL;
        }
        else if (nSpell == 400)
        {
            nPoly = POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL;
        }
    }
    ePoly = EffectPolymorph(nPoly);
    ePoly = ExtraordinaryEffect(ePoly);
    //eLink = EffectLinkEffects(eLink, ePoly);
    ////Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_ELEMENTAL_SHAPE, FALSE));

    int bWeapon = StringToInt(Get2DAString("polymorph","MergeW",nPoly)) == 1;
    int bArmor  = StringToInt(Get2DAString("polymorph","MergeA",nPoly)) == 1;
    int bItems  = StringToInt(Get2DAString("polymorph","MergeI",nPoly)) == 1;

    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    object oGloveOld  = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }



    //Apply the VFX impact and effects
    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, HoursToSeconds(nDuration));

    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);

    if (bWeapon)
    {
            IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    }
    if (bArmor)
    {
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
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
