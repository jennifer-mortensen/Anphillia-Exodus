#include "x2_i0_spells"
#include "x2_inc_itemprop"
#include "x2_inc_shifter"
#include "x3_inc_horse"
#include "_inc_const"

void ApplyDrowBoltProperties(object oPC)
{
    int nAppearance = GetAppearanceType(oPC);
    if(nAppearance == 216 || nAppearance == 215 || nAppearance == 480 || nAppearance == 479) //Double check to ensure that the PC is in drow shape, just in case...
    {
        object oBolts = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING, IP_CONST_DAMAGEBONUS_5), oBolts);
    }
}

void main()
{
    if(GetLocalInt(OBJECT_SELF,"HasMountExp")== TRUE)
    {
        SendMessageToPC(OBJECT_SELF,"<c¥¥¥>[Server] You cannot use this spell while Mounted.</c>");
        return ;
    }
    if(HorseGetIsMounted(OBJECT_SELF)== TRUE)
    {
        SendMessageToPC(OBJECT_SELF,"<c¥¥¥>[Server] You cannot use this spell while Mounted.</c>");
        return ;
    }
    int nRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,OBJECT_SELF);
    if(nRDD>=1)
    {
    SetLocalInt(OBJECT_SELF,"MothRDDlvls",nRDD);
    ExecuteScript("mothrddshape",OBJECT_SELF);
    return;
    }
    int    nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    int    nShifter = GetLevelByClass(CLASS_TYPE_SHIFTER);
    effect ePoly;
    int    nPoly;
    switch(nSpell)
    {
        // Greater Wildshape I
        case 646: nSpell = Random(5)+658; break;
        // Greater Wildshape II
        case 675: switch(Random(3))
                  {
                    case 0: nSpell = 672; break;
                    case 1: nSpell = 678; break;
                    case 2: nSpell = 680;
                  }
                  break;
        // Greater Wildshape III
        case 676: switch(Random(3))
                  {
                    case 0: nSpell = 670; break;
                    case 1: nSpell = 673; break;
                    case 2: nSpell = 674;
                  }
                  break;
        // Greater Wildshape IV
        case 677: switch(Random(3))
                  {
                    case 0: nSpell = 679; break;
                    case 1: nSpell = 691; break;
                    case 2: nSpell = 694;
                  }
                  break;
        // Humanoid Shape
        case 681:  nSpell = Random(3)+682; break;
        // Undead Shape
        case 685:  nSpell = Random(3)+704; break;
        // Dragon Shape
        case 725:  nSpell = Random(3)+707; break;
        // Outsider Shape
        case 732:  nSpell = Random(3)+733; break;
        // Construct Shape
        case 737:  nSpell = Random(3)+738; break;
    }
    switch (nSpell)
    {

        //-----------------------------------------------------------------------
        // Greater Wildshape I - Wyrmling Shape
        //----------------------------------------------------------------------- J. Persinne; Wyrmlings now have a pseudo-epic shape at shifter 11 that projects elemental bolts.
        case 658:  if(nShifter >= 11) nPoly = ANPH_POLYMORPH_TYPE_WYRMLING_RED_EPIC; else nPoly = POLYMORPH_TYPE_WYRMLING_RED; break;
        case 659:  if(nShifter >= 11) nPoly = ANPH_POLYMORPH_TYPE_WYRMLING_BLUE_EPIC; else nPoly = POLYMORPH_TYPE_WYRMLING_BLUE; break;
        case 660:  if(nShifter >= 11) nPoly = ANPH_POLYMORPH_TYPE_WYRMLING_BLACK_EPIC; else nPoly = POLYMORPH_TYPE_WYRMLING_BLACK; break;
        case 661:  if(nShifter >= 11) nPoly = ANPH_POLYMORPH_TYPE_WYRMLING_WHITE_EPIC; else nPoly = POLYMORPH_TYPE_WYRMLING_WHITE; break;
        case 662:  if(nShifter >= 11) nPoly = ANPH_POLYMORPH_TYPE_WYRMLING_GREEN_EPIC; else nPoly = POLYMORPH_TYPE_WYRMLING_GREEN; break;

        //-----------------------------------------------------------------------
        // Greater Wildshape II  - Minotaur, Gargoyle, Harpy
        //-----------------------------------------------------------------------
        case 672: if (nShifter < X2_GW2_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_HARPY;
                  else
                     nPoly = 97;
                  break;

        case 678: if (nShifter < X2_GW2_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_GARGOYLE;
                  else
                     nPoly = 98;
                  break;

        case 680: if (nShifter < X2_GW2_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_MINOTAUR;
                  else
                     nPoly = 96;
                  break;

        //-----------------------------------------------------------------------
        // Greater Wildshape III  - Drider, Basilisk, Manticore
        //-----------------------------------------------------------------------
        case 670: if (nShifter < 13)
                  {
                     nPoly = POLYMORPH_TYPE_BASILISK;
                  }
                  else
                  {
                     nPoly = 99;
                  }
                  break;

        case 673: if (nShifter < 13)
                  {
                     if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
                     {
                     nPoly = 121;
                     }
                     else
                     {
                     nPoly = 62;
                     }
                  }
                  else
                  {
                     if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
                     {
                     nPoly = 122;
                     }
                     else
                     {
                     nPoly = 100;
                     }
                  }
                  ExecuteScript("x2_s3_darkfire",OBJECT_SELF);
                  break;

        case 674: if (nShifter < 13)
                     nPoly = POLYMORPH_TYPE_MANTICORE;
                  else
                     nPoly = 101;
                  break;

       //-----------------------------------------------------------------------
       // Greater Wildshape IV - Dire Tiger, Medusa, MindFlayer
       //-----------------------------------------------------------------------
        //medusa
        case 679: if (nShifter < X2_GW3_EPIC_THRESHOLD)
                     nPoly = POLYMORPH_TYPE_MEDUSA;
                  else
                     nPoly = 107;
                  break;
        //mind flayer
        case 691: if (nShifter < X2_GW3_EPIC_THRESHOLD)
                     nPoly = 68;
                  else
                     nPoly = 108;
                  break;
        //dire tiger
        case 694: if (nShifter < X2_GW3_EPIC_THRESHOLD)
                     nPoly = 69;
                  else
                     nPoly = 109;
                  break;
       //-----------------------------------------------------------------------
       // Humanoid Shape - Kobold Commando, Drow, Lizard Crossbow Specialist
       //-----------------------------------------------------------------------
       case 682:
                 if(nShifter< 17)
                 {
                     if (GetGender(OBJECT_SELF) == GENDER_MALE) //drow
                         nPoly = 59;
                     else
                         nPoly = 70;
                 }
                 else
                 {
                     if (GetGender(OBJECT_SELF) == GENDER_MALE) //drow
                         nPoly = 105;
                     else
                         nPoly = 106;
                 }
                 ExecuteScript("x2_s3_darkfire",OBJECT_SELF);
                 break;
       case 683:
                 if(nShifter< 17)
                 {
                    if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
                    {
                    nPoly = 123;
                    }
                    else
                    {
                    nPoly = 82;
                    }
                    break; // Lizard
                 }
                 else
                 {
                    if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
                    {
                    nPoly = 124;
                    }
                    else
                    {
                    nPoly =104;
                    }
                    break; // Epic Lizard
                 }
       case 684: if(nShifter< 17)
                 {

                    if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
                    {
                    nPoly = 125;
                    }
                    else
                    {
                    nPoly = 83;
                    }
                    break; // Kobold Commando
                 }
                 else
                 {
                    if (GetGender(OBJECT_SELF) == GENDER_FEMALE)
                    {
                    nPoly = 126;
                    }
                    else
                    {
                    nPoly = 103;
                    }
                    break; // Epic Kobold Commando
                 }

       //-----------------------------------------------------------------------
       // Undead Shape - Spectre, Risen Lord, Vampire
       //-----------------------------------------------------------------------
       case 704: nPoly = 75; break; // Risen lord

       case 705: if (GetGender(OBJECT_SELF) == GENDER_MALE) // vampire
                     nPoly = 74;
                  else
                     nPoly = 77;
                 break;

       case 706: nPoly = 76; break; /// spectre

       //-----------------------------------------------------------------------
       // Dragon Shape - Red Blue and Green Dragons
       //-----------------------------------------------------------------------
       case 707: nPoly = 72; break; // Ancient Red   Dragon
       case 708: nPoly = 71; break; // Ancient Blue  Dragon
       case 709: nPoly = 73; break; // Ancient Green Dragon


       //-----------------------------------------------------------------------
       // Outsider Shape - Rakshasa, Azer Chieftain, Black Slaad
       //-----------------------------------------------------------------------
       case 733:   if (GetGender(OBJECT_SELF) == GENDER_MALE) //azer
                      nPoly = 85;
                    else // anything else is female
                      nPoly = 86;
                    break;

       case 734:   if (GetGender(OBJECT_SELF) == GENDER_MALE) //rakshasa
                      nPoly = 88;
                    else // anything else is female
                      nPoly = 89;
                    break;

       case 735: nPoly =87; break; // slaad

       //-----------------------------------------------------------------------
       // Construct Shape - Stone Golem, Iron Golem, Demonflesh Golem
       //-----------------------------------------------------------------------
       case 738: nPoly =91; break; // stone golem
       case 739: nPoly =92; break; // demonflesh golem
       case 740: nPoly =90; break; // iron golem

    }
    int bWeapon = ShifterMergeWeapon(nPoly);
    int bArmor  = ShifterMergeArmor(nPoly);
    int bItems  = ShifterMergeItems(nPoly);
    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld  = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old  = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old  = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld   = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    object oGloveOld  = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    object oHideOld  = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }
    ePoly = EffectPolymorph(nPoly);
    ePoly = ExtraordinaryEffect(ePoly);
    ClearAllActions();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    SetIdentified(oWeaponNew, TRUE);
    //Moth: Always merge hide to get PC Tool Feats
    IPWildShapeCopyItemProperties(oHideOld,oArmorNew);
    if (bWeapon)
    {
         IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    }
    if (bArmor)
    {
        IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
        IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
        IPWildShapeCopyItemProperties(oShield,oArmorNew);
    }
    if (bItems)
    {
        IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
        IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
        IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
        IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
        IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);
        IPWildShapeCopyItemProperties(oGloveOld,oArmorNew);
    }
    ShifterSetGWildshapeSpellLimits(nSpell);

    //J. Persinne; Drow Shape receives +4 slashing damage and poison on its bolts.
    if(nPoly == 59 || nPoly == 70 || nPoly == 105 || nPoly == 106)
    {
        DelayCommand(0.1, ApplyDrowBoltProperties(OBJECT_SELF));
    }

    //J. Persinne; give Rakshasa feedback about their true seeing ability the first time they shift each reboot.
    if((nPoly == 88 || nPoly == 89) && GetLocalInt(OBJECT_SELF, "RAK_FEEDBACK_DISPLAYED") == FALSE)
    {
        SendMessageToPC(OBJECT_SELF, "<cþŒ >Rakshasa's True Seeing Enabled; target yourself with Dispel Magic to temporarily apply True Seeing to yourself.");
        SetLocalInt(OBJECT_SELF, "RAK_FEEDBACK_DISPLAYED", TRUE);
    }
}








