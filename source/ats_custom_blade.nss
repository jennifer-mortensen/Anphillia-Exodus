#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomBlade()
{
//Greatsword
ATS_Recipe_NewRecipe("Greatsword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 75);
ATS_Recipe_SetMinSkill(90);
ATS_Recipe_SetMaxSkill(125);
ATS_Recipe_Ingots(15);
//Short Sword
ATS_Recipe_NewRecipe("Short Sword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 60);
ATS_Recipe_SetMinSkill(40);
ATS_Recipe_SetMaxSkill(70);
ATS_Recipe_Ingots(6);
//bastard sword
ATS_Recipe_NewRecipe("Bastard sword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 31);
ATS_Recipe_SetMinSkill(60);
ATS_Recipe_SetMaxSkill(95);
ATS_Recipe_Ingots(10);
//Katana
ATS_Recipe_NewRecipe("Katana", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 32);
ATS_Recipe_SetMinSkill(65);
ATS_Recipe_SetMaxSkill(100);
ATS_Recipe_Ingots(10);
//Rapier
ATS_Recipe_NewRecipe("Rapier", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 33);
ATS_Recipe_SetMinSkill(48);
ATS_Recipe_SetMaxSkill(83);
ATS_Recipe_Ingots(6);
//Scimitar
ATS_Recipe_NewRecipe("Scimitar", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 35);
ATS_Recipe_SetMinSkill(50);
ATS_Recipe_SetMaxSkill(85);
ATS_Recipe_Ingots(8);
//Black Legion (Lond Sword)
ATS_Recipe_NewRecipe("Black Legion", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 30);
ATS_Recipe_SetSingleType("ATS_C_W130_E_BLA");
ATS_Recipe_SetMinSkill(395);
ATS_Recipe_SetMaxSkill(445);
ATS_Recipe_AddMaterial("ATS_C_W103_E_BLA",1,5);  //Exceptional Black Steel Longsword
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,90); //Slaad's Tongue
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BAL",1,90); //Balors blood
/*//Grand Master Longsword (Longsword +5)
ATS_Recipe_NewRecipe("Grand Master Longsword", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_BLADES, 46);
ATS_Recipe_SetSingleType("ATS_C_W146_N_ADA");
ATS_Recipe_SetMinSkill(460);
ATS_Recipe_SetMaxSkill(485);
ATS_Recipe_AddMaterial("ATS_C_B001_N_MIT", 10, 50);  //Mithril Ingots
ATS_Recipe_AddMaterial("ATS_C_B001_N_ADA", 10, 50);  //Adamantine Ingots
ATS_Recipe_AddMaterial("ATS_C_G001_E_DIA", 2, 90); //Ideal Cut Diamond
ATS_Recipe_AddMaterial("ATS_C_G001_E_PRL", 1, 90); //Ideal Cut Pearl    */
}
//void main(){}
