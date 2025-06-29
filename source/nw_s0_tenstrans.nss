#include "x2_inc_spellhook"
#include "x2_inc_itemprop"
#include "x3_inc_horse"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if(GetLocalInt(OBJECT_SELF,"HasMountExp")== TRUE)
    {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell while mounted.</c>");
        return ;
    }
    if(HorseGetIsMounted(OBJECT_SELF)== TRUE)
    {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell while mounted.</c>");
        return ;
    }
    if(GetAppearanceType(OBJECT_SELF) > 6 && GetIsPC(OBJECT_SELF) && !GetIsDM(OBJECT_SELF))
    {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell while polymorphed.</c>");
        return ;
    }
    object oScroll = GetSpellCastItem();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    if(GetSpellId()==595)//if Harper Spell
    {
     nDuration = GetLevelByClass(CLASS_TYPE_HARPER,OBJECT_SELF);
     nDuration = nDuration*2;
    }
    if(GetIsObjectValid(oScroll))
    {
     SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell from an Item.</c>");
     return;
    }
    int nSave = d2();
    int nMeta = GetMetaMagicFeat();
    if(nMeta == METAMAGIC_MAXIMIZE)
    {
        nSave = 5;
        nDuration *= 3;
    }
    else if(nMeta == METAMAGIC_EMPOWER)
    {
        nSave = 4;
        nDuration *= 2;
    }
    else if(nMeta == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSave);
    effect eResistance = EffectDamageResistance(DAMAGE_TYPE_SLASHING, nSave);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect ePoly = EffectPolymorph(28);
    effect eSwing = EffectModifyAttacks(1);
    effect eLink = EffectLinkEffects(eSwing, ePoly);
    eLink = EffectLinkEffects(eLink, eSave);
    eLink = EffectLinkEffects(eLink, eResistance);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TENSERS_TRANSFORMATION, FALSE));
    int bWeapon = StringToInt(Get2DAString("polymorph","MergeW",POLYMORPH_TYPE_DOOM_KNIGHT)) == 1;
    int bArmor  = StringToInt(Get2DAString("polymorph","MergeA",POLYMORPH_TYPE_DOOM_KNIGHT)) == 1;
    int bItems  = StringToInt(Get2DAString("polymorph","MergeI",POLYMORPH_TYPE_DOOM_KNIGHT)) == 1;
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
    ClearAllActions();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration*3 + 10));
    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    if (bWeapon && !GetIsObjectValid(oScroll))
    {
            IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    }
    if (bArmor && !GetIsObjectValid(oScroll))
    {
        IPWildShapeCopyItemProperties(oShield,oArmorNew);
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
    }
    if (bItems && !GetIsObjectValid(oScroll))
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
