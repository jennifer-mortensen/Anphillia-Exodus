

#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"


void AddKeenEffectToWeapon(object oMyWeapon, float fDuration)
{
IPSafeAddItemProperty(oMyWeapon,ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING ,TRUE,TRUE);
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
int nDuration = 10 * MothGetCasterLevel(OBJECT_SELF);
int nMetaMagic = GetMetaMagicFeat();
int IsSlashingWeap = 1;
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
}
// Above code replaces the below, to include CEP weapons.
// object oMyWeapon = IPGetTargetedOrEquippedMeleeWeapon();

if (nMetaMagic == METAMAGIC_EXTEND)
{
nDuration = nDuration * 2; //Duration is +100%
}

if(GetIsObjectValid(oMyWeapon))
{
SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
switch(iBaseType)
{
case 305: IsSlashingWeap =1; break;
case 313: IsSlashingWeap =1; break;
case 316: IsSlashingWeap =1; break;
case 319: IsSlashingWeap =1; break;
case 320: IsSlashingWeap =1; break;
case 321: IsSlashingWeap =1; break;
case 324: IsSlashingWeap =1; break;
default: break;
}
if ((IsSlashingWeap == 1))
{
if (nDuration>0)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
AddKeenEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration));
}
return;
}
else
{
FloatingTextStrRefOnCreature(83621, OBJECT_SELF); // not a slashing weapon
return;
}
}
else

{
FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
return;
}



}
