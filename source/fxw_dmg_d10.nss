void main()
{
    object oDM = GetLastSpeaker();
    object oMyTarget = GetLocalObject(oDM, "FXWandTarget");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d4(1)), oMyTarget);
}
