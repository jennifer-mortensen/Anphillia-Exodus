void main()
{
object oPC = GetPCSpeaker();
object oObject;
CreateItemOnObject("x2_it_poison038",oPC,1,"MothVenom038");
TakeGoldFromCreature(1000,oPC,TRUE);
AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
oObject = GetObjectByTag("MothVenom038");
if(GetItemPossessor(oObject)==oPC){SetIdentified(oObject,TRUE);}
FloatingTextStringOnCreature("*Crafting Venom*",oPC);
DelayCommand(1.0,FloatingTextStringOnCreature("*Success!*",oPC));
}

