void main()
{
object oPC = GetPCSpeaker();
object oObject;
CreateItemOnObject("x2_it_poison013",oPC,1,"MothVenom013");
TakeGoldFromCreature(75,oPC,TRUE);
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
oObject = GetObjectByTag("MothVenom013");
if(GetItemPossessor(oObject)==oPC){SetIdentified(oObject,TRUE);}
FloatingTextStringOnCreature("*Crafting Venom*",oPC);
DelayCommand(1.0,FloatingTextStringOnCreature("*Success!*",oPC));
}

