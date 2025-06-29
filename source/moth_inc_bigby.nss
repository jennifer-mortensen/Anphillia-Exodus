#include "x2_i0_spells"
#include "nw_i0_generic"
void MothDoFist(location lLocation)
{
    object oDummy1 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothspelldummy",lLocation,FALSE);
    object oDummy2 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothspelldummy",lLocation,FALSE);
    object oDummy3 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothspelldummy",lLocation,FALSE);
    object oDummy4 = CreateObject(OBJECT_TYPE_PLACEABLE,"mothspelldummy",lLocation,FALSE);
    location lFist1 = GenerateNewLocationFromLocation(lLocation,3.5,0.0,0.0);
    location lFist2 = GenerateNewLocationFromLocation(lLocation,3.5,90.0,0.0);
    location lFist3 = GenerateNewLocationFromLocation(lLocation,3.5,180.0,0.0);
    location lFist4 = GenerateNewLocationFromLocation(lLocation,3.5,270.0,0.0);
    AssignCommand(oDummy1,ActionCastFakeSpellAtLocation(746,lFist1));
    AssignCommand(oDummy2,ActionCastFakeSpellAtLocation(746,lFist2));
    AssignCommand(oDummy3,ActionCastFakeSpellAtLocation(746,lFist3));
    AssignCommand(oDummy4,ActionCastFakeSpellAtLocation(746,lFist4));
    DelayCommand(1.5,DestroyObject(oDummy1));
    DelayCommand(1.5,DestroyObject(oDummy2));
    DelayCommand(1.5,DestroyObject(oDummy3));
    DelayCommand(1.5,DestroyObject(oDummy4));
}
// * Removes any Bigbyeffects from oTarget
void MothRemoveBigby(object oTarget)
{
  DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_BIGBYS_CLENCHED_FIST));
  GZRemoveSpellEffects(SPELL_BIGBYS_CLENCHED_FIST, oTarget);
  DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_BIGBYS_CRUSHING_HAND));
  GZRemoveSpellEffects(SPELL_BIGBYS_CRUSHING_HAND, oTarget);
  DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_BIGBYS_FORCEFUL_HAND));
  GZRemoveSpellEffects(SPELL_BIGBYS_FORCEFUL_HAND, oTarget);
  DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_BIGBYS_GRASPING_HAND));
  GZRemoveSpellEffects(SPELL_BIGBYS_GRASPING_HAND, oTarget);
  DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_BIGBYS_INTERPOSING_HAND));
  GZRemoveSpellEffects(SPELL_BIGBYS_INTERPOSING_HAND, oTarget);
}

//void main() {}
