#include "_inc_quest"

void main()
{
    //Generic variable declarations.
    object oPC = GetPCSpeaker();

    InitializeQuest(oPC, "Q3");
}
