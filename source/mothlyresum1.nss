#include "x2_inc_spellhook"
void main()
{
    object oPC = GetItemActivator();
    int nRandom = d6();
    effect eEffect;
    string sName;
    MothUnsummonMultipleSummons();
    switch (nRandom)
       {
        case  1 : sName = "bekisum1"; break;
        case  2 : sName = "bekisum2"; break;
        case  3 : sName = "bekisum3"; break;
        case  4 : sName = "bekisum4"; break;
        case  5 : sName = "bekisum5"; break;
        case  6 : sName = "bekisum6"; break;
       }
       eEffect = EffectSummonCreature(sName,VFX_NONE);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, HoursToSeconds(40));

}
