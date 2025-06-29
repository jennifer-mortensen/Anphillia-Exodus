/*:://////////////////////////////////////////////
//:: Name Jasperre's News Scripts. Readme!
//:: FileName J_News__readme
//:://////////////////////////////////////////////

                README

    DESCRIPTION

    This is a simple newspaper system. It is about as good as I can get it and
    isn't too complicated, although I wouldn't recommend editing it.

    CONTENTS

    - 2 Newspaper creatures (Vendor, Editor). Vendor has its own clothing.
    - 2 Items.
        - Permission Slip allows PC's to talk to the editor.
            (Note: DM's can always talk to the editor!)
        - Newspaper Scroll thing. Edit the description and name as you want, but
            don't change the tag, resref or power.
    - 33 scripts (and this readme makes 34).
        - Most are editing/Newspaper ones.
        - 3 Are specific to the vendor
        - 1 is specific to the Editor
        - 1 is the spawn for editor and vendor.
    - 3 Conversations
        - Editor's. Won't allow anyone but DM's and possessors of the Permission
          slip edit/delete things.
        - Vendor's. Sells newspapers. Base price 5 (see below to how to edit this)
        - Newspaper. The newspaper itself.
    And thats it. This readme is not needed, so I'd delete it if you get done
    with it.

    INSTALLATION

    The only thing you may need to do to your module for this to work is to
    make sure the script "j_news_paper" fires when the item of same tag works.

    Here is a sample line, or check the script X0_ONITEMACTV and add that to the
    item activation module event.

    Sample line:

    ExecuteScript(GetTag(GetItemActivated()), OBJECT_SELF);

    Then the system is all ready and set up, It uses Customs from 800-921. I
    would not use customs 800-950 in your module to be sure.

    EDITING

    You can modify some values of the system (and re-compile all scripts
    to apply) but not all (unless you want to tamper and maybe break it):

    - Open the file "j_news_ed_inc".
        - The values are the ones at the top.
        - You can edit things like Database Name (defualt: J_NEWSPAPER), vendor
          selling price (conversation uses the new one automatically) the vendor
          shout strings, and the vendor delay between shouting.
        - You can now (1.1) edit how the storage is done. By default, it is
          the bioware database, but it is now in a wrapper function so you can
          edit where it stores the data.

    The customs can be changed, of course, but I wouldn't bother. :-) It might
    break the system.

    You can, of course, safely edit the conversations but make sure you delete
    none of the important text. I personalise newspapers by editing a few of the
    vendors sayings, and a few of the adverts/substories in the newspaper conversation.

    OTHER EDITING

    You can add more pages/stories, and more things such as adverts IF you can follow
    some instructions, and I really don't advise doing this without testing!

    Firstly, you must understand all that has been done already :-) . If you
    don't understand how it gets/sets information, or how includes work, don't bother.

    Next, look at J_News_All_Start, and J_News_ed_Start. They run from customs
    810 up, with 811-813 being pages. This is obviously automatic - only the
    starting custom is set (to 800, in the include file). You must, however,
    state how many stories there can be in the loop - it currently is iStory <= i10;
    changing up will add more customs, that you can use in your conversation.

    More pages are similar, change the inside loop, however it means more editing.
    After this, you edit the conversations (all 2 which use the newspaper) and
    make sure they are a similar pattern to what is already there. Check what
    scripts already exsist and so on. If ANY scripts are wrong, it is likely
    the new stories won't function right!

    For new pages, you just have to modify one section which is used to get
    what page is being looked at or edited.

    Why didn't I do 500 pages? Or 50 stories? Basically, because 10 stories
    is a nice amount for a conversation without "Next page" "Back a page" links
    and much more complicated coding. 3 pages is quite a lot too, as I personally
    do not play NwN to be reading a 5000 word essay on the battle of bodmin hill
    that happened last week, but a short news story on it.

    Database size, compared to anything that uses players (IE increases as players
    increase) is hardly anything, so new pages/more words/more stories won't
    matter too much on actual sizes.

    UNINSTALLATION

    To delete everything, delete all j_news_ prefixed scripts, all j_news_ items,
    and all j_news_ creatures. :-)

    Jasperre

//:://////////////////////////////////////////////
    Versions:

    1.2 - Update
    - Hopefully the vendors conversation works perfectly. I've had reports it
      doesn't.
    - More generic names - "The Paper" and more generic adverts (they were old
      leftover ones from testing)

//:://////////////////////////////////////////////
    1.1 - Update
    - Fixed vendor conversation, missing link
    - Fixed vendor shouting, without shouting a paper story.

    - Added in wrappers for Get and Set to the database, now in J_news_ed_inc
      so that people can use different storage ways easily.

    1.0 - Inital release.
//:://////////////////////////////////////////////
    Feedback/bugs

    Feedback/bugs you can post to me on the Bioware boards :-) Bioware name: Jasperre
    My profile:
    http://nwn.bioware.com/my_account/viewprofile.html?u=215383

    There is also my guild (more primarily for my AI) here:

    http://nwn.bioware.com/guilds_registry/viewguild.html?gid=4241
//:://////////////////////////////////////////////
    Credits

    Thanks to Icrez of Bruehawk/Treegum for letting me basically add and test this
    there.

    Thanks to geradvizaga for the inspiration to do it in an evening :-D

    Thanks to CatScan for suggesting, in as many words as doing it themselves,
    how useful wrappers for the other databases can be.

    And thanks for the feedback off anyone else :-)

//:://////////////////////////////////////////////
//:: Created By: Jasperre
//::////////////////////////////////////////////*/
void main(){}
