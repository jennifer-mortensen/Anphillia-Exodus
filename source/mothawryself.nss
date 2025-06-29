#include "x0_i0_spells"
void main()
{
 object oPC = GetPCSpeaker();
 AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
 DelayCommand(0.4,FloatingTextStringOnCreature("<c ¥ >*Awry Self Applied!*</c>",oPC));
 AssignCommand(oPC,ActionCastSpellAtObject(203,oPC,METAMAGIC_ANY,TRUE,9,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
}
