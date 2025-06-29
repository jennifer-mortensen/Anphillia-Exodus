void main()
{
object oPC = GetPCSpeaker();
object oObject;
CreateItemOnObject("x2_it_poison009",oPC,1,"MothVenom009");
TakeGoldFromCreature(25,oPC,TRUE);
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
oObject = GetObjectByTag("MothVenom009");
if(GetItemPossessor(oObject)==oPC){SetIdentified(oObject,TRUE);}
FloatingTextStringOnCreature("*Crafting Venom*",oPC);
DelayCommand(1.0,FloatingTextStringOnCreature("*Success!*",oPC));
}

