int StartingConditional()
{
   object oMod = GetModule();
   int torch1 = GetLocalInt(oMod, "iron_torch_1");
   int torch2 = GetLocalInt(oMod, "iron_torch_2");
   int torch3 = GetLocalInt(oMod, "iron_torch_3");
   int torch4 = GetLocalInt(oMod, "iron_torch_4");
   int torch5 = GetLocalInt(oMod, "iron_torch_5");
   int torch6 = GetLocalInt(oMod, "iron_torch_6");
   int torch7 = GetLocalInt(oMod, "iron_torch_7");
   int torch8 = GetLocalInt(oMod, "iron_torch_8");
   int torch9 = GetLocalInt(oMod, "iron_torch_9");
   int torch10 = GetLocalInt(oMod, "iron_torch_10");

   if(torch10 && torch9 && !torch8 && torch7 && !torch6 && !torch5 && !torch4 && torch3 && !torch2 && !torch1){
        return TRUE;
   }

   return FALSE;


}
