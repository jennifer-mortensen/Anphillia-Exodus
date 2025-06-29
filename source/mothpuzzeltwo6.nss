void main()
{
object oPC = GetLastUsedBy();
object oMod = GetModule();
object oDoor = GetObjectByTag("mothpuzzeltwodoor");
object oDoor2 = GetObjectByTag("mothTempleDoor1");
object oDoor3 = GetObjectByTag("mothTempleDoor2");
object oDoor4 = GetObjectByTag("mothTempleDoor3");
object oDoor5 = GetObjectByTag("mothTempleDoor4");
object oDoor6 = GetObjectByTag("mothTempleDoor5");
object oDoor7 = GetObjectByTag("mothTempleDoor6");
object oDoor8 = GetObjectByTag("mothTempleDoor7");
object oDoor9 = GetObjectByTag("ToBemfas");
object oCrystal = GetObjectByTag("mothriddle1");
int nInt = GetLocalInt(oMod, "Mothpuzz2");
    if (nInt <= 4)
    {
    SetLocked(OBJECT_SELF, TRUE);
    ActionCloseDoor(OBJECT_SELF);
    return;
    }
    if (nInt = 5)
    {
    SendMessageToPC(oPC, "You hear a faith clicking sound followed by a loud crash.");
    SetLocked(oDoor, FALSE);
    SetLocked(oDoor2, FALSE);
    SetLocked(oDoor3, FALSE);
    SetLocked(oDoor4, FALSE);
    SetLocked(oDoor5, FALSE);
    SetLocked(oDoor6, FALSE);
    SetLocked(oDoor7, FALSE);
    SetLocked(oDoor8, FALSE);
    SetLocked(oDoor9, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE),oCrystal);
    DelayCommand(1.0, DestroyObject(OBJECT_SELF));
    }
}

