#include "x2_inc_spellhook"
void main()
{
    object oCaster = OBJECT_SELF;
    if(!GetHasEffect(EFFECT_TYPE_POLYMORPH,oCaster)){return;}
    if(MothGetIsDisabledShifterHeal(oCaster)){return;}
    int iTimer = GetLocalInt(oCaster, "ShifterHealSpell");
    int iTimer2 = GetLocalInt(oCaster, "RDDHealSpell");
    int nShifterLevels = GetLevelByClass(CLASS_TYPE_SHIFTER,oCaster);
    int nRDDLevels = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oCaster);
    if(nShifterLevels>1)
    {
    if(iTimer<3)
    {
    iTimer+=1;
    SetLocalInt(oCaster, "ShifterHealSpell", iTimer);
    MothShifterHeal(oCaster,nShifterLevels);
    return;
    }
    }
    else if(nRDDLevels>1)
    {
    if(iTimer2<3)
    {
    iTimer2+=1;
    SetLocalInt(oCaster, "RDDHealSpell", iTimer2);
    MothRDDHeal(oCaster,nRDDLevels);
    return;
    }
    }
}
