// Ok Julian I am abit worried that this script will create random events
// abit too often. As it is now there is an approx 20-25%(1d100 with around 25 hits)
// chance that the script will fire when someone steps on the trigger.
// If it does indeed fire then there is a 25% chance(1d4 above 2 nothing happends or wrong gender)
// on most events that nothing happends.
// Some might even require a feat or a certain amount of skillpoint.
// Futhermore a trigger can only be used once per PC and should they roll above 20
// in the FIRST check or fail the secondary check(above 2) the trigge will
// still count as "used". After that it can be stepped on my that PC for an infinite
// number of times without anything happening.
// On top of all this, the trigger won't trigger if the PC or any of the PC's
// teammates are in battle close by. IN this case the trigger will NOT
// be marked as used. This combined to the fact that most effects have a delay
// should add to the confusion to anyone trying to figure out WHERE the triggers are.
// NOTE: The portal that spawns on one of the events leads out of Condors Scream
// to Hope Canyon, the waypoint tagged "entergrimsfromcondor". Make sure it is there
// or (as it is in the old copy of the MOD) or simple create one with that name
// close to the entrance to Condors Screams IN Hope Canyon.
void main()
{
object oPlayer = GetEnteringObject();
if (GetIsInCombat(oPlayer)) return;
if (!GetIsPC(oPlayer)) return;
int DoOnce = GetLocalInt(oPlayer, GetTag(OBJECT_SELF));
int nInt;
int nDice;
int nSearch = GetSkillRank(SKILL_SEARCH, oPlayer)+ d20();
int nLore = GetSkillRank(SKILL_LORE, oPlayer)+ d20();
int nCourt = GetHasFeat(FEAT_COURTLY_MAGOCRACY, oPlayer);
int nAlert = GetHasFeat(FEAT_ALERTNESS, oPlayer);
if (DoOnce==TRUE) return;
SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
nInt = d100();
nDice = d4();
if (nInt==30)
   {
    object oSpawn;
    object oTarget;
    location lTarget;
    object oPC = GetEnteringObject();
    oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC);
    lTarget = GetLocation(oTarget);
    //ResRef - NOT Tag
    oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothenforcer", lTarget);
    SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
   }
if (nInt==31)
   {
     /*if (nDice<=1)
     {
     object oPC = GetEnteringObject();
     string sPC = GetName(oPC);
     DelayCommand(0.5,SendMessageToPC(oPC, "<cþ  >The toxic air makes you feel sick!</c>"));
     DelayCommand(0.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" doesn't look too well.</c>", oPC));
     DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_CONSTITUTION, 2), oPC, HoursToSeconds(50)));
     DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisease(DISEASE_SHAKES), oPC));
     SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
     }
     else
     {
     return;
     } */
     return;
   }
if (nInt==32)
   {
    object oSpawn;
    object oTarget;
    location lTarget;
    object oPC = GetEnteringObject();
    oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC);
    lTarget = GetLocation(oTarget);
    //ResRef - NOT Tag
    oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothmech", lTarget);
    SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
   }
if (nInt==33)
   {
       if (nDice<=1)
       {
       object oPC = GetEnteringObject();
       string sPC = GetName(oPC);
       FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found something.</c>", oPC);
       SendMessageToPC(oPC, "<cþ  >You found some ammo!</c>");
       AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
       //ResRef - NOT Tag
       CreateItemOnObject("motharrow1", oPC, 99);
       SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       return;
       }
   }
if (nInt==34)
   {
       if (nDice<=1)
       {
       object oPC = GetEnteringObject();
       string sPC = GetName(oPC);
       FloatingTextStringOnCreature("<cþ  >"+sPC+" picks up items from the ground.</c>", oPC);
       SendMessageToPC(oPC, "<cþ  >You found some bolts!</c>");
       AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
       //ResRef - NOT Tag
       CreateItemOnObject("mothbolt2", oPC, 99);
       SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       return;
       }
   }
if (nInt==35)
   {
       if (nDice<=1)
       {
       object oPC = GetEnteringObject();
       int nGP = d100(200) + 550;
       string sPC = GetName(oPC);
       FloatingTextStringOnCreature("<cþ  >"+sPC+" picks up something.</c>", oPC);
       SendMessageToPC(oPC, "<cþ  >You found some coins!</c>");
       AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
       GiveGoldToCreature(oPC, nGP);
       SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       return;
       }
   }
if (nInt==36)
   {
       if (nDice<=1)
       {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        FloatingTextStringOnCreature("<cþ  >"+sPC+" appears thirsting for battle!</c>", oPC);
        SendMessageToPC(oPC, "<cþ  >Your sense of battle feel more intuned!</c>");
        AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_BATTLECRY1));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(5, ATTACK_BONUS_MISC), oPC, HoursToSeconds(4));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_YELLOW), oPC, HoursToSeconds(4));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), oPC);
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       return;
       }
   }
if (nInt==37)
   {
       if (nDice<=1)
       {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" appears thirsting for battle!</c>", oPC));
        DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >You feel much more confident to go to battle!</c>"));
        DelayCommand(14.5,AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_BATTLECRY1)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(10, ATTACK_BONUS_MISC), oPC, HoursToSeconds(4)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_YELLOW), oPC, HoursToSeconds(4)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), oPC));
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       }
   }
if (nInt==38)
   {
       if (nDice<=1)
       {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >TO BATTLE!</c>"));
        DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" appears thirsting for battle!</c>", oPC));
        DelayCommand(14.5,AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_BATTLECRY1)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(10, ATTACK_BONUS_MISC), oPC, HoursToSeconds(4)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_YELLOW), oPC, HoursToSeconds(4)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), oPC));
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       return;
       }
   }
if (nInt==39)
   {
       if (nDice<=1)
       {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" appears not to fear any magic!</c>", oPC));
        DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >Your arcane insight has become epic!You are now immune to all hostile magic for a short while!</c>"));
        DelayCommand(13.5,AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_CHEER)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSpellLevelAbsorption(9, 0, SPELL_SCHOOL_GENERAL),oPC, HoursToSeconds(2)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_ORANGE), oPC, HoursToSeconds(2)));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oPC));
        DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY), oPC));
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
       }
       else
       {
       return;
       }
   }
if (nInt==10)
   {

      /*if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >The poor sight and the thick air affects you in a bad way. Your aim is way off!</c>"));
      DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have problems with eye-hand cordination!</c>", oPC));
      DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackDecrease(4, ATTACK_BONUS_MISC), oPC, HoursToSeconds(4)));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }*/
      return;
   }
if (nInt==11)
   {
      /*if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >The poor sight and the thick air affects you in a bad way. Your defense is poor!</c>"));
      DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" appears to have trouble of defending.</c>", oPC));
      DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACDecrease(10, AC_DODGE_BONUS), oPC, HoursToSeconds(4)));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }*/
      return;
   }
if (nInt==12)
   {
      if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      DelayCommand(12.5,SendMessageToPC(oPC, "<cþ  >The poor sight and the thick air affects you in a bad way. Your aim is way off!</c>"));
      DelayCommand(12.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have problems with eye-hand cordination!</c>", oPC));
      DelayCommand(12.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackDecrease(8, ATTACK_BONUS_MISC), oPC, HoursToSeconds(4)));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }
   }
if (nInt==13)
   {
      if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      DelayCommand(1.5,SendMessageToPC(oPC, "<cþ  >You feel exceptionally sharp and alert!</c>"));
      DelayCommand(1.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems extremely alert!</c>", oPC));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_LISTEN,20), oPC, HoursToSeconds(4)));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPOT,20), oPC, HoursToSeconds(4)));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }
   }
if (nInt==14)
   {
       /* if (nDice<=1)
        {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        DelayCommand(2.5,SendMessageToPC(oPC, "<cþ  >The toxic air makes you feel sick!</c>"));
        DelayCommand(2.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" doesn't look too well.</c>", oPC));
        DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_DEXTERITY, 2), oPC, HoursToSeconds(50)));
        DelayCommand(2.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisease(DISEASE_RED_SLAAD_EGGS), oPC));
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
        }
        else
        {
        return;
        }*/
        return;
   }
if (nInt==15)
   {
        if (nAlert == TRUE)
        {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found something.</c>", oPC);
        SendMessageToPC(oPC, "<cþ  >You found a Scroll!");
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
        //ResRef - NOT Tag
        CreateItemOnObject("mothsummonbalrog", oPC, 1);
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
        }
        else
        {
        return;
        }
   }
if (nInt==16)
   {
        if (nCourt == TRUE)
        {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found something.</c>", oPC);
        SendMessageToPC(oPC, "<cþ  >You found a Scroll!");
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
        //ResRef - NOT Tag
        CreateItemOnObject("mothsummondeamon", oPC, 1);
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
        }
        else
        {
        return;
        }
   }
if (nInt==17)
   {
        /*if (nDice<=1)
        {
        object oPC = GetEnteringObject();
        effect eSpell = EffectSpellFailure(100, SPELL_SCHOOL_GENERAL);
        effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
        effect eLink = EffectLinkEffects(eSpell, eGlow);
        string sPC = GetName(oPC);
        FloatingTextStringOnCreature("<cþ  >"+sPC+" appears to be blocked in some mannor.</c>", oPC);
        SendMessageToPC(oPC, "<cþ  >You feel the power of magic and all its surroundings sucked out of your entire being. You can no longer use magic or any of your sequencers!</c>");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, HoursToSeconds(50));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_EVIL_HELP), oPC);
        }
        else
        {
        return;
        } */
        return;
   }
else
   {
   }
if (nInt==18)
   {
      if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      DelayCommand(1.5,SendMessageToPC(oPC, "<cþ  >You feel exceptionally resilliant!</c>"));
      DelayCommand(1.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems extremely stalwart!</c>", oPC));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,20), oPC, HoursToSeconds(4)));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,20), oPC, HoursToSeconds(4)));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,20), oPC, HoursToSeconds(4)));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }
   }
if (nInt==19)
   {
      if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      DelayCommand(1.5,SendMessageToPC(oPC, "<cþ  >You feel exceptionally resilliant!</c>"));
      DelayCommand(1.5,FloatingTextStringOnCreature("<cþ  >"+sPC+" seems extremely stalwart!</c>", oPC));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,20), oPC, HoursToSeconds(4)));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,20), oPC, HoursToSeconds(4)));
      DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,20), oPC, HoursToSeconds(4)));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }
   }
if (nInt==20)
   {
      if (nDice<=1)
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      object oTrig;
      object oSpam;
      location lTrim;
      oTrig = oPC;
      lTrim = GetLocation(oTrig);
      oSpam = CreateObject(OBJECT_TYPE_PLACEABLE, "mothportalhome", lTrim);
      oTrig = oSpam;
      DelayCommand(0.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(481), GetLocation(oTrig)));
      DelayCommand(1.3,SendMessageToPC(oPC, "<cþ  >You found a portal, in the center you see the familiar tile of Hope Canyon.</c>"));
      DelayCommand(1.3,FloatingTextStringOnCreature("<cþ  >"+sPC+" somehow summons a portal!?</c>", oPC));
      DestroyObject(oSpam, 45.0);
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }
   }
if (nInt==21)
   {
      /*object oPC = GetEnteringObject();
      if ((GetHitDice(oPC) >= 25))
      {
      object oPC = GetEnteringObject();
      string sPC = GetName(oPC);
      object oTrigger;
      effect eHurt;
      effect eFoot;
      location lTrim;
      oTrigger = oPC;
      lTrim = GetLocation(oTrigger);
      eHurt = EffectDamage(d20(20), DAMAGE_TYPE_ACID);
      eFoot = EffectAbilityDecrease(ABILITY_STRENGTH,10);
      DelayCommand(0.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), GetLocation(oTrigger)));
      DelayCommand(0.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(125), GetLocation(oTrigger)));
      DelayCommand(0.3,SendMessageToPC(oPC, "<cþ  >Trap Triggered - a lose floorbrick breaks off and your foot sinks into a pool of boiling acid. Your foot is severly injured!</c>"));
      DelayCommand(0.3,FloatingTextStringOnCreature("<cþ  >"+sPC+" triggers a trap!</c>", oPC));
      DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eHurt, oPC));
      DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFoot, oPC));
      SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
      }
      else
      {
      return;
      }*/
      return;
   }
if (nInt==22)
   {
        if (nSearch >= 18)
        {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found some writings on the ground.</c>", oPC);
        SendMessageToPC(oPC, "<cþ  >The scribings beneath your feet tells a rather elaborate tale about High Priest Emos and how he came to be the leader of a trust - which later came to be known as The Conclave. From what you can gather he had to slaughter all of the villager from his home town, including his parents, to get huge amount of blood required for what is refered to as 'The Ritual'. The rest of the text and imagery is unreadable.</c>");
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
        }
        else
        {
        return;
        }
   }
if (nInt==62)
   {
        if (nLore >= 18)
        {
        object oPC = GetEnteringObject();
        string sPC = GetName(oPC);
        FloatingTextStringOnCreature("<cþ  >"+sPC+" seems to have found some writings on the ground.</c>", oPC);
        SendMessageToPC(oPC, "<cþ  >The text beneath your feet speak of the fiendish cult of the Mithril Keepers. From what you can dechiffer the Keepers came first at the end of The Conclaves long rule - a period here called 'The Dominion of Aeons'. Apperantly the Mithril Keepers are a inbreed group of highly devoted Half-Orc's that gain their awsome strength as a result of Conclave experiments with various artifacts and Dragon 'parts'. There is no futher referense to what artifacts or parts of the Dragon was used.</c>");
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,1.0));
        SetLocalInt(oPlayer, GetTag(OBJECT_SELF), TRUE);
        }
        else
        {
        return;
        }
   }
if (nInt>=26)
   {
   return;
   }
}



