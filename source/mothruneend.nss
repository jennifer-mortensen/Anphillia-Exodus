void main()
{
object oPC = GetPCSpeaker();
string sPC = GetName(oPC);
SendMessageToPC(oPC, "<cýõæ>The runes tell you a simple but certainly not obvious way to open a small hidden compartment that was previously undetected by you. You find a Red Power Stone in it.</c>");
FloatingTextStringOnCreature("<cýõæ>"+sPC+" seems to have found something.</c>", oPC);
CreateItemOnObject("mothplot2", oPC);
DelayCommand(1.0,SetUseableFlag(OBJECT_SELF,FALSE));
}

