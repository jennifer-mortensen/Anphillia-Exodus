void main()
{
 object oPC = GetPCSpeaker();
 object oDoor = GetObjectByTag("bugbearpuzzledoor1");
 string sFeedback = "<cþ¥ >*You rotate a skull.*</c>";
 FloatingTextStringOnCreature(sFeedback,oPC,FALSE);
 if(GetLocalInt(oPC,"OgreSpins")==3 && GetLocalInt(oPC,"HumanSpins")==5 && GetLocalInt(oPC,"GoblinSpins")==4)
 {
  SetLocked(oDoor,FALSE);
  FloatingTextStringOnCreature("<c¥¥¥>*You hear a loud clash*</c>",oPC,FALSE);
  SetUseableFlag(OBJECT_SELF,FALSE);
 }
 else if(GetLocalInt(oPC,"HumanSpins")==0)
 {
 SetLocalInt(oPC,"HumanSpins",1);
 }
 else if(GetLocalInt(oPC,"HumanSpins")==1)
 {
 SetLocalInt(oPC,"HumanSpins",2);
 }
 else if(GetLocalInt(oPC,"HumanSpins")==2)
 {
 SetLocalInt(oPC,"HumanSpins",3);
 }
 else if(GetLocalInt(oPC,"HumanSpins")==3)
 {
 SetLocalInt(oPC,"HumanSpins",4);
 }
 else if(GetLocalInt(oPC,"HumanSpins")==4)
 {
 SetLocalInt(oPC,"HumanSpins",5);
 }
}

