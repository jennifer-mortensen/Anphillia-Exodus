//spymirror 781
void main()
{
object oTarget = GetWaypointByTag("axfellspy1");
effect eSee = EffectTrueSeeing();
effect eGhost = EffectCutsceneGhost();
effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
effect eMove = EffectCutsceneImmobilize();
eSee = SupernaturalEffect(eSee);
eGhost = SupernaturalEffect(eGhost);
eInvis = SupernaturalEffect(eInvis);
eMove = SupernaturalEffect(eMove);
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSee, oTarget,45.0));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oTarget,45.0));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget,45.0));
DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove, oTarget,45.0));
}
