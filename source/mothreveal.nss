
#include "x0_i0_secret"


void main()
{
    object oEntered = GetEnteringObject();

    if (GetIsSecretItemRevealed()) {return;}

    if ( DetectSecretItem(oEntered)) {
        if (!GetIsPC(oEntered)) {
            // If a henchman, alert the PC if we make the detect check
            object oMaster = GetMaster(oEntered);
            if (GetIsObjectValid(oMaster)
                && oEntered == GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oMaster))
            {
                AssignCommand(oEntered, PlayVoiceChat(VOICE_CHAT_YES));
            }
        } else {
            // It's a PC, reveal the item
            SendMessageToPC(oEntered, "<cýõæ>Will you look at that...A hidden door.</c>");
            RevealSecretItem("mothhide22");
        }
    }
}

