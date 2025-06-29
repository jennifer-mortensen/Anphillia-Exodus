void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("x2_it_cfm_bscrl", oPC);
TakeGoldFromCreature(250,oPC,TRUE);
FloatingTextStringOnCreature("<c°ÄÞ>*Blank Scroll created!*</c>",oPC);
}
