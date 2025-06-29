void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
SendMessageToPC(oPC, "You find some some papers on the floor. They seem to have been part of a book, but you don't see any sign of the covers. One passage catches your attention '...in this time of strife the young warrior approached his king. He knew that if he was to become a knight, he would also need to approval of his queen. As the priests of Emos were all seers, they would surely soon discover that he was indeed the traitor in their mist. Time was short and our young hero needed a plan...'");
}
