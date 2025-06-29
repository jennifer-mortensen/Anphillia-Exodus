#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomArmor()
{
//Deaths Embrace (Shadow Full plate)
ATS_Recipe_NewRecipe("Deaths Embrace", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 36);
ATS_Recipe_SetSingleType("ATS_C_A036_E_BLA");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_A008_E_BLA",1,5);  //Excep. Shadow Fullplate
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13",5,80); //Skeletons Knuckles
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC10",2,80); //Slaad's Tongue
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BAL",1,80); //Balors blood
//Flesh Rot (Verdicite halfplate)
ATS_Recipe_NewRecipe("Flesh Rot", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 32);
ATS_Recipe_SetSingleType("ATS_C_A032_E_VER");
ATS_Recipe_SetMinSkill(370);
ATS_Recipe_SetMaxSkill(420);
ATS_Recipe_AddMaterial("ATS_C_A007_E_VER",1,5);  //Excep. Ver. Halfplate
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BAL",3,80); //Balors blood
//Frozen Flesh (Syenite halfplate)
ATS_Recipe_NewRecipe("Frozen Flesh", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 33);
ATS_Recipe_SetSingleType("ATS_C_A033_E_SYE");
ATS_Recipe_SetMinSkill(370);
ATS_Recipe_SetMaxSkill(420);
ATS_Recipe_AddMaterial("ATS_C_A007_E_SYE",1,5);  //Excep. Ver. Halfplate
ATS_Recipe_AddMaterial("ATS_R_MISC_N_ZNT",3,80); //Frozen Heart
//Flame Flesh (Rubicite halfplate)
ATS_Recipe_NewRecipe("Flame Flesh", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 34);
ATS_Recipe_SetSingleType("ATS_C_A034_E_RUB");
ATS_Recipe_SetMinSkill(370);
ATS_Recipe_SetMaxSkill(420);
ATS_Recipe_AddMaterial("ATS_C_A007_E_RUB",1,5);  //Excep. Ver. Halfplate
ATS_Recipe_AddMaterial("ATS_R_MISC_N_RBD",3,80); //Red Dragons blood
//Elven Protection (Mithril Chain)
ATS_Recipe_NewRecipe("Elven Protection", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 31);
ATS_Recipe_SetSingleType("ATS_C_A031_E_MIT");
ATS_Recipe_SetMinSkill(395);
ATS_Recipe_SetMaxSkill(445);
ATS_Recipe_AddMaterial("ATS_C_A001_E_MIT",1,5);  //Excep. Mit. Chain
ATS_Recipe_AddMaterial("ATS_R_MISC_N_RBD",3,80); //Red Dragons blood
}
//void main(){}
