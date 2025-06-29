#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"

void AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
return;
}
void AddGreaterEnhancementEffectToAmmo(object oMyWeapon, float fDuration, int nBonus)
{
IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
return;
}
void main()
{
if (!X2PreSpellCastCode())
{
return;
}
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eDur = ExtraordinaryEffect(eDur);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nCasterLvl = 1;
    int nMetaMagic = GetMetaMagicFeat();
    int iBaseType;
    object oTarget = GetSpellTargetObject();
    object oMyWeapon = OBJECT_INVALID;
    if((GetIsPC(oTarget) || (GetIsPlayableRacialType(oTarget)) || GetIsDM(oTarget)))
    {
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    iBaseType = GetBaseItemType(oMyWeapon);
    }
    else
    {
    iBaseType = GetBaseItemType(oTarget);
    if(IPGetIsMeleeWeapon(oTarget) || (!(iBaseType < 300 || iBaseType > 323)))
    oMyWeapon = oTarget;
    if (IPGetIsProjectile(oTarget))
    oMyWeapon = oTarget;
    else if (IPGetIsRangedWeapon(oTarget))
    oMyWeapon = oTarget;
    }
if (nMetaMagic == METAMAGIC_EXTEND)
{
nDuration = nDuration * 2;
}

if(GetIsObjectValid(oMyWeapon) )
{
SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

if (nDuration>0)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(10));
if(IPGetIsProjectile(oTarget)){AddGreaterEnhancementEffectToAmmo(oMyWeapon, (HoursToSeconds(10)), nCasterLvl);}
else{AddGreaterEnhancementEffectToWeapon(oMyWeapon, (HoursToSeconds(10)), nCasterLvl);}
}
return;
}
else
{
FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
return;
}
}
