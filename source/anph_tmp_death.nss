void main()
{
    object oPlayer = GetLastPlayerDied();
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);

}
