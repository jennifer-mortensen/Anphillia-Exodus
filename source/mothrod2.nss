void main()
{
object oPC = GetLastKiller();
object oMod = GetModule();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }
if (!GetIsPC(oPC)) return;
int nInt;
nInt = GetLocalInt(oMod, "mothrockkill");
nInt += 1;
SetLocalInt(oMod, "mothrockkill", nInt);
nInt=GetLocalInt(oMod, "mothrockkill");
if (nInt >= 4)
   {
    object oTarget;
    object oTarget1;
    object oTarget2;
    object oTarget3;
    object oTarget4;
    object oTarget5;
    object oTarget6;
    object oBeam;
    object oRay;
    object oChain;
    object oBeam1;
    object oRay1;
    object oChain1;

    oBeam = GetObjectByTag("mothoemitter1a");
    oRay = GetObjectByTag("mothoemitter2a");
    oChain = GetObjectByTag("mothoemitter3a");
    oBeam1 = GetObjectByTag("mothoemitter1b");
    oRay1 = GetObjectByTag("mothoemitter2b");
    oChain1 = GetObjectByTag("mothoemitter3b");
    oTarget = GetObjectByTag("SourceGem");
    oTarget1 = GetObjectByTag("motheledoor1");
    oTarget2 = GetObjectByTag("mothboom1");
    oTarget3 = GetObjectByTag("mothboom2");
    oTarget4 = GetObjectByTag("InvisibleMothLarge1");
    oTarget5 = GetObjectByTag("InvisibleMothLarge2");
    oTarget6 = GetObjectByTag("InvisibleMothLarge3");


    DestroyObject(oBeam, 3.0);
    DestroyObject(oRay, 3.0);
    DestroyObject(oChain, 3.0);
    DestroyObject(oBeam1, 3.0);
    DestroyObject(oRay1, 3.0);
    DestroyObject(oChain1, 3.0);
    DestroyObject(oTarget, 3.0);
    DestroyObject(oTarget4, 3.0);
    DestroyObject(oTarget5, 3.0);
    DestroyObject(oTarget6, 3.0);

    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION), oTarget));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oTarget));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget2));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE), oTarget3));
    DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget2));
    DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), oTarget3));
    DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_ELECTRIC_EXPLOSION), oTarget2));
    DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget3));
    DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget2));
    DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), oTarget3));
    DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), oTarget2));
    DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget3));
   }

}
