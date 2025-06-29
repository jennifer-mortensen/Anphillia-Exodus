int GetIsIndoors(object area)
{
    string areaTag = GetTag(area);
    //SpeakString("IsIndoors: "+areaTag+" "+GetStringRight(areaTag, 3)+" "+IntToString(GetStringRight(areaTag, 3)=="_in"),TALKVOLUME_SHOUT);
    return (GetStringRight(areaTag, 3)=="_in");
}

int GetIsUnderground(object area)
{
    return (GetIsAreaAboveGround(area) == AREA_UNDERGROUND);
}

int GetIsCastable(object area)
{
    //SpeakString("IsCastable: "+IntToString(!(GetIsIndoors(area)||GetIsUnderground(area))), TALKVOLUME_SHOUT);
    return !(GetIsIndoors(area)||GetIsUnderground(area));
}

void FloatRestrictMsg(object caster)
{
    FloatingTextStringOnCreature("Your spell fizzled out of existance", caster, FALSE);
}

void CauseEarthquake(location targetLoc, object caster)
{
   // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.

   // tell the caster object to shake the screen
   AssignCommand( caster, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), targetLoc));
   AssignCommand ( caster, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), targetLoc)));
   AssignCommand ( caster, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), targetLoc)));
   AssignCommand ( caster, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), targetLoc)));
   AssignCommand ( caster, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), targetLoc)));

   // tell the caster object to play an earthquake sound
   AssignCommand ( caster, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( caster, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( caster, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   object oTargetArea = GetArea(caster);

   object oKnockdownTarget = GetFirstObjectInShape(SHAPE_CUBE, 15.0, targetLoc, OBJECT_TYPE_CREATURE);
   int nRandom;
   float fRandom;
   while(GetIsObjectValid(oKnockdownTarget))
   {
      if (GetIsDM(oKnockdownTarget) == FALSE)
      {
         if (GetSkillRank ( SKILL_DISCIPLINE, oKnockdownTarget) <= 9)
         {
            nRandom=d6(1);
            fRandom=IntToFloat(nRandom);
            DelayCommand(fRandom, AssignCommand ( oKnockdownTarget, ApplyEffectToObject (DURATION_TYPE_TEMPORARY, EffectKnockdown(), oKnockdownTarget, 6.0)));
            DelayCommand(fRandom, AssignCommand ( oKnockdownTarget, ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectDamage(d20(), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oKnockdownTarget)));
         }
      }
      oKnockdownTarget = GetNextObjectInShape(SHAPE_CUBE, 15.0, targetLoc, OBJECT_TYPE_CREATURE);
   }

   //Create dust plumes in random locations around the DM
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPositionFromLocation(targetLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
   }
}
