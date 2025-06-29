void main()
{
object oPC = GetPlaceableLastClickedBy();
if(GetLocalString(oPC,"MothSetFactionInt") == "MothCleavenMember"){return;}
object oMod = GetModule();
float fDist = GetDistanceBetween(OBJECT_SELF,oPC);
object oTarget = GetObjectByTag("cleaventrebdirt");
if(fDist >= 8.0){return;}
if(LineOfSightObject(oPC,OBJECT_SELF)==FALSE){return;}
if(GetLocalInt(oMod,"MOTHCLEGATEDOWN")==1){return;}
if(GetLocalInt(oMod,"MOTHCLVRELIC")==TRUE){return;}
AssignCommand(oPC,ClearAllActions());
AssignCommand(oPC,ActionJumpToObject(oTarget,0));
}

