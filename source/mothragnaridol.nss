void main()
{
    object oPC = GetPCSpeaker();
    object oIdol = GetObjectByTag("mothragnaridol");
    object oDoor = GetObjectByTag("mothragnardoorfinal");
    object oDoor2 = GetObjectByTag("mothragnardoortreasure");
    int nMaxHP = GetMaxHitPoints(oPC);
    int nDamage = nMaxHP/2;
    effect eVis = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eDam = EffectDamage(nDamage,DAMAGE_TYPE_POSITIVE,DAMAGE_POWER_PLUS_TWENTY);
    effect eDamage = EffectLinkEffects(eVis,eDam);
    effect eVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eVis1a = EffectVisualEffect(FEAT_PDK_INSPIRE_1);
    effect eVis2a = EffectVisualEffect(FEAT_PDK_INSPIRE_2);
    effect eVis3 = EffectLinkEffects(eVis1,eVis2);
    eVis3 = EffectLinkEffects(eVis3,eVis1a);
    eVis3 = EffectLinkEffects(eVis3,eVis2a);
    AssignCommand(oPC,ActionJumpToObject(oIdol));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oPC);
    DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis3,oDoor));
    SetLocked(oDoor,FALSE);
    SetLocked(oDoor2,FALSE);
    SendMessageToPC(oPC,"<cðøþ>*You experience a sharp pain in your guts as the Idol begins to glow. In your agony you can hear a ticking sound from afar.*</c>");
}
