#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomPole()
{
//Scythe
ATS_Recipe_NewRecipe("Scythe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 36);
ATS_Recipe_SetMinSkill(75);
ATS_Recipe_SetMaxSkill(110);
ATS_Recipe_Ingots(16);
//Grim Reaper
ATS_Recipe_NewRecipe("The Grim Reaper", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 39);
ATS_Recipe_SetSingleType("ATS_C_W339_N_BLA");
ATS_Recipe_SetMinSkill(385);
ATS_Recipe_SetMaxSkill(435);
ATS_Recipe_AddMaterial("ATS_C_W336_E_BLA",1,5); //Exceptional Blacksteel Scythe
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13",3,90); //Skeletons Knuckles
//Halberd
ATS_Recipe_NewRecipe("Halberd", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 30);
ATS_Recipe_SetMinSkill(80);
ATS_Recipe_SetMaxSkill(115);
ATS_Recipe_Ingots(18);
//Spear
ATS_Recipe_NewRecipe("Spear", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 31);
ATS_Recipe_SetMinSkill(70);
ATS_Recipe_SetMaxSkill(105);
ATS_Recipe_Ingots(12);
//Thunder (Halberd)
ATS_Recipe_NewRecipe("Thunder", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 38);
ATS_Recipe_SetSingleType("ATS_C_W338_E_GOL");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W330_E_GOL",1,5);  //Exceptional Gold Halberd
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",3,90); //Blue Dragons blood
//Venom
ATS_Recipe_NewRecipe("Venom", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_POLEARMS, 37);
ATS_Recipe_SetSingleType("ATS_C_W337_N_VER");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W331_E_VER",1,5);  //Exceptional Verdicite Spear
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BAL",3,90); //Balors blood
}
//void main(){}
