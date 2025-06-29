// Governs the random events that can occur in an area, based on the areas tag.
// For direct control of events, put a trigger in an area and place the "mothrandomevent" script
// on the triggers OnEnter event. Then use the areas tag to set what is going to happened
// when the PC walks on the trigger. There is a 20% chance something will happened.
// So only 81 to 100 on nDice will have an actual event.
void MothRandomEvent(object oPC,int nDice);
void MothRandomEvent(object oPC,int nDice)
{
     object oArea = GetArea(oPC);
     string sArea = GetTag(oArea);
     string sPC = GetName(oPC);
     if(nDice<=80){return;}
     if(nDice>=101){return;}
     int nTriggered = GetLocalInt(oPC,"MothHadTriggeredRandom");
     //Set the events for various areas.
     if(nTriggered == TRUE){return;}
     if(sArea == "SerisIslandBugbearsCaveSublevel" ||
        sArea == "SerisIslandBugbearsCaveQua" ||
        sArea == "SerisIslandBugbearsDen1" ||
        sArea == "SerisIslandBugbearsCaveSubterran" ||
        sArea == "RanzingtonCryptsWake" ||
        sArea == "RanzingtonCryptsDepths" ||
        sArea == "RanzingtonCryptsSubmerged")
     {
      if (nDice>80 && nDice <101){SetLocalInt(oPC,"MothHadTriggeredRandom",TRUE);}
      if (nDice==81)
         {
            FloatingTextStringOnCreature("<cþ  >"+sPC+" picks up gold coins from the ground.</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >You found some gold!</c>");
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
            GiveGoldToCreature(oPC,1100+d100(20));
          }
      if (nDice==82)
         {
            FloatingTextStringOnCreature("<cþ  >"+sPC+" appears thirsting for battle!</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >Your sense of battle feel more intuned!</c>");
            AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_BATTLECRY1));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(10, ATTACK_BONUS_MISC), oPC, HoursToSeconds(4));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_YELLOW), oPC, HoursToSeconds(4));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oPC);
          }
      if (nDice==83)
         {
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" appears not to fear any magic!</c>", oPC));
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >Your arcane insight has become epic!You are now immune to all hostile magic for a short while!</c>"));
            DelayCommand(13.5,AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_CHEER)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSpellLevelAbsorption(9, 0, SPELL_SCHOOL_GENERAL),oPC, HoursToSeconds(2)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_ORANGE), oPC, HoursToSeconds(2)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY), oPC, HoursToSeconds(2)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN), oPC, HoursToSeconds(2)));
         }
      if (nDice==84)
         {
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >You feel exceptionally sharp and alert!</c>"));
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems extremely alert!</c>", oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_LISTEN,30), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPOT,30), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SEARCH,30), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_WHITE), oPC, HoursToSeconds(4)));
         }
      if (nDice==85)
         {
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >You feel exceptionally resilliant!</c>"));
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems extremely stalwart!</c>", oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,30), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,30), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,30), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_ICESKIN), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(495), oPC, HoursToSeconds(4)));
         }
      if (nDice==86)
         {
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >You feel exceptionally durable!</c>"));
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" looks extremely tough!</c>", oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,50), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,50), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,50), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,50), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS), oPC, HoursToSeconds(4)));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED), oPC, HoursToSeconds(4)));
         }
      if (nDice==87)
         {
            FloatingTextStringOnCreature("<cþ  >"+sPC+" read some writing on the ground.</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >You found a nugget of wisdom!</c>");
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
            GiveXPToCreature(oPC,175+d100(1));
          }
      if (nDice==88)
         {
            FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found something.</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >You found a Scroll!</c>");
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
            CreateItemOnObject("x2_it_spdvscr605", oPC, 5);
          }
      if (nDice==89)
         {
            FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found something.</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >You found a Scroll!</c>");
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
            CreateItemOnObject("x2_it_spdvscr801", oPC, 2);
          }
      if (nDice==90)
         {
            FloatingTextStringOnCreature("<cþ  >"+sPC+" picks up gold coins from the ground.</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >You found some gold!</c>");
            AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
            GiveGoldToCreature(oPC,8800+d100(20));
          }
      if (nDice==91)
         {
            /*effect eEffect = EffectAttackDecrease(20, ATTACK_BONUS_MISC);
            eEffect = SupernaturalEffect(eEffect);
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >The poor sight and the thick air affects you in a bad way. Your aim is way off!</c>"));
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have problems with eye-hand cordination!</c>", oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, HoursToSeconds(4)));*/
            return;
         }
      if (nDice==92)
         {
            /*effect eEffect1 = EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL, 25);
            effect eEffect2 = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 25);
            effect eEffect3 = EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD, 25);
            effect eEffect4 = EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID, 25);
            effect eEffect  = EffectLinkEffects(eEffect1,eEffect2);
            eEffect  = EffectLinkEffects(eEffect,eEffect3);
            eEffect  = EffectLinkEffects(eEffect,eEffect4);
            eEffect = SupernaturalEffect(eEffect);
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >The toxic air makes you feel sick!</c>"));
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" doesn't look too well.</c>", oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, HoursToSeconds(4)));*/
            return;
         }
      if (nDice==93)
         {
            /*effect eEffect1 = EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING, 25);
            effect eEffect2 = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING, 25);
            effect eEffect3 = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING, 25);
            effect eEffect  = EffectLinkEffects(eEffect1,eEffect2);
            eEffect  = EffectLinkEffects(eEffect,eEffect3);
            eEffect = SupernaturalEffect(eEffect);
            DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >The toxic air makes you feel sick!</c>"));
            DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" looks weakened.</c>", oPC));
            DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, HoursToSeconds(4)));*/
            return;
         }
      if (nDice==94)
         {
            /*effect eSpell = EffectSpellFailure(100, SPELL_SCHOOL_GENERAL);
            effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_GREY);
            effect eLink = EffectLinkEffects(eSpell, eGlow);
            eLink = SupernaturalEffect(eLink);
            FloatingTextStringOnCreature("<cþ  >"+sPC+" appears to be blocked in some mannor.</c>", oPC);
            SendMessageToPC(oPC, "<cþ  >You feel the power of magic and all its surroundings sucked out of your entire being. You can no longer use magic or any of your sequencers!</c>");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(6));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oPC); */
            return;
         }
      if (nDice==95 || nDice==96)
         {
            /*effect eHurt = EffectDamage(d20(10), DAMAGE_TYPE_ACID);
            effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
            effect eFoot = EffectAbilityDecrease(ABILITY_STRENGTH,10);
            eFoot = SupernaturalEffect(eFoot);
            location lTrim = GetLocation(oPC);
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.3,SendMessageToPC(oPC, "<cþ  >Trap Triggered - a lose floorbrick breaks off and your foot sinks into a pool of boiling acid. Your foot is severly injured!</c>"));
            DelayCommand(10.3,FloatingTextStringOnCreature("<cþ  >"+sPC+" triggers a trap!</c>", oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHurt, oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFoot, oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC)); */
            return;
         }
      if (nDice==97 || nDice==98)
         {
            /*effect eHurt = EffectDamage(d20(10), DAMAGE_TYPE_FIRE);
            effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
            effect eHand = EffectAttackDecrease(20, ATTACK_BONUS_MISC);
            eHand = SupernaturalEffect(eHand);
            location lTrim = GetLocation(oPC);
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.3,SendMessageToPC(oPC, "<cþ  >Trap Triggered - a lose floorbrick breaks off and you fall into a pit of flames. Your hands are burned and hurt badly!</c>"));
            DelayCommand(10.3,FloatingTextStringOnCreature("<cþ  >"+sPC+" triggers a trap!</c>", oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHurt, oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHand, oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC)); */
            return;
         }
      if (nDice==98 || nDice==99)
         {
            effect eHurt = EffectDamage(d20(10), DAMAGE_TYPE_COLD);
            effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
            location lTrim = GetLocation(oPC);
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.3,SendMessageToPC(oPC, "<cþ  >Trap Triggered - a lose floorbrick breaks off and you get exposed to extreme cold!</c>"));
            DelayCommand(10.3,FloatingTextStringOnCreature("<cþ  >"+sPC+" triggers a trap!</c>", oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHurt, oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
            return;
         }
      if (nDice==100)
         {
            effect eHurt = EffectDamage(d20(10), DAMAGE_TYPE_ELECTRICAL);
            effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
            location lTrim = GetLocation(oPC);
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), lTrim));
            DelayCommand(10.3,SendMessageToPC(oPC, "<cþ  >Trap Triggered - a lose floorbrick breaks off and you get shocked!</c>"));
            DelayCommand(10.3,FloatingTextStringOnCreature("<cþ  >"+sPC+" triggers a trap!</c>", oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHurt, oPC));
            DelayCommand(10.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC));
         }
     }
     //Next area group.
     if(sArea == "EDITInsertMoreAreas" ||
        sArea == "EDITInsertMoreAreas")
     {
      if (nDice==81)
         {
         }
      if (nDice==82)
         {
         }
     }
}
//void main() {}
