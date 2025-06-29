#include "ats_const_recipe"
#include "ats_inc_recipe_f"
void ATS_CustomArmor2()
{
////Holy Defiance (Silver Full plate)
ATS_Recipe_NewRecipe("Holy Defiance", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 35);
ATS_Recipe_SetSingleType("ATS_C_A035_E_SIL");
ATS_Recipe_SetMinSkill(390);
ATS_Recipe_SetMaxSkill(440);
ATS_Recipe_AddMaterial("ATS_C_A008_E_SIL",1,5);  //Excep. Silver Fullplate
ATS_Recipe_AddMaterial("ATS_R_MISC_N_PAR",4,90); //Essense of Parameus
//Stormwraiths Oath (Banded mail)
ATS_Recipe_NewRecipe("Stormwraiths Oath", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 37);
ATS_Recipe_SetSingleType("ATS_C_A037_E_GOL");
ATS_Recipe_SetMinSkill(395);
ATS_Recipe_SetMaxSkill(445);
ATS_Recipe_AddMaterial("ATS_C_A006_E_GOL",1,5);  //Excep. Gold Banded
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC13",1,90); //Skeletons Knuckle
ATS_Recipe_AddMaterial("ATS_R_MISC_N_BLD",2,90); //Blue Dragons blood
//THUNOR! (Breastplate)
ATS_Recipe_NewRecipe("Thunor", ATS_CRAFT_TYPE_ARMOR, ATS_CRAFT_PART_MISC, 30);
ATS_Recipe_SetSingleType("ATS_C_A030_E_ADA");
ATS_Recipe_SetMinSkill(395);
ATS_Recipe_SetMaxSkill(445);
ATS_Recipe_AddMaterial("ATS_C_A004_E_ADA",1,5);  //Excep. Ada. Breastplate
ATS_Recipe_AddMaterial("ATS_R_MISC_N_PAR",1,90); //Essense of Parameus
ATS_Recipe_AddMaterial("NW_IT_MSMLMISC09",2,90); //Rakasha's eye
}
//void main(){}
