/*const float RESPAWN_TIMER_DEFAULT = 10.0; // Default respawn delay
const int   DO_CRAFT_DROP         = FALSE;// Drop default Bioware crafting item?
void SE_RespawnDoor(object oSelf);
void SE_RespawnDoor(object oSelf)
{
    PlayAnimation(ANIMATION_DOOR_CLOSE);
    int nHealAmount = GetMaxHitPoints(oSelf) - GetCurrentHitPoints(oSelf);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHealAmount), oSelf);
}
void main()
{
    object oSelf = OBJECT_SELF;
    SetIsDestroyable(FALSE);

    float fDelay = GetLocalFloat(oSelf, "RESPAWN_TIMER");
    if(fDelay == 0.0)
        fDelay = RESPAWN_TIMER_DEFAULT;

    DelayCommand(fDelay, SE_RespawnDoor(oSelf));
    if(DO_CRAFT_DROP)
        craft_drop_placeable();
}
