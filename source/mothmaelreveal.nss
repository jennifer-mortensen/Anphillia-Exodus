void main()
{
   object oRevealer = OBJECT_SELF;
   object oMod = GetModule();
   int nTimer = GetLocalInt(oMod,"MothPuzzleMaelstrom2");
   if(nTimer==TRUE)return;
   object oPC = GetLastUsedBy();
   if(!GetIsPC(oPC))return;
   if(nTimer == FALSE)
   {
    AssignCommand(oRevealer,ActionSpeakString("Do not trust your eyes - they will only deceive you. Trust in your step instead."));
    object oBlocker1 = GetObjectByTag("mothinviswall");
    DestroyObject(oBlocker1);
    object oBlocker2 = GetObjectByTag("mothinviswall2");
    DestroyObject(oBlocker2);
    object oBlocker3 = GetObjectByTag("mothinviswall3");
    DestroyObject(oBlocker3);
    object oBlocker4 = GetObjectByTag("mothinviswall4");
    DestroyObject(oBlocker4);
    object oBlocker5 = GetObjectByTag("mothinviswall5");
    DestroyObject(oBlocker5);
    object oBlocker6 = GetObjectByTag("mothinviswall6");
    DestroyObject(oBlocker6);
   }
}
