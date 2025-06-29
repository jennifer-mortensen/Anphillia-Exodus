#include "MOTH_INC_PUZZLE"
void main()
{
    object oMaster = GetItemActivatedTarget();
    object oItem = GetItemActivated();
    string sPet;
    string sName = GetName(oItem);
    if(sName == "Cat")
    {
     sPet = "mothrppet1";
    }
    else if(sName == "Dog")
    {
     sPet = "mothrppet2";
    }
    else if(sName == "Piglet")
    {
     sPet = "mothrppet3";
    }
    else if(sName == "Parrot")
    {
     sPet = "mothrppet4";
    }
    else if(sName == "Kitten")
    {
     sPet = "mothrppet5";
    }
    else if(sName == "Mouse")
    {
     sPet = "mothrppet6";
    }
    else if(sName == "Hen")
    {
     sPet = "mothrppet7";
    }
    else if(sName == "Ferret")
    {
     sPet = "mothrppet8";
    }
    else if(sName == "Mink")
    {
     sPet = "mothrppet9";
    }
    else if(sName == "Monkey")
    {
     sPet = "mothrppet10";
    }
    else if(sName == "Penguin")
    {
     sPet = "mothrppet11";
    }
    else if(sName == "Raccoon")
    {
     sPet = "mothrppet12";
    }
    else if(sName == "Rat")
    {
     sPet = "mothrppet13";
    }
    else if(sName == "Skunk")
    {
     sPet = "mothrppet14";
    }
    else if(sName == "Snake")
    {
     sPet = "mothrppet15";
    }
    else if(sName == "Puppy")
    {
     sPet = "mothrppet16";
    }
    effect eEffect = EffectSummonCreature(sPet,VFX_NONE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oMaster, HoursToSeconds(100));
    DelayCommand(0.5,MothSetPetDescriptionAndName(oMaster));
}
