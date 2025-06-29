void main()
{
object oPC = GetPlaceableLastClickedBy();
if(GetLocalString(oPC,"MothSetFactionInt") == "MothAxfellMember"){return;}
object oMod = GetModule();
float fDist = GetDistanceBetween(OBJECT_SELF,oPC);
object oTarget = GetObjectByTag("axfelltrebdirt");
if(fDist >= 8.0){return;}
if(LineOfSightObject(oPC,OBJECT_SELF)==FALSE){return;}
if(GetLocalInt(oMod,"MOTHAXFGATEDOWN")==1){return;}
if(GetLocalInt(oMod,"MOTHAXFRELIC")==TRUE){return;}
AssignCommand(oPC,ClearAllActions());
AssignCommand(oPC,ActionJumpToObject(oTarget,0));
}

