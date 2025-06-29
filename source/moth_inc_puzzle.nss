#include "nw_i0_generic"
// * Call on rest scripts. Resets and removes all cards and decks to make sure noone is cheating.
void MothResetCards(object oOwner=OBJECT_SELF, string sDeck="mothdeck", string sCard="mothcard");
// * Flips oCard back and forth and changes the name to the correct suit and face.
void MothFlipACard(object oCard);
// * Flips a card that's face down.
void MothFlipAFaceDownCard(object oCard);
// * oUser displays her card hard to all around her.
void MothShowCardHand(object oUser);
// * Call on Mod load to generate pets that can be rescued.yay!
void MothCreatePetTraps();
// * Set the description to oMasters pet.
void MothSetPetDescriptionAndName(object oMaster);

void MothResetCards(object oOwner=OBJECT_SELF, string sDeck="mothdeck", string sCard="mothcard")
{
    object oItem;
    string sTag;
    object oDeck = GetItemPossessedBy(oOwner,sDeck);
    oItem = GetFirstItemInInventory (oOwner);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag(oItem);
        if (sTag == "mothcard")
        {
            DestroyObject (oItem);
        }
        oItem = GetNextItemInInventory (oOwner);
    }
   if(GetIsObjectValid(oDeck))
   {
    oItem = GetFirstItemInInventory (oOwner);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag(oItem);
        if (sTag == sDeck)
        {
            DestroyObject (oItem);
        }
        oItem = GetNextItemInInventory (oOwner);
    }
   }
}
//Flips oCard back and forth and changes the name to the correct suit and face.
void MothFlipACard(object oCard)
{
  string sFace = GetLocalString(oCard, "face");
  string sSuit = GetLocalString(oCard, "suit");
  string sFinalName = "A "+sFace+" of "+sSuit+"";
  if(GetName(oCard)==sFinalName)
   {
      SetName(oCard, "");
   }
   else
   {
    SetName(oCard,sFinalName);
   }
}
void MothFlipAFaceDownCard(object oCard)
{
  string sFace = GetLocalString(oCard, "face");
  string sSuit = GetLocalString(oCard, "suit");
  string sFinalName = "A "+sFace+" of "+sSuit+"";
  if(GetName(oCard)==sFinalName)
   {
   }
   else
   {
     SetName(oCard,sFinalName);
   }
}
void MothShowCardHand(object oUser)
{
  object oCard;
  string sHisHer;
  string sTag;
  string sFace;
  string sSuit;
  string sUser = GetName(oUser);
  if(GetGender(oUser)==GENDER_FEMALE)
  {
      sHisHer = "her";
  }
  else
  {
      sHisHer = "his";
  }
  FloatingTextStringOnCreature("<cðæŒ>"+sUser+" shows "+sHisHer+" hand.</c>", oUser, TRUE);
  oCard = GetFirstItemInInventory (oUser);
  while(GetIsObjectValid(oCard))
  {
      sTag = GetTag(oCard);
      sFace = GetLocalString(oCard, "face");
      sSuit = GetLocalString(oCard, "suit");
      if(sTag == "mothcard")
      {
       MothFlipAFaceDownCard(oCard);
       FloatingTextStringOnCreature("<cþ¥ >"+sUser+" shows you a " +
       GetLocalString(oCard, "face") + " of " +
       GetLocalString(oCard, "suit") + ".</c>", oUser, TRUE);
      }
    oCard = GetNextItemInInventory(oUser);
  }
}
//call on Mod load to generate pets that can be rescued.yay!
void MothCreatePetTraps()
{
   string sWayPoint;
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet1"; break;
          case 1: sWayPoint = "mothpet2"; break;
          case 2: sWayPoint = "mothpet3"; break;
          case 3: sWayPoint = "mothpet4"; break;
          case 4: sWayPoint = "mothpet5"; break;
          case 5: sWayPoint = "mothpet6"; break;
          case 6: sWayPoint = "mothpet7"; break;
          case 7: sWayPoint = "mothpet8"; break;
          case 8: sWayPoint = "mothpet9"; break;
          case 9: sWayPoint = "mothpet10"; break;
         }
   int nRandom = d100(2);
   float fRandom = IntToFloat(nRandom);
   object oWaypoint = GetWaypointByTag(sWayPoint);
   location lLocationBase = GetLocation(oWaypoint);
   location lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   object oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap1;
   switch (Random(2))
         {
          case 0:
          oTrap1 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap1;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet1"; break;
          case 1: sWayPoint = "mothpet2"; break;
          case 2: sWayPoint = "mothpet3"; break;
          case 3: sWayPoint = "mothpet4"; break;
          case 4: sWayPoint = "mothpet5"; break;
          case 5: sWayPoint = "mothpet6"; break;
          case 6: sWayPoint = "mothpet7"; break;
          case 7: sWayPoint = "mothpet8"; break;
          case 8: sWayPoint = "mothpet9"; break;
          case 9: sWayPoint = "mothpet10"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap2;
   switch (Random(2))
         {
          case 0:
          oTrap2 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap2;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet1"; break;
          case 1: sWayPoint = "mothpet2"; break;
          case 2: sWayPoint = "mothpet3"; break;
          case 3: sWayPoint = "mothpet4"; break;
          case 4: sWayPoint = "mothpet5"; break;
          case 5: sWayPoint = "mothpet6"; break;
          case 6: sWayPoint = "mothpet7"; break;
          case 7: sWayPoint = "mothpet8"; break;
          case 8: sWayPoint = "mothpet9"; break;
          case 9: sWayPoint = "mothpet10"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap3;
   switch (Random(2))
         {
          case 0:
          oTrap3 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap3;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet1"; break;
          case 1: sWayPoint = "mothpet2"; break;
          case 2: sWayPoint = "mothpet3"; break;
          case 3: sWayPoint = "mothpet4"; break;
          case 4: sWayPoint = "mothpet5"; break;
          case 5: sWayPoint = "mothpet6"; break;
          case 6: sWayPoint = "mothpet7"; break;
          case 7: sWayPoint = "mothpet8"; break;
          case 8: sWayPoint = "mothpet9"; break;
          case 9: sWayPoint = "mothpet10"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap4;
   switch (Random(2))
         {
          case 0:
          oTrap4 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap4;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet11"; break;
          case 1: sWayPoint = "mothpet12"; break;
          case 2: sWayPoint = "mothpet13"; break;
          case 3: sWayPoint = "mothpet14"; break;
          case 4: sWayPoint = "mothpet15"; break;
          case 5: sWayPoint = "mothpet16"; break;
          case 6: sWayPoint = "mothpet17"; break;
          case 7: sWayPoint = "mothpet18"; break;
          case 8: sWayPoint = "mothpet19"; break;
          case 9: sWayPoint = "mothpet20"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap5;
   switch (Random(2))
         {
          case 0:
          oTrap5 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap5;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet11"; break;
          case 1: sWayPoint = "mothpet12"; break;
          case 2: sWayPoint = "mothpet13"; break;
          case 3: sWayPoint = "mothpet14"; break;
          case 4: sWayPoint = "mothpet15"; break;
          case 5: sWayPoint = "mothpet16"; break;
          case 6: sWayPoint = "mothpet17"; break;
          case 7: sWayPoint = "mothpet18"; break;
          case 8: sWayPoint = "mothpet19"; break;
          case 9: sWayPoint = "mothpet20"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap6;
   switch (Random(2))
         {
          case 0:
          oTrap6 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap6;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet11"; break;
          case 1: sWayPoint = "mothpet12"; break;
          case 2: sWayPoint = "mothpet13"; break;
          case 3: sWayPoint = "mothpet14"; break;
          case 4: sWayPoint = "mothpet15"; break;
          case 5: sWayPoint = "mothpet16"; break;
          case 6: sWayPoint = "mothpet17"; break;
          case 7: sWayPoint = "mothpet18"; break;
          case 8: sWayPoint = "mothpet19"; break;
          case 9: sWayPoint = "mothpet20"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap7;
   switch (Random(2))
         {
          case 0:
          oTrap7 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap7;
          break;
         }
   }
   switch (Random(10))
         {
          case 0: sWayPoint = "mothpet11"; break;
          case 1: sWayPoint = "mothpet12"; break;
          case 2: sWayPoint = "mothpet13"; break;
          case 3: sWayPoint = "mothpet14"; break;
          case 4: sWayPoint = "mothpet15"; break;
          case 5: sWayPoint = "mothpet16"; break;
          case 6: sWayPoint = "mothpet17"; break;
          case 7: sWayPoint = "mothpet18"; break;
          case 8: sWayPoint = "mothpet19"; break;
          case 9: sWayPoint = "mothpet20"; break;
         }
   nRandom = d100(2);
   fRandom = IntToFloat(nRandom);
   oWaypoint = GetWaypointByTag(sWayPoint);
   lLocationBase = GetLocation(oWaypoint);
   lLocation = GenerateNewLocationFromLocation(lLocationBase,66.0+fRandom,60.0+fRandom,0.0);
   oBreak = GetNearestTrapToObject(oWaypoint,FALSE);
   if(GetTrapBaseType(oBreak) != TRAP_BASE_TYPE_MINOR_TANGLE ||
      !GetIsObjectValid(oBreak)
   )
   {
   object oTrap8;
   switch (Random(2))
         {
          case 0:
          oTrap8 = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_TANGLE,lLocation, 2.0f,"mothpettrap",STANDARD_FACTION_HOSTILE,"mothpettrapdisab","mothpettrapfire");
          break;
          case 1:
          oTrap8;
          break;
         }
   }
   return;
}
void MothSetPetDescriptionAndName(object oMaster)
{
    object oSummon = GetNearestObjectByTag("mothrppet",oMaster);
    string sPet = GetName(oSummon);
    string sMaster = GetName(oMaster);
    SetName(oSummon,""+sMaster+"'s "+sPet+"");
    SetDescription(oSummon,"This is a pet "+sPet+" belonging to "+sMaster+".",TRUE);
}
//void main(){}
