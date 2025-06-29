#include "moth_inc_hb"
void main()
{
    object oMOD = GetModule();
    int nTimer = GetLocalInt(oMOD,"MOTHAMBERTIMER");
    int nCheck;
    if(nTimer>1)
    {
      return;
    }
    object oTarget;
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        SetLocalInt(oMOD,"MOTHAMBERTIMER",1);
        if(!MothGetIsFortAlly(oTarget))
        {
         MothAmberChager();
         MothAmberStart();
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }
}
