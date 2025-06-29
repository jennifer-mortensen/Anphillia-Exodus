void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);


object oTarget1 = GetObjectByTag("mothweird1");
object oTarget2 = GetObjectByTag("mothweird2");
object oTarget3 = GetObjectByTag("mothweird3");
object oTarget4 = GetObjectByTag("mothweird4");
object oTarget5 = GetObjectByTag("mothweird5");
object oTarget6 = GetObjectByTag("mothweird6");

DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget1)));
DelayCommand(55.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget1)));
DelayCommand(80.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget1)));
DelayCommand(105.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget1)));
DelayCommand(125.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget1)));
DelayCommand(155.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget1)));

DelayCommand(35.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget2)));
DelayCommand(70.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget2)));
DelayCommand(90.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget2)));
DelayCommand(115.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget2)));
DelayCommand(135.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget2)));
DelayCommand(175.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget2)));

DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget3)));
DelayCommand(55.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget3)));
DelayCommand(80.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget3)));
DelayCommand(105.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget3)));
DelayCommand(125.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget3)));
DelayCommand(155.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget3)));

DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget4)));
DelayCommand(55.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget4)));
DelayCommand(80.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget4)));
DelayCommand(105.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget4)));
DelayCommand(125.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget4)));
DelayCommand(155.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget4)));

DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget5)));
DelayCommand(55.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget5)));
DelayCommand(80.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget5)));
DelayCommand(105.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget5)));
DelayCommand(125.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget5)));
DelayCommand(155.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget5)));

DelayCommand(15.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget6)));
DelayCommand(55.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget6)));
DelayCommand(80.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget6)));
DelayCommand(105.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget6)));
DelayCommand(125.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget6)));
DelayCommand(155.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WEIRD), GetLocation(oTarget6)));
}
