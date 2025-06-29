void main()
{
object oPC = GetEnteringObject();
object oTarget;
object oBeam;
object oRay;
object oChain;
object oNod;
object oGoal;
object oNod2;
object oNod3;
object oNod4;



oBeam = GetObjectByTag("mothiceboulder1");
oRay = GetObjectByTag("mothiceboulder2");
oChain = GetObjectByTag("mothiceboulder3");
oNod = GetObjectByTag("mothiceboulder4");
oGoal = GetObjectByTag("SourceGem");
oNod2 = GetObjectByTag("mothemitter1a");
oNod3 = GetObjectByTag("mothemitter1b");
oNod4 = GetObjectByTag("mothemitter1c");



if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
effect eBeam = EffectBeam(VFX_BEAM_EVIL, oBeam, BODY_NODE_CHEST);
effect eBeam2 = EffectBeam(VFX_BEAM_COLD, oRay, BODY_NODE_CHEST);
effect eBeam3 = EffectBeam(VFX_BEAM_MIND, oChain, BODY_NODE_CHEST);
effect eBeam4 = EffectBeam(VFX_BEAM_HOLY, oNod, BODY_NODE_CHEST);
effect eBeam5 = EffectBeam(VFX_BEAM_LIGHTNING, oNod2, BODY_NODE_CHEST);
effect eBeam6 = EffectBeam(VFX_BEAM_SILENT_LIGHTNING, oNod3, BODY_NODE_CHEST);
effect eBeam7 = EffectBeam(VFX_BEAM_LIGHTNING, oNod4, BODY_NODE_CHEST);
effect eStrike = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
{

    SetPlotFlag(oBeam, FALSE);
    SetPlotFlag(oRay, FALSE);
    SetPlotFlag(oChain, FALSE);
    SetPlotFlag(oNod, FALSE);
    //---
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam, oGoal));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oGoal));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam3, oGoal));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam4, oGoal));
    DelayCommand(9.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,0.5));
    DelayCommand(8.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,0.5));
    DelayCommand(8.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,0.5));
    //---
    DelayCommand(19.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(17.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,0.5));
    DelayCommand(18.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,0.5));
    DelayCommand(18.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,0.5));
    //---
    DelayCommand(29.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(27.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,0.5));
    DelayCommand(28.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,0.5));
    DelayCommand(28.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,0.5));
    //---
    DelayCommand(39.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(37.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,0.5));
    DelayCommand(38.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,0.5));
    DelayCommand(38.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,0.5));
    //---
    DelayCommand(49.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(47.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,0.5));
    DelayCommand(48.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,0.5));
    DelayCommand(48.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,0.5));
    //---
    DelayCommand(69.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(67.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(68.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(68.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(89.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(87.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(88.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(88.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(109.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(107.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(108.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(108.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(129.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(127.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(128.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(128.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(159.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(157.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(158.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(158.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(149.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(147.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(148.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(148.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(169.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(167.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(168.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(168.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(189.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(187.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(188.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(188.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(219.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(217.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(218.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(218.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(239.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(237.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(238.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(238.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(259.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(257.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(258.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(258.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(289.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(287.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(288.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(288.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(319.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(317.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(318.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(318.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(339.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(337.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(338.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(338.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
    //---
    DelayCommand(369.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oGoal));
    DelayCommand(367.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam5, oGoal,1.0));
    DelayCommand(368.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam6, oGoal,1.0));
    DelayCommand(368.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam7, oGoal,1.0));
}

}


