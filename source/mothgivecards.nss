void main()
{
    object oPC = GetPCSpeaker();
    FloatingTextStringOnCreature("<c�� >"+GetName(oPC)+" takes out a Deck of Cards.</c>", oPC, TRUE);
    CreateItemOnObject("moth_sealed_deck",oPC, 1);
}
