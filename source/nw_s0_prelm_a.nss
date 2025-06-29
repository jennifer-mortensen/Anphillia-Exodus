#include "x2_inc_spellhook"
#include "nw_i0_generic"
//Bloods Bindings
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int iTimer = GetLocalInt(OBJECT_SELF, "FocusSpellBB");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cþ  >*No School focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now. The spell is lost.</c>");
    return;
    }
    effect eAOE1 = EffectAreaOfEffect(AOE_PER_STORM,"nw_s0_prelm_ae","nw_s0_prelm_ab","nw_s0_prelm_ax");
    effect eAOE2 = EffectAreaOfEffect(AOE_PER_FOGKILL,"nw_s0_prelm_ax","nw_s0_prelm_ax","nw_s0_prelm_ax");
    effect eAOE3 = EffectAreaOfEffect(40,"nw_s0_prelm_ax","nw_s0_prelm_ax","nw_s0_prelm_ax");
    effect eAOE = EffectLinkEffects(eAOE1,eAOE2);
    eAOE = EffectLinkEffects(eAOE3,eAOE);
    location lTarget = GetSpellTargetLocation();
    int nDuration = MothGetCasterLevel(OBJECT_SELF)/2;
    effect eImpact = EffectVisualEffect(VFX_FNF_STORM);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,10.0))
    {
     FloatingTextStringOnCreature("<cþ  >*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    SetLocalInt(OBJECT_SELF, "FocusSpellBB", TRUE);
    DelayCommand(33.0, DeleteLocalInt(OBJECT_SELF, "FocusSpellBB"));
    DelayCommand(33.0, FloatingTextStringOnCreature("<cþ  >*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    /*float fDice1 = IntToFloat(d3());
    float fDice2 = IntToFloat(d3());
    float fDice3 = IntToFloat(d3());
    float fDice4 = IntToFloat(d3());
    float fDice5 = IntToFloat(d3());
    float fDice6 = IntToFloat(d3());
    float fDelay1 = GetRandomDelay(0.8,1.5)+fDice1;
    float fDelay2 = GetRandomDelay(1.0,1.7)+fDice2;
    float fDelay3 = GetRandomDelay(0.6,1.2)+fDice3;
    float fDelay4 = GetRandomDelay(0.7,1.4)+fDice4;
    float fDelay5 = GetRandomDelay(0.9,1.6)+fDice5;
    float fDelay6 = GetRandomDelay(0.5,1.0)+fDice6;
    location lTarget1 = GenerateNewLocationFromLocation(lTarget,fDelay1+3.0,0.0,10.0);
    location lTarget2 = GenerateNewLocationFromLocation(lTarget,fDelay2+3.0,75.0,75.0);
    location lTarget3 = GenerateNewLocationFromLocation(lTarget,fDelay3+1.0,150.0,150.0);
    location lTarget4 = GenerateNewLocationFromLocation(lTarget,fDelay4+3.0,175.0,175.0);
    location lTarget5 = GenerateNewLocationFromLocation(lTarget,fDelay5+3.0,250.0,250.0);
    location lTarget6 = GenerateNewLocationFromLocation(lTarget,fDelay6+3.0,40.0,40.0);
    string tag = GetPCPublicCDKey(GetLastSpellCaster());
    object oTarget = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvisfog",lTarget, FALSE, "BB0-" + tag);
    object oTarget1 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvis",lTarget1, FALSE, "BB1-" + tag);
    object oTarget2 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvis",lTarget2, FALSE, "BB2-" + tag);
    object oTarget3 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvis",lTarget3, FALSE, "BB3-" + tag);
    object oTarget4 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvis2",lTarget4, FALSE, "BB4-" + tag);
    object oTarget5 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvis2",lTarget5, FALSE, "BB5-" + tag);
    object oTarget6 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothbloodvis2",lTarget6, FALSE, "BB6-" + tag);
    SetLocalInt(OBJECT_SELF, "BLOODBINDING", TRUE);
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget,FALSE));
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget1,FALSE));
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget2,FALSE));
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget3,FALSE));
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget4,FALSE));
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget5,FALSE));
    DelayCommand(RoundsToSeconds(nDuration)-0.5,SetPlotFlag(oTarget6,FALSE));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget1));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget2));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget3));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget4));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget5));
    DelayCommand(RoundsToSeconds(nDuration),DestroyObject(oTarget6));   */
    }
}
