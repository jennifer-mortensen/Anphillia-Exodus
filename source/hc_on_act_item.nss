//////Hardcore DMTool Composite
//Archaegeo 2002 June 24

//(Individual credits in other scripts)mothrodofages

// ** This script goes in the OnItemActivation event of your Module
// ** Properties.  It checks to see if the item used is a DM Helper
// ** And if so, and the user isnt a DM, destroys it, otherwise it
// ** Starts the DM Helper working.  "jth_dmwand" contains the actual
// ** code that controls the Helpers effects.  If you update anything
// ** in it, you must recompile the calling dmw_<name> script to make
// ** the change take effect.
// 27 June - Modified to support player raise deads.
// Include files, first is for the DM Helper, second for Recall stones if you
// use them, and third is the hc_inc file for all hc constants

// Modified 7/9/2002 by Brandon Mathis
// Added if cleric is 17th level or higher, and the player has enough
// gold, the cleric will cast true ressurection.
// Changed: Raise dead now cost 50*Cleric Level + 500 per PhB.
// Ressurection cost 70*cleric level + 500 per phb.
// True Ressurection cost 90*Cleric Level + 5000 per PhB.

// Modified 8/17/2002 by Edward Beck (0100010)
// Added support for food,drink, and water canteen items for use with HTF system.

#include "hc_inc"
#include "anph_inc"
#include "hc_inc_on_act"
#include "hc_text_activate"
#include "_inc_gen"

object oOther;

void main()
{
    ExecuteScript(GetTag(GetItemActivated()), OBJECT_SELF);
    if (GetLocalInt(oMod, "ANPH_CNR_ACTIVE") == TRUE) ExecuteScript ("cnr_module_onact", OBJECT_SELF);
    if(!preEvent()) return;
    object oItem=GetItemActivated();
    object oUser=GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    oOther=GetItemActivatedTarget();
    string sItemTag=GetTag(oItem);
    string sItemResref=GetResRef(oItem);
    string sItemTagSet=GetStringLeft(sItemTag,8);
    if(sItemTag == "axfellrelic" || sItemTag == "cleavenrelic")
    {
        HandleRelicLoss(oUser);
        return;
    }
    if(sItemTag=="TrackerTool" &&
       GetLevelByClass(CLASS_TYPE_RANGER, oUser) > 0)
    {
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 6.0));
        DelayCommand(0.2, SetCommandable(FALSE, oUser));
        DelayCommand(5.8, SetCommandable(TRUE, oUser));
        DelayCommand(6.0, ExecuteScript("hc_track_start", oUser));
        postEvent();
        return;
    }
    else if(sItemTag=="hc_paladinsymb" &&
       GetLevelByClass(CLASS_TYPE_PALADIN,oUser)>0)
    {
        ExecuteScript("hc_pal_detevil",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothtrackertool")
    {
        ExecuteScript("moth_trackertool",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothdruidsear")
    {
        ExecuteScript("moth_druidsear",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothdeck")
    {
        ExecuteScript("moth_deck",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothbriarspikes")
    {
        ExecuteScript("mothbriarspike",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothpetbase")
    {
        string sPetname = GetName(oItem);
        SetLocalString(oUser,"MOTHPETNAME",sPetname);
        ExecuteScript("mothpet",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothhalforcitem")
    {
        ExecuteScript("mothignorepain",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothcard")
    {
        ExecuteScript("moth_card",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothremoveplot")
    {
        ExecuteScript("mothremoveplot",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="Prisonifier")
    {
        ExecuteScript("priswandactivate",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="grandmasterarmo2")
    {
        ExecuteScript("grandmasterarm2",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothrodofages")
    {
        ExecuteScript("mothrodofage",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothsummondog")
    {
        ExecuteScript("mothsummondoggie",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="AxfellCamp")
    {
        ExecuteScript("axfellcamp",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="CleavenCamp")
    {
        ExecuteScript("cleavencamp",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothsummonbalrog")
    {
        ExecuteScript("mothsummonbal",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothsummondeamon")
    {
        ExecuteScript("mothsummondeam",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothsummonbanshe")
    {
        ExecuteScript("mothsummonban",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="mothtelebugbear")
    {
        ExecuteScript("mothtelebugb",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="RemedialHerb")
    {
        ExecuteScript("remedialherb",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="thorialssong")
    {
        ExecuteScript("thorials",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothlyric3")
    {
        ExecuteScript("mothlyr3",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothlyric4")
    {
        ExecuteScript("mothlyric41",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothlyric5")
    {
        ExecuteScript("mothlyric51",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothlyric6")
    {
        ExecuteScript("mothlyric61",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothsditem")
    {
        ExecuteScript("mothsditem1",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="groveportal")
    {
        ExecuteScript("groveportal1",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothprize1")
    {
        ExecuteScript("mothprize11",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothlyresum")
    {
        ExecuteScript("mothlyresum1",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothprize4")
    {
        ExecuteScript("mothprize41",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothaslan1")
    {
        ExecuteScript("mothaslan12",oUser);
        postEvent();
        return;
    }
    else if(sItemTagSet=="MothGlow")
    {
        ExecuteScript("mothglows",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="mothnamebag")
    {
        ExecuteScript("mothnamebag1",oUser);
        postEvent();
        return;
    }
    else if(sItemResref=="it_mmidmisc006")
    {
        string sCampfireTag = GetTag(oTarget);
        string sName = GetName(oUser);
        if(sCampfireTag == "hc_campfire"||
           sCampfireTag == "CAMP_FIRE_CLEAVEN"||
           sCampfireTag == "CAMP_FIRE_AXFELL")
        {
        DestroyObject(oItem);
        CreateItemOnObject("preparedfood",oUser);
        CreateItemOnObject("preparedfood",oUser);
        CreateItemOnObject("preparedfood",oUser);
        FloatingTextStringOnCreature("<cðøþ>*"+sName+" prepares some food on the fire.*</c>",oUser);
        postEvent();
        return;
        }
        else
        {
        FloatingTextStringOnCreature("<cðøþ>*Target needs to be a campfire!*</c>",oUser);
        return;
        }
    }
    else if (sItemTag == "hc_palbadgecour")
    {
        if(GetLevelByClass(CLASS_TYPE_PALADIN, oUser) < 2)
        {
            SendMessageToPC(oUser,NOINSPIRE);
            postEvent();
            return;
        }
        location lHere = GetItemActivatedTargetLocation();
        oOther=GetFirstObjectInShape(SHAPE_SPHERE,3.0,GetLocation(oUser),FALSE,OBJECT_TYPE_CREATURE);
        effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oUser);
        while ( GetIsObjectValid(oOther) )
        {
            if ( (GetIsFriend(oOther,oUser)) && (oOther != oUser ) )
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_WILL,4,SAVING_THROW_TYPE_FEAR),oOther,d6(2)*6.0);
                if ( GetIsPC(oOther) )
                    SendMessageToPC(oOther,IMBUECOURAGE);
            }
            oOther=GetNextObjectInShape(SHAPE_SPHERE,3.0,GetLocation(oUser),FALSE,OBJECT_TYPE_CREATURE);
        }
    }
// Thieves' Tools
    else if ((sItemTag == "thievesTools") || (sItemTag == "thievesToolsMaster"))
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        SetLocalString(oUser,"TAG",sItemTag);
        ExecuteScript("hc_act_thieftool",oUser);
        postEvent();
        return;
    }
    else if ( sItemTag == "BookOfSummons" )
    {
        AssignCommand(oUser, ActionStartConversation(oUser, "hc_c_bookofsummo", TRUE));
    }
    // Active trap searching, gets rid of auto Take 20 problem.
    else if (sItemTag == "searchtool")
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_search",oUser);
        postEvent();
        return;
    }
   //Begin Healer's Kit = With thanks to Andalus for taking the time to make.
    else if(sItemTag=="hc_healkit")
    {
        if(GetIsPC(oOther) == FALSE)
        {
            postEvent();
            return;
        }
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_healkit",oUser);
        postEvent();
        return;
    }
    //End Healer's Kit


    else if(sItemTag=="hc_skinning")
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_skinning",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="ScalpHuntersKnife")
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("eye_act_scalp",oUser);
        postEvent();
        return;
    }
    else if(sItemTag=="hc_acidflask" ||
       sItemTag=="hc_alchfire" ||
       sItemTag=="hc_holywater" ||
       sItemTag=="hc_tangle" ||
       sItemTag=="hc_thunder")
    {
        SetLocalObject(oUser,"GRENADE",oItem);
        SetLocalObject(oUser,"GRENADETARGET",oOther);
        ExecuteScript("hc_grenade", oUser);
    }
    else if(sItemTag=="hc_oilflask")
    {
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        ExecuteScript("hc_act_oilflask",oUser);
        postEvent();
        return;
    }
    else if(FindSubString(sItemTag,"PotionOf")!= -1)
    {
        object oTarget=GetItemActivatedTarget();
        SetLocalObject(oUser,"OTHER",oOther);
        SetLocalObject(oUser,"ITEM",oItem);
        SetLocalString(oUser,"TAG",sItemTag);
        ExecuteScript("hc_act_potion",oUser);
        postEvent();
        return;
    }
// If the item is the DM Helper, activate it after checking to make sure a
// PC hasnt got their hands on it.
   object oActivator=oUser;
   string sHTarget="";
   string sHLoc;
   string sHConv;

   if(sItemTag=="HCRHelper" || sItemTag=="HCRHelpwand")
   {
      sHTarget="HCRHtarget";
      sHLoc="HCRHloc";
      sHConv="hcrhconv";
   }
   if(GetTag(oItem)=="DMsHelper")
   {
      sHTarget="dmwandtarget";
      sHLoc="dmwandloc";
      sHConv="dmwand";
   }
   if(GetTag(oItem)=="WandOfFX")
   {
      sHTarget="FXWandTarget";
      sHLoc="FXWandLoc";
      sHConv="fxwand";
   }
   if(sHTarget!="")
   {
       // get the wand's activator and target, put target info into local vars on activator
      object oDM = GetItemActivator();
      object oMyTarget = GetItemActivatedTarget();
      SetLocalObject(oDM, sHTarget, oMyTarget);
      location lTargetLoc = GetItemActivatedTargetLocation();
      SetLocalLocation(oDM, sHLoc, lTargetLoc);

      object oTest=GetFirstPC();
      string sTestName = GetPCPlayerName(oDM);
      // Test to make sure the activator is a DM, or is a DM
      // controlling a creature.

      while (GetIsObjectValid(oTest) == TRUE)
       {
        if (GetPCPlayerName(oTest) == sTestName && GetIsDM(oTest) == FALSE &&
            GetPCPublicCDKey(oTest)!=GetPersistentString(oMod,"PLAYERDM"))
            {
            DestroyObject(oItem);
            SendMessageToPC(oActivator,NOMORTAL);
            postEvent();
            return;
            }
            oTest=GetNextPC();
       }

      //Make the activator start a conversation with itself
      AssignCommand(oDM, ActionStartConversation(oDM, sHConv, TRUE));
      postEvent();
      return;
   }
   if(GetTag(oItem)=="EmoteWand")
   {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "emotewand", TRUE));
        postEvent();
        return;
   }

   if(GetTag(oItem)=="XPWand")
   {
        object oDM = GetItemActivator();
        object oMyTarget = GetItemActivatedTarget();
        SetLocalObject (oDM, "xpwand_target", oMyTarget);
        AssignCommand (oDM, ActionStartConversation (oDM, "xpwand_conv", TRUE));
        postEvent();
        return;
   }
  if (GetTag(GetItemActivated()) == "WandOfItem")
  {
     object oDM = GetItemActivator();
     object oItem = GetItemActivatedTarget();
     SendMessageToPC(oDM, "** Name: " + GetName(oItem) + ", Tag: " + GetTag(oItem) + ", ResRef: " + GetResRef(oItem));
     return;
  }
  if(GetTag(oItem)=="WandOfSubscribe")
  {
     if (GetIsDM(oUser))
        AssignCommand (oUser, ActionStartConversation (oUser, "eye_subscribe", TRUE));
     return;
  }

    if(GetLocalInt(oItem, "DESTROY_ON_USE") == 1) //J. Persinne; destroy certain items on use.
    {
        DestroyObject(oItem);
        return;
    }

  if(sItemTag=="PlayerCorpse")
  {
    object oCleric=GetItemActivatedTarget();
    SetLocalObject(oUser,"CLERIC",oCleric);
    SetLocalObject(oUser,"ITEM",oItem);
    ExecuteScript("hc_act_pct",oUser);
  }
  SetLocalObject(oUser,"OTHER",oOther);
  SetLocalObject(oUser,"ITEM",oItem);
  SetLocalString(oUser,"TAG",sItemTag);
  ExecuteScript("hc_act_others",oUser);
  postEvent();
}
