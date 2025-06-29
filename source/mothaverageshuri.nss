#include "x2_i0_spells"
void MothAddShurikenBonusWeak(object oTarget, float fDuration)
{
   IPSafeAddItemProperty(oTarget, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE, TRUE);
   IPSafeAddItemProperty(oTarget, ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL, IP_CONST_ONHIT_SAVEDC_18), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_EVIL), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
return;
}
void main()
{
    int nDuration = GetLevelByClass(CLASS_TYPE_MONK);
    int nCasterLevel = nDuration;
    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    int nType = GetBaseItemType(oMyWeapon);
    if(GetIsObjectValid(oMyWeapon))
    {
        if (nDuration>0)
           {
                if(nType == BASE_ITEM_SHURIKEN)
                {
                    TakeGoldFromCreature(750,OBJECT_SELF,TRUE);
                    MothAddShurikenBonusWeak(oMyWeapon,HoursToSeconds(nDuration));
                    DelayCommand(1.0,FloatingTextStringOnCreature("<c е >*Shuriken Tip Stone Applied*</c>",OBJECT_SELF));
                    return;
                }
                else
                {
                SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be a Shuriken!</c>");
                return;
                }
           }
          return;
    }
    else
    {
           SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be a Shuriken!</c>");
           return;
    }
}


