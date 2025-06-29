#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"

void AddBladethirstEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
return;
}
void AddBladethirstToAmmo(object oMyWeapon, float fDuration, int nBonus)
{
IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
return;
}
void AddBladethirstVampToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
IPSafeAddItemProperty(oMyWeapon,ItemPropertyVampiricRegeneration(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
return;
}
void main()
{

/*
Spellcast Hook Code
Added 2003-07-07 by Georg Zoeller
If you want to make changes to all spells,
check x2_inc_spellhook.nss to find out more

*/

if (!X2PreSpellCastCode())
{
// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
return;
}

// End of Spell Cast Hook


//Declare major variables
effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
int nDuration = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF)+1;
int nDuration2 = MothGetCasterLevel(OBJECT_SELF);
int nCasterLvl = nDuration / 7;
int nCasterLvl2 = nDuration / 7;
int nMetaMagic = GetMetaMagicFeat();
int iBaseType;
object oTarget = GetSpellTargetObject();
object oMyWeapon = OBJECT_INVALID;
    //Limit nCasterLvl to 5, so it max out at +5 enhancement to the weapon.
    if (nCasterLvl < 1)
    {
        nCasterLvl = 1;
    }
    if (nCasterLvl2 < 1)
    {
        nCasterLvl2 = 1;
    }
    if(nCasterLvl > 4)
    {
        nCasterLvl = 4;
    }
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
    if (IPGetIsProjectile(oTarget))    //is ammo
    oMyWeapon = oTarget;
    else if (IPGetIsRangedWeapon(oTarget))    //is throw
    oMyWeapon = oTarget;
    }
if (nMetaMagic == METAMAGIC_EXTEND)
{
nDuration = nDuration * 2; //Duration is +100%
}

if(GetIsObjectValid(oMyWeapon) )
{
SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

if (nDuration>0)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration2));
AddBladethirstVampToWeapon(oMyWeapon, (HoursToSeconds(nDuration2)), nCasterLvl2);
if(IPGetIsProjectile(oTarget)){AddBladethirstToAmmo(oMyWeapon, (HoursToSeconds(nDuration2)), nCasterLvl);}
else{AddBladethirstEffectToWeapon(oMyWeapon, (HoursToSeconds(nDuration2)), nCasterLvl);}
}
return;
}
else
{
FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
return;
}
}
