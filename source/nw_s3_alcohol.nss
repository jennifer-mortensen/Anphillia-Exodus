//::///////////////////////////////////////////////
//:: NW_S3_Alcohol.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Makes beverages fun.
  May 2002: Removed fortitude saves. Just instant intelligence loss
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   February 2002
//:://////////////////////////////////////////////

void DrinkIt(object oTarget)
{
   // AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
   int nLine = Random(6);
   switch (nLine)
   {
      case 0:
         AssignCommand(oTarget,ActionSpeakStringByStrRef(10499));
         break;
      case 1:
         AssignCommand(oTarget,ActionSpeakString("*hic*"));
         break;
      case 2:
         AssignCommand(oTarget,ActionSpeakString("tough stuff.. *hic*"));
         break;
      case 3:
         // AssignCommand(oTarget,ActionSpeakString("ow.. my head"));
         break;
      case 4:
         // AssignCommand(oTarget,ActionSpeakString("why's there suddenly 2 of everyone?"));
         break;
      case 5:
         // AssignCommand(oTarget,ActionSpeakString("need to... breathe... want fresh.. air!"));
         break;
   }
}

void MakeDrunk(object oTarget, int nPoints)
{
    if (Random(100) + 1 < 40)
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
    else
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));

    int nConDamage = GetLocalInt(oTarget, "Drunk") + Random(nPoints + 1);
    effect eAll;
    effect eDumb = EffectAbilityDecrease(ABILITY_INTELLIGENCE, Random(nPoints + 1));
    effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION, nConDamage);
    effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY, Random(nPoints + 1));
    eAll = EffectLinkEffects(eDumb, eAll);
    eAll = EffectLinkEffects(eCon, eAll);
    eAll = EffectLinkEffects(eDex, eAll);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAll, oTarget, 360.0);
    SetLocalInt(oTarget, "Drunk", nConDamage);

    if (GetAbilityScore(oTarget, ABILITY_CONSTITUTION) <= 10)
    {
       int nCollapse = Random (100);
       int nResistance = 10 + (nPoints * 10);
       if (nCollapse <= nResistance)
       {
          // collapse
          effect eCollapse;
          effect eBlind = EffectBlindness();
          effect eVisSleep = EffectVisualEffect(VFX_IMP_SLEEP);
          eCollapse = EffectLinkEffects(eBlind, eCollapse);
          eCollapse = EffectLinkEffects(eVisSleep, eCollapse);
          AssignCommand(oTarget, ClearAllActions(TRUE));
          AssignCommand(oTarget, ActionSpeakString("Oh, i don't feel so well..."));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCollapse, oTarget, 180.0);
          AssignCommand(oTarget, ActionPlayAnimation( ANIMATION_LOOPING_DEAD_FRONT, 1.0, 180.0));
          DelayCommand(2.5, SetCommandable(FALSE, oTarget));
          DelayCommand(180.0, SetCommandable(TRUE, oTarget));
          SetLocalInt(oTarget, "Drunk", 0);
       }
    }
 //   AssignCommand(oTarget, SpeakString(IntToString(GetAbilityScore(oTarget,ABILITY_INTELLIGENCE))));
}

void main()
{
    object oTarget = GetSpellTargetObject();
   // SpeakString("here");
    // * Beer
    if (GetSpellId() == 406)
    {
        // *burp*
        //AssignCommand(oTarget, SpeakString("Beer"));
        DrinkIt(oTarget);
        if (FortitudeSave(oTarget, 10) == 0)
        {
            MakeDrunk(oTarget, 1);
        }
    }
    else
    // *Wine
    if (GetSpellId() == 407)
    {
        DrinkIt(oTarget);
        if (FortitudeSave(oTarget, 15) == 0)
        {
            MakeDrunk(oTarget, 2);
        }
    }
    else
    // * Spirits
    if (GetSpellId() == 408)
    {
        DrinkIt(oTarget);
        if (FortitudeSave(oTarget, 25) == 0)
        {
            MakeDrunk(oTarget, 3);
        }
     }

}
