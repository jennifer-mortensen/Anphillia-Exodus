#include "x2_inc_spellhook"
#include "x3_inc_horse"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
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
    if(GetAppearanceType(OBJECT_SELF) > 6 && GetIsPC(OBJECT_SELF) && !GetIsDM(OBJECT_SELF))
    {
        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell while polymorphed.</c>");
        return ;
    }
    int nSpell = GetSpellId();
    object oScroll = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect ePoly;
    effect eSwing = EffectModifyAttacks(1);
    int nPoly;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    if(GetIsObjectValid(oScroll))
    {
     SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You cannot use this spell from an Item.</c>");
     return;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    if(nSpell == 392)
    {
        nPoly = POLYMORPH_TYPE_RED_DRAGON;
    }
    else if (nSpell == 393)
    {
        if(GetGender(OBJECT_SELF) == GENDER_FEMALE)
        {
        nPoly = 120;
        }
        else
        {
        nPoly = 9;
        }

    }
    else if (nSpell == 394)
    {
        nPoly = POLYMORPH_TYPE_BALOR;
    }
    else if (nSpell == 395)
    {
        nPoly = POLYMORPH_TYPE_DEATH_SLAAD;
    }
    else if (nSpell == 396)
    {
        nPoly = POLYMORPH_TYPE_IRON_GOLEM;
    }
    ePoly = EffectPolymorph(nPoly);
    effect eLink = EffectLinkEffects(eSwing, ePoly);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHAPECHANGE, FALSE));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    DelayCommand(0.2, AssignCommand(oTarget, ClearAllActions()));
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*10)));
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
    DelayCommand(0.2, AssignCommand(oTarget, ClearAllActions()));
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
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
