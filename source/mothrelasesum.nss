void main()
{
object oPC = GetPCSpeaker();
object oTarget;
oTarget = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
PlayVoiceChat(VOICE_CHAT_GOODBYE);
if (GetIsObjectValid(oTarget)) RemoveSummonedAssociate(oPC, oTarget);
if (GetIsObjectValid(oTarget)) DestroyObject(oTarget);
}

