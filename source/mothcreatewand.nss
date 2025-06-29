void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("x2_it_cfm_wand", oPC);
TakeGoldFromCreature(750,oPC,TRUE);
FloatingTextStringOnCreature("<c°ÄÞ>*Bone Wand created!*</c>",oPC);
}
