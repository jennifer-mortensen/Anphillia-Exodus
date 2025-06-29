void main()
{
object oPC = GetEnteringObject();
object oTarget = OBJECT_SELF;
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
if (GetIsInCombat(oPC)) return;
if ((GetTag(oTarget) == "mothperception1"))
   SendMessageToPC(oPC,"<cýõæ>There is a alltogether unpleasant feeling about this place. There is a smell, nay - a taste of mercury and sulfur in the air. Vision is rather limited and most other senses are somewhat inparied. The remains of various creatures around you suggests you proceed with caution.</c>");
if ((GetTag(oTarget) == "mothperception2"))
   SendMessageToPC(oPC,"<cýõæ>The heat in this room is intense. It makes even you hesitate before you enter. The air is thick with smoke and slufur here and there seems to be no need to it. Best not linger in this particular area.</c>");
if ((GetTag(oTarget) == "mothperception3"))
   SendMessageToPC(oPC,"<cýõæ>As you enter this room there is a common theme amongst it's wall and ceiling painting - namely moons. Around each of the moon symbols there are warning signs in orbit which is written in Ancient Elven, Coastal Dwarven and Common Drow. Excatly what they are warning about remains abit fuzzy. To the best of your understanding it invloves the awakening of something that is refered to as 'The Exarch Avenger'. Nearby you hear the unmistakeable sound of persistant arcane magic.</c>");
if ((GetTag(oTarget) == "mothperception4"))
   SendMessageToPC(oPC,"<cýõæ>This seems to be a hidden storage room for The Conclave. Judging from the antique in here The Conclave have been pillageing this isle for ages of not aeons.</c>");
if ((GetTag(oTarget) == "mothperception5"))
   SendMessageToPC(oPC,"<cýõæ>You hear a faith low pitch humming noice. It's persistant and near by. What could it be?</c>");
if ((GetTag(oTarget) == "mothperception6"))
   SendMessageToPC(oPC,"<cýõæ>Hmm, a force field. Must be something of value in there.</c>");
if ((GetTag(oTarget) == "mothperception7"))
   SendMessageToPC(oPC,"<cýõæ>Someone or something seem to have dug their way out of that cage.</c>");
if ((GetTag(oTarget) == "mothperception8"))
   SendMessageToPC(oPC,"<cýõæ>Something doesn't feel right here...</c>");
if ((GetTag(oTarget) == "mothperception9"))
   SendMessageToPC(oPC,"<cýõæ>This must be some old equipment used from some sort of experiments.</c>");
if ((GetTag(oTarget) == "mothperception10"))
   SendMessageToPC(oPC,"<cýõæ>The far side of that wall have a number of odd round plates in the wall structure. They must have some function. Prehaps that altar over there is connected to it somehow?</c>");
if ((GetTag(oTarget) == "mothperception11"))
   SendMessageToPC(oPC,"<cýõæ>This appears to be the source of the odd sound. It appears to be a portal.</c>");
if ((GetTag(oTarget) == "mothperception12"))
   SendMessageToPC(oPC,"<cýõæ>This room is filled with remains from countless battles. No doubt from uninvited guests such as yourself. The markings on the walls reads of the event that took place somewhere around here thousands of years ago. 'The Gathering of Alikes' as it is called, seems to be the first step towards the convenant that later became The Conclave. Apperantly leaders from all over the globe came to this place to form this vicious alligance.</c>");
if ((GetTag(oTarget) == "mothperception13"))
   SendMessageToPC(oPC,"<cýõæ>This room as a strange vibe to it, the interior of is all lit in green. The center holds a crystal that levitate in mid-air. There are runes in orbit of it. They are written in a tongue known to you. Futhermore, the room holds seven odd door, much as the singel one you just passed in the corridor.</c>");
if ((GetTag(oTarget) == "mothperception14"))
   SendMessageToPC(oPC,"<cýõæ>As you reach the second level there is a drastic change in humidity. The amount of breathable air has plumit compared to the previous floor. Around here the wall and the ceiling, even the floor seems more or less alive. Organic if you will. The walls are thin and bright lights and strong sounds would penetrate them with ease. Couldn't be that hard to find hidden chambers here, right? However the darkness that surrounds you makes it impossible to see more then 30 feet ahead of you.</c>");
if ((GetTag(oTarget) == "mothperception15"))
   SendMessageToPC(oPC,"<cýõæ>There is a strange construction in the center of this room. It holds several 'peek-holes' which you can look into. The markings on the walls are simular to the room you just passed. They to tell the tale of 'The Gathering of Alikes' but in a slightly different version. According to these texts the leaders did not come here of their own free will. It was more like several well planned abductions, all master minded by a Priest called Emos. Most confusing with this conflicting data.</c>");
if ((GetTag(oTarget) == "mothperception16"))
   SendMessageToPC(oPC,"<cýõæ>As you enter this sub level you are greeted by a unplesant smell of sewage. The air is most likely toxic to some degree and who knows what other hazards lurk here. There is also a sounds from afar, it sounds like machineary.</c>");
if ((GetTag(oTarget) == "mothperception17"))
   SendMessageToPC(oPC,"<cýõæ>This door is firmly locked and way to solid to bash in any matter.</c>");
if ((GetTag(oTarget) == "mothperception18"))
   SendMessageToPC(oPC,"<cýõæ>Before you lies what appears to a way down even futher. If you want to decsend futher, dead ahead is the way.</c>");
if ((GetTag(oTarget) == "mothperception19"))
   SendMessageToPC(oPC,"<cýõæ>Loud sounds of machines at work are coming from beyond this corner.</c>");
if ((GetTag(oTarget) == "mothperception20"))
   SendMessageToPC(oPC,"<cýõæ>This section is flooded. It's hard to walk and maintain your balance here.</c>");
if ((GetTag(oTarget) == "mothperception21"))
   SendMessageToPC(oPC,"<cýõæ>The water has risen high in this area. Manouvering will be hard here.</c>");
if ((GetTag(oTarget) == "mothperception22"))
   SendMessageToPC(oPC,"<cýõæ>You have just been teleported. From what you can tell you are still within Condor's Scream. The senerio around you would indicate this is a flooded area.</c>");
if ((GetTag(oTarget) == "mothperception23"))
   SendMessageToPC(oPC,"<cýõæ>The water seems to been flushed away. You can now proceed into this area.</c>");
if ((GetTag(oTarget) == "mothperception24"))
   SendMessageToPC(oPC,"<cýõæ>The water level here is too high. You cannot go any futher.</c>");
if ((GetTag(oTarget) == "mothperception25"))
   SendMessageToPC(oPC,"<cýõæ>As you enter this area the first thing that strikes you is that it's a housing area. The air is sticky and these is a bitter taste in your mouth as you take a breath.</c>");
if ((GetTag(oTarget) == "mothperception26"))
   SendMessageToPC(oPC,"<cýõæ>Before you rises a gate of incredible magnitude. The are countless markings and runs covering it and the ornaments around it. Even if you are unable to read them with any bigger success, it's appearnt that what lies beyond is of great value to someone. The eletrical forcefield protecting it would require imense amounts of raw eletric power. If the flow of power was to be disrupted, one could begin to think about atempting to open the gate itself.</c>");
if ((GetTag(oTarget) == "mothperception27"))
   SendMessageToPC(oPC,"<cýõæ>A cool breeze hits your face as you enter this area. You are now outside.</c>");
if ((GetTag(oTarget) == "mothperception28"))
   SendMessageToPC(oPC,"<cýõæ>After tunneling in the deeps of Condor's Scream for some time, your sense of direction is distorted. You are unceratin exactly where you are, all you can be sure of is that you have ascended atleast a quater mile. It is fairly safe to assume that below you is the domain of Condor's Scream and this is as high as you can get.</c>");
if ((GetTag(oTarget) == "mothperception29"))
   SendMessageToPC(oPC,"<cýõæ>This complex construction is what appears to be a gigantic lightning rod, most likely used to provide something with electricity.</c>");
if ((GetTag(oTarget) == "mothperception30"))
   SendMessageToPC(oPC,"<cýõæ>The device before you is a controlling unit for something. Prehaps a closer look will reveal more.</c>");
if ((GetTag(oTarget) == "mothperception31"))
   SendMessageToPC(oPC,"<cýõæ>The device before you is a controlling unit for something. Prehaps a closer look will reveal more.</c>");
if ((GetTag(oTarget) == "mothperception32"))
   SendMessageToPC(oPC,"<cýõæ>The device before you is a controlling unit for something. Prehaps a closer look will reveal more.</c>");
if ((GetTag(oTarget) == "mothperception33"))
   SendMessageToPC(oPC,"<cýõæ>The device before you is a controlling unit for something. Prehaps a closer look will reveal more.</c>");
if ((GetTag(oTarget) == "mothperception34"))
   SendMessageToPC(oPC,"<cýõæ>The first thing that hits you is an extreme heat. It's like being stuck in a pressure cooker. As far as traveling goes, this is most likely as far down as you can go. Any deeper would be too hot. Let's hope this journey is nearing it's end.</c>");
if ((GetTag(oTarget) == "mothperceptionorb"))
   SendMessageToPC(oPC,"<cýõæ>Using that orb has effected you in a strange way, you can't really put your finger on it, but things feel...different.</c>");
if ((GetTag(oTarget) == "mothperceptionbemfas"))
   SendMessageToPC(oPC,"<cýõæ>You are now longer in the realm of the mortals, this is for sure. Excatly where you are is another matter. The constellations in the sky is unfamiliar to you. There is some powerful magic at work here. The ground upon which you stand seems to just be a cluster of rocks floating around in an endless abyss of nothingness. To your east you see what appears to be a portal.</c>");
if ((GetTag(oTarget) == "wolfperceptiondrowcamp"))
    SendMessageToPC(oPC,"<cýõæ>The mining camp before you appears to have been evacuated in haste but the sounds of drums can now be heard in the distance. It would not be wise to tarry here for long.</c>");
}






