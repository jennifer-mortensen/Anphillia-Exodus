void main()
{
object oPC = GetPCSpeaker();
CreateItemOnObject("x2_it_cfm_pbottl", oPC);
TakeGoldFromCreature(250,oPC,TRUE);
FloatingTextStringOnCreature("<c°ÄÞ>*Empty Potion created!*</c>",oPC);
}
