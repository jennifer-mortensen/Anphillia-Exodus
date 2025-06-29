#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomBow()
{
//Gold Arrow Heads
ATS_Recipe_NewRecipe("Gold Arrow Heads", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW , 21);
ATS_Recipe_SetSingleType("ATS_C_W921_N_GOL");
ATS_Recipe_SetMinSkill(200);
ATS_Recipe_SetMaxSkill(205);
ATS_Recipe_Ingots(5);
//Verdicite Arrow Heads
ATS_Recipe_NewRecipe("Verdicite Arrow Heads", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW , 22);
ATS_Recipe_SetSingleType("ATS_C_W922_N_VER");
ATS_Recipe_SetMinSkill(205);
ATS_Recipe_SetMaxSkill(210);
ATS_Recipe_Ingots(5);
//Rubicite Arrow Heads
ATS_Recipe_NewRecipe("Rubicite Arrow Heads", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW , 23);
ATS_Recipe_SetSingleType("ATS_C_W923_N_RUB");
ATS_Recipe_SetMinSkill(205);
ATS_Recipe_SetMaxSkill(210);
ATS_Recipe_Ingots(5);
//Syenite Arrow Heads
ATS_Recipe_NewRecipe("Syenite Arrow Heads", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW , 24);
ATS_Recipe_SetSingleType("ATS_C_W924_N_SYE");
ATS_Recipe_SetMinSkill(205);
ATS_Recipe_SetMaxSkill(210);
ATS_Recipe_Ingots(5);
//Silver Arrow Heads
ATS_Recipe_NewRecipe("Silver Arrow Heads", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW , 25);
ATS_Recipe_SetSingleType("ATS_C_W925_N_SIL");
ATS_Recipe_SetMinSkill(200);
ATS_Recipe_SetMaxSkill(205);
ATS_Recipe_Ingots(5);
//Shadow Arrow Heads
ATS_Recipe_NewRecipe("Shadow Arrow Heads", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_LONGBOW , 27);
ATS_Recipe_SetSingleType("ATS_C_W927_N_BLA");
ATS_Recipe_SetMinSkill(210);
ATS_Recipe_SetMaxSkill(215);
ATS_Recipe_Ingots(5);
// Smooth Oak Silk Shortbow
ATS_Recipe_NewRecipe("Smooth Oak Silk Shortbow", ATS_CRAFT_TYPE_BOWYERING, ATS_CRAFT_PART_SHORTBOW, 04);
ATS_Recipe_SetSingleType("ATS_C_C004_N_OAK");  // Smooth Oak Hemp Bow
ATS_Recipe_SetMinSkill(35);
ATS_Recipe_SetMaxSkill(55);
ATS_Recipe_AddMaterial("ATS_R_COAK_N_STA", 1, 100);   // Short Oak Stave
ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife
// Smooth Elm Silk Shortbow
ATS_Recipe_AddAlternateRecipe("Smooth Elm Silk Shortbow", TRUE);
ATS_Recipe_SetSingleType("ATS_C_C004_N_ELM");  // Smooth Elm Hemp Bow
ATS_Recipe_SetMinSkill(75);
ATS_Recipe_SetMaxSkill(95);
ATS_Recipe_AddMaterial("ATS_R_CELM_N_STA", 1, 100);   // Short Elm Stave
ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife
// Smooth Ash Silk Shortbow
ATS_Recipe_AddAlternateRecipe("Smooth Ash Silk Shortbow", TRUE);
ATS_Recipe_SetSingleType("ATS_C_C004_N_ASH");  // Smooth Ash Hemp Bow
ATS_Recipe_SetMinSkill(115);
ATS_Recipe_SetMaxSkill(135);
ATS_Recipe_AddMaterial("ATS_R_CASH_N_STA", 1, 100);   // Short Ash Stave
ATS_Recipe_AddMaterial("ATS_R_CSLK_N_STR", 1, 100);   // Hemp String
ATS_Recipe_AddMaterial("ATS_S_C102_N_COP_DUR10", 1, 50);   // Smoothing Knife
//Long Iron Maple Staves
ATS_Recipe_NewRecipe("Long Iron Maple Staves", ATS_CRAFT_TYPE_FLETCHING, ATS_CRAFT_PART_ARROW, 31);
ATS_Recipe_SetSingleType("ATS_C_F031_N_ARR");
ATS_Recipe_SetMinSkill(85);
ATS_Recipe_SetMaxSkill(100);
ATS_Recipe_AddMaterial("IronMapleWood",1,75); //Iron Maple Wood
ATS_Recipe_AddMaterial("ATS_R_FBFL_N_ARR",1,100); //Basic Fletch
}
//void main(){}
