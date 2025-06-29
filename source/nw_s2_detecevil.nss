#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    object oCaster = OBJECT_SELF;
    int nLevel = MothGetCasterLevel(oCaster);
    effect eDur = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDur, oCaster));
    location lLocation = GetLocation(oCaster);
    float fRandom1 = IntToFloat(d20(1));
    float fRandom2 = IntToFloat(d20(1));
    float fRandom3 = IntToFloat(d20(1));
    float fRandom4 = IntToFloat(d20(1));
    float fRandom5 = IntToFloat(d20(1));
    location lTarget1 = GenerateNewLocationFromLocation(lLocation,65.0+fRandom1,300.0+fRandom1,300.0+fRandom1);
    location lTarget2 = GenerateNewLocationFromLocation(lLocation,65.0+fRandom2,75.0+fRandom2,75.0+fRandom2);
    location lTarget3 = GenerateNewLocationFromLocation(lLocation,65.0+fRandom3,150.0+fRandom3,150.0+fRandom3);
    location lTarget4 = GenerateNewLocationFromLocation(lLocation,65.0+fRandom4,175.0+fRandom4,175.0+fRandom4);
    location lTarget5 = GenerateNewLocationFromLocation(lLocation,65.0+fRandom5,250.0+fRandom5,250.0+fRandom5);
    object oBird1 = CreateObject(OBJECT_TYPE_CREATURE,"mothscoutbird",lLocation,TRUE);
    object oBird2 = CreateObject(OBJECT_TYPE_CREATURE,"mothscoutbird",lLocation,TRUE);
    object oBird3 = CreateObject(OBJECT_TYPE_CREATURE,"mothscoutbird",lLocation,TRUE);
    object oBird4 = CreateObject(OBJECT_TYPE_CREATURE,"mothscoutbird",lLocation,TRUE);
    object oBird5 = CreateObject(OBJECT_TYPE_CREATURE,"mothscoutbird",lLocation,TRUE);
    AssignCommand(oBird1,ActionMoveToLocation(lTarget1,TRUE));
    AssignCommand(oBird2,ActionMoveToLocation(lTarget2,TRUE));
    AssignCommand(oBird3,ActionMoveToLocation(lTarget3,TRUE));
    AssignCommand(oBird4,ActionMoveToLocation(lTarget4,TRUE));
    AssignCommand(oBird5,ActionMoveToLocation(lTarget5,TRUE));
    PlaySound("as_an_birdsflap2");
    PlaySound("as_an_birdsflap1");
    PlaySound("as_an_birdflap1");
    PlaySound("as_an_birdflap2");
    DelayCommand(0.1,PlaySound("as_an_birdsflap2"));
    object oTarget;
    int nLoop = 0;
    int nCount = 0;
    for (nLoop = 1; nLoop <= nLevel; nLoop++)
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oCaster, nLoop, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
        if (GetIsObjectValid(oTarget) == TRUE)
        {
         SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), FALSE));
         nCount++;
        }
    }
    if(nCount>0)
    {
     if(nCount<2)
     {
     DelayCommand(6.0,FloatingTextStringOnCreature("<cðæŒ>*"+GetName(oCaster)+"'s Scout Birds report one enemy in the area!*</c>",OBJECT_SELF));
     }
     else
     {
     DelayCommand(6.0,FloatingTextStringOnCreature("<cðæŒ>*"+GetName(oCaster)+"'s Scout Birds report "+IntToString(nCount)+" enemies in the area!*</c>",OBJECT_SELF));
     }
    }
    else
    {
     DelayCommand(6.0,FloatingTextStringOnCreature("<cðæŒ>*"+GetName(oCaster)+"'s Scout Birds could not find any enemies in the area!*</c>",OBJECT_SELF));
    }
}

