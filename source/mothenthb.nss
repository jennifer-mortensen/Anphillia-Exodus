#include "nw_i0_generic"
void main()
{
    ExecuteScript("nw_c2_default1", OBJECT_SELF);
    int HBCountENT = GetLocalInt(OBJECT_SELF, "HBCountENT");
    HBCountENT++;
    SetLocalInt(OBJECT_SELF, "HBCountENT", HBCountENT);
    if(HBCountENT > 4)
    {
    location lLocation = GetLocation(OBJECT_SELF);
    effect eVis2 = EffectVisualEffect(133);
    effect eVis3 = EffectVisualEffect(134);
    effect eVis4 = EffectVisualEffect(135);
    effect eVis5 = EffectVisualEffect(136);
    effect eVis6 = EffectVisualEffect(137);
    location lTarget2 = GenerateNewLocationFromLocation(lLocation,3.0,75.0,75.0);
    location lTarget3 = GenerateNewLocationFromLocation(lLocation,1.0,150.0,150.0);
    location lTarget4 = GenerateNewLocationFromLocation(lLocation,3.0,175.0,175.0);
    location lTarget5 = GenerateNewLocationFromLocation(lLocation,3.0,250.0,250.0);
    location lTarget6 = GenerateNewLocationFromLocation(lLocation,3.0,40.0,40.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis2,lTarget2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis3,lTarget3);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis4,lTarget4);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis5,lTarget5);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis6,lTarget6);
    SetLocalInt(OBJECT_SELF, "HBCountENT", 0);
   }
}
