void main()
{
    DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    object oRune = OBJECT_SELF;
    object oDoor = GetObjectByTag("mothrunepuzzledoor");
    object oDoor2 = GetObjectByTag("mothmindflayerdoor1");
    object oDoor3 = GetObjectByTag("mothmindflayerdoor2");
    object oPC = GetLastUsedBy();
    string sRuneTag = GetTag(oRune);
    string sKeyResref = GetStringRight(sRuneTag, GetStringLength(sRuneTag) - 6);
    int nNumber = StringToInt(GetSubString(sRuneTag, 4, 1));
    int nLastRuneUsed = GetLocalInt(oPC, "RUNE_" + sKeyResref);
    int nIsFinalRune = GetLocalInt(oRune, "LAST_RUNE");
    if ((oRune == OBJECT_INVALID) || (oPC == OBJECT_INVALID) || (nNumber == 0))
    {
        SendMessageToAllDMs("Error! Rune tag is set incorrectly, or Rune or PC do not exist.");
        return;
    }
    else if (nLastRuneUsed + 1 == nNumber)
    {
        effect eCompleteA = EffectVisualEffect(VFX_IMP_KNOCK);
        effect eCompleteB = EffectVisualEffect(VFX_DUR_GLOW_BLUE);
        effect eComplete = EffectLinkEffects(eCompleteA,eCompleteB);
        effect eComplete2A = EffectVisualEffect(VFX_IMP_KNOCK);
        effect eComplete2B= EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eComplete2 = EffectLinkEffects(eComplete2A,eComplete2B);
        effect eCorrect = EffectVisualEffect(VFX_IMP_KNOCK);
        if (nIsFinalRune != 0)
        {
            DeleteLocalInt(oPC, "RUNE_" + sKeyResref);
            SetLocked(oDoor,FALSE);
            SetLocked(oDoor2,FALSE);
            SetLocked(oDoor3,FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eComplete2, oDoor);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eComplete2, oDoor2);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eComplete2, oDoor3);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eComplete, oRune, 2.0);
            SendMessageToPC(oPC,"<c ¥ >You hear a ticking sound followed by a loud knock.</c>");
        }
        else
        {
            SetLocalInt(oPC, "RUNE_" + sKeyResref, nNumber);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eCorrect, oRune);
            SendMessageToPC(oPC,"<c ¥ >You hear a ticking sound.</c>");
        }
    }
    else
    {
        effect eWrong = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        effect ePenalize = EffectLinkEffects(EffectDamage(d20(3), DAMAGE_TYPE_ACID, DAMAGE_POWER_PLUS_FIVE), EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID));
        SendMessageToPC(oPC,"<c ¥ >You hear a short knocking sound.</c>");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eWrong, oRune);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, ePenalize, oPC);
        DeleteLocalInt(oPC, "RUNE_" + sKeyResref);
        DelayCommand(1.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}





