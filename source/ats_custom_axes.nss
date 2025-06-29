#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomAxes()
{
//Battle axe
ATS_Recipe_NewRecipe("Battle Axe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 33);
ATS_Recipe_SetMinSkill(50);
ATS_Recipe_SetMaxSkill(85);
ATS_Recipe_Ingots(12);
//Great axe
ATS_Recipe_NewRecipe("Great Axe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 34);
ATS_Recipe_SetMinSkill(100);
ATS_Recipe_SetMaxSkill(135);
ATS_Recipe_Ingots(18);
//Static (Hand axe)
ATS_Recipe_NewRecipe("Static", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 30);
ATS_Recipe_SetSingleType("ATS_C_W030_E_GOL");
ATS_Recipe_SetMinSkill(385);
ATS_Recipe_SetMaxSkill(435);
ATS_Recipe_AddMaterial("ATS_C_W001_E_GOL",1,5);  //Exceptional Gold Handaxe
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",3,90); //Blue Dragons blood
/*//ArcaneBite (Battle axe)
ATS_Recipe_NewRecipe("ArcaneBite", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 40);
ATS_Recipe_SetSingleType("ATS_C_W040_E_BLA");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W033_E_ADA",1,5);  //Exceptional Adamantine Battleaxe
ATS_Recipe_AddMaterial("ATS_R_MISC_N_HRT",1,90); //Black Heart
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC09",2,90); //Rakasha's eye*/
//Flamebiter
ATS_Recipe_NewRecipe("Flamebiter", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 39);
ATS_Recipe_SetSingleType("ATS_C_W039_E_RUB");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_W034_E_RUB",1,5);  //Exceptional Rubicite Great Axe
ATS_Recipe_AddMaterial("ATS_R_MISC_N_RBD",3,90); //Red Dragons blood
//Double Axe
ATS_Recipe_NewRecipe("Double Axe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 78);
ATS_Recipe_SetMinSkill(95);
ATS_Recipe_SetMaxSkill(130);
ATS_Recipe_Ingots(35);
//Bronze Dwarven Waraxe
ATS_Recipe_NewRecipe("Mithril Dwarven Waraxe", ATS_CRAFT_TYPE_WEAPON, ATS_CRAFT_PART_AXES, 21);
ATS_Recipe_SetSingleType("ATS_C_W421_N_BRO");
ATS_Recipe_SetMinSkill(385);
ATS_Recipe_SetMaxSkill(435);
ATS_Recipe_AddMaterial("ATS_C_W033_E_BRO",1,5);  //Exceptional Bronze Battleaxe
ATS_Recipe_AddMaterial("ATS_C_G001_E_MAL",3,100); //Ideal Cut Malachite
}
//void main(){}
