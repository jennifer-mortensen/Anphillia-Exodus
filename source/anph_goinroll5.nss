void main()
{

    object oGoinus = OBJECT_SELF;
    object oPlayer = GetLastSpeaker();
    int goldnumber = GetGold(oPlayer);
if (goldnumber < 5)
{
SpeakString("Come back when ye have enough gold chap");
}
if (goldnumber >= 5)
{
    TakeGoldFromCreature(5, oPlayer,TRUE);

   int nRollGoinus=d6();
   int nRollPlayer=d6();

    if (nRollPlayer > nRollGoinus)
    {
        DelayCommand( 6.0, SpeakString("Argh...you won..there, take yer gold"));
        DelayCommand( 6.0, GiveGoldToCreature(oPlayer,10));
    }

    if (nRollPlayer == nRollGoinus)
    {
        DelayCommand( 6.0, SpeakString("Hmmm...that'd be a tie then...well, take yer gold back.."));
        DelayCommand( 6.0, GiveGoldToCreature(oPlayer,5));
    }
    if (nRollPlayer < nRollGoinus)
    {
        DelayCommand( 6.0, SpeakString("Yeah...I won !"));
    }

   string sNamePC = GetName(oPlayer);
   string sNameGoin = GetName(oGoinus);

   string sRollGoinus=IntToString(nRollGoinus);
   string sRollPlayer=IntToString(nRollPlayer);

   AssignCommand( oGoinus, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
   DelayCommand( 2.0, AssignCommand( oGoinus, SpeakString(sNameGoin+"Rolled a d6 and gets a: "+sRollGoinus)));

   DelayCommand( 2.0, AssignCommand( oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0)));
   DelayCommand( 4.0, AssignCommand( oPlayer, SpeakString(sNamePC+"Rolled a d6 and gets a: "+sRollPlayer)));

  }
}
