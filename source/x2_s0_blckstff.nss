#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void AddBlackStaffEffectOnWeapon (object oTarget, float fDuration)
{
   IPSafeAddItemProperty(oTarget, ItemPropertyEnhancementBonus(4), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE, TRUE);
   IPSafeAddItemProperty(oTarget, ItemPropertyOnHitProps(IP_CONST_ONHIT_GREATERDISPEL, IP_CONST_ONHIT_SAVEDC_26), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_EVIL), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
return;
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis1 = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nCasterLevel = nDuration;
    int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF);
    int nHitDice = GetHitDice(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nBuff = MothDC();
    nBuff = nBuff/4;
    object oMyWeapon = IPGetTargetedOrEquippedMeleeWeapon();
    int nType = GetBaseItemType(oMyWeapon);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    if(GetIsObjectValid(oMyWeapon))
    {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
           {
                if(nType == BASE_ITEM_QUARTERSTAFF
                        || nType == BASE_ITEM_MAGICSTAFF
                        || (nType == BASE_ITEM_CLUB && nDruid)
                        || (nType == BASE_ITEM_DAGGER && nDruid)
                        || (nType == BASE_ITEM_SCIMITAR && nDruid)
                        || (nType == BASE_ITEM_SICKLE && nDruid)
                        || (nType == BASE_ITEM_SHORTSPEAR && nDruid))
                {
                    if(nHitDice>nCasterLevel)
                    {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
                    AddBlackStaffEffectOnWeapon(oMyWeapon, HoursToSeconds(nDuration));
                    }
                    else
                    {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
                    MothAddBlackStaffEffectOnWeapon(oMyWeapon, nBuff, HoursToSeconds(nDuration));
                    }
                }
                else
                {
                    if(!nDruid)
                        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be a Quarterstaff or a Magic Staff!</c>");
                    else
                        SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be a Druid Weapon or a Magic Staff!</c>");
                return;
                }
           }
          return;
    }
    else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
}
