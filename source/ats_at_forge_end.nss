/****************************************************
  Forge EndConversation Script
  ats_at_forge_end

  Last Updated: August 20, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script gets called when the forge's conversation
  ends.  It unlocks the forge.
****************************************************/
void main()
{
    ClearAllActions();
    SetLocked(OBJECT_SELF, FALSE);
}
