#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    int nCnt = 1;
    object oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) <= 40.0)
    {
        if(GetIsTrapped(oTrap))
        {
            int iDisarmDC=GetTrapDisarmDC(oTrap);
            int iSaveDC=MothDC();
            int iDetectDC=GetTrapDetectDC(oTrap);
            if ((d10()+iSaveDC) > iDetectDC && GetTrapDetectable(oTrap))
                SetTrapDetectedBy(oTrap, OBJECT_SELF);
            else
            SendMessageToPC(OBJECT_SELF,"<cðøþ>*Failed to Detect any Traps*</c>");
        }
        nCnt++;
        oTrap = GetNearestObject(OBJECT_TYPE_TRIGGER | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }
}

