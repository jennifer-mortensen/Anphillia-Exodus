void main()
{
    object oPortcullis = GetObjectByTag("ironhold_Portcullis");
    object oPC = GetLastUsedBy();


    if(GetIsOpen(oPortcullis)){
        SendMessageToPC(oPC, "You look into the eyepeice and see that the porticullis is open, and the gate is closed");
    }else{
        SendMessageToPC(oPC, "You look into the eyepeice and see that the porticullis is closed, and the gate is open");
    }
}
