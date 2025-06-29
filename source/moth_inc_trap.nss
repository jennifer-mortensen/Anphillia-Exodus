int MothGetComponentCheck(object oPC,object oObject1,object oObject2,object oObject3)
{
  if(oObject1 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
  if(oObject2 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
  if(oObject3 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
return TRUE;
}
int MothGetComponentCheckEpic(object oPC,object oObject1,object oObject2,object oObject3,object oObject4)
{
  if(oObject1 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
  if(oObject2 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
  if(oObject3 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
  if(oObject4 == OBJECT_INVALID)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Component not found!*</c>");
  return FALSE;
  }
return TRUE;
}
int MothGetComponentStackSize(object oPC,int nStack1,int nStack2,int nStack3,int nStackBase1,int nStackBase2,int nStackBase3)
{
  if(nStackBase1<nStack1)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
  if(nStackBase2<nStack2)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
  if(nStackBase3<nStack3)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
 return TRUE;
}
int MothGetComponentStackSizeEpic(object oPC,int nStack1,int nStack2,int nStack3,int nStack4,int nStackBase1,int nStackBase2,int nStackBase3,int nStackBase4)
{
  if(nStackBase1<nStack1)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
  if(nStackBase2<nStack2)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
  if(nStackBase3<nStack3)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
  if(nStackBase4<nStack4)
  {
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Failed!*</c>",OBJECT_SELF,TRUE);
  SendMessageToPC(oPC,"<cðøþ>*Too few Components or too few Components in a stack!*</c>");
  return FALSE;
  }
 return TRUE;
}
void MothAdjustNewComponentStackSize(object oPC,object oObject1,object oObject2,object oObject3,int nStack1,int nStack2,int nStack3,int nStackBase1,int nStackBase2,int nStackBase3)
{
  int nNewStack1 = nStackBase1-nStack1;
  int nNewStack2 = nStackBase2-nStack2;
  int nNewStack3 = nStackBase3-nStack3;
  if(nNewStack1<1)
  {
  DestroyObject(oObject1);
  }
  if(nNewStack2<1)
  {
  DestroyObject(oObject2);
  }
  if(nNewStack3<1)
  {
  DestroyObject(oObject3);
  }
  if(GetIsObjectValid(oObject1))
  {
  SetItemStackSize(oObject1,nNewStack1);
  }
  if(GetIsObjectValid(oObject2))
  {
  SetItemStackSize(oObject2,nNewStack2);
  }
  if(GetIsObjectValid(oObject3))
  {
  SetItemStackSize(oObject3,nNewStack3);
  }
}
void MothAdjustNewComponentStackSizeEpic(object oPC,object oObject1,object oObject2,object oObject3,object oObject4,int nStack1,int nStack2,int nStack3,int nStack4,int nStackBase1,int nStackBase2,int nStackBase3,int nStackBase4)
{
  int nNewStack1 = nStackBase1-nStack1;
  int nNewStack2 = nStackBase2-nStack2;
  int nNewStack3 = nStackBase3-nStack3;
  int nNewStack4 = nStackBase4-nStack4;
  if(nNewStack1<1)
  {
  DestroyObject(oObject1);
  }
  if(nNewStack2<1)
  {
  DestroyObject(oObject2);
  }
  if(nNewStack3<1)
  {
  DestroyObject(oObject3);
  }
  if(nNewStack4<1)
  {
  DestroyObject(oObject4);
  }
  if(GetIsObjectValid(oObject1))
  {
  SetItemStackSize(oObject1,nNewStack1);
  }
  if(GetIsObjectValid(oObject2))
  {
  SetItemStackSize(oObject2,nNewStack2);
  }
  if(GetIsObjectValid(oObject3))
  {
  SetItemStackSize(oObject3,nNewStack3);
  }
  if(GetIsObjectValid(oObject4))
  {
  SetItemStackSize(oObject4,nNewStack4);
  }
}
void MothMakeTrap(object oPC,
                  string sTrap,
                  string sCheck1,
                  string sCheck2,
                  string sCheck3,
                  int nStack1,
                  int nStack2,
                  int nStack3)
{
  object oObject1 = GetItemPossessedBy(oPC,sCheck1);
  object oObject2 = GetItemPossessedBy(oPC,sCheck2);
  object oObject3 = GetItemPossessedBy(oPC,sCheck3);
  if(!MothGetComponentCheck(oPC,oObject1,oObject2,oObject3)){return;}
  int nStackBase1 = GetItemStackSize(oObject1);
  int nStackBase2 = GetItemStackSize(oObject2);
  int nStackBase3 = GetItemStackSize(oObject3);
  if(!MothGetComponentStackSize(oPC,nStack1,nStack2,nStack3,nStackBase1,nStackBase2,nStackBase3)){return;}
  MothAdjustNewComponentStackSize(oPC,oObject1,oObject2,oObject3,nStack1,nStack2,nStack3,nStackBase1,nStackBase2,nStackBase3);
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Success!*</c>",OBJECT_SELF,TRUE);
  object oTrap = CreateItemOnObject(sTrap,oPC);
  SetIdentified(oTrap,TRUE);
}
void MothMakeEpicTrap(object oPC,
                  string sTrap,
                  string sCheck1,
                  string sCheck2,
                  string sCheck3,
                  string sCheck4,
                  int nStack1,
                  int nStack2,
                  int nStack3,
                  int nStack4)
{
  object oObject1 = GetItemPossessedBy(oPC,sCheck1);
  object oObject2 = GetItemPossessedBy(oPC,sCheck2);
  object oObject3 = GetItemPossessedBy(oPC,sCheck3);
  object oObject4 = GetItemPossessedBy(oPC,sCheck4);
  if(!MothGetComponentCheckEpic(oPC,oObject1,oObject2,oObject3,oObject4)){return;}
  int nStackBase1 = GetItemStackSize(oObject1);
  int nStackBase2 = GetItemStackSize(oObject2);
  int nStackBase3 = GetItemStackSize(oObject3);
  int nStackBase4 = GetItemStackSize(oObject4);
  if(!MothGetComponentStackSizeEpic(oPC,nStack1,nStack2,nStack3,nStack4,nStackBase1,nStackBase2,nStackBase3,nStackBase4)){return;}
  MothAdjustNewComponentStackSizeEpic(oPC,oObject1,oObject2,oObject3,oObject4,nStack1,nStack2,nStack3,nStack4,nStackBase1,nStackBase2,nStackBase3,nStackBase4);
  FloatingTextStringOnCreature("<cðøþ>*Craft Trap: Success!*</c>",OBJECT_SELF,TRUE);
  object oTrap = CreateItemOnObject(sTrap,oPC);
  SetIdentified(oTrap,TRUE);
}
//void main() {}
