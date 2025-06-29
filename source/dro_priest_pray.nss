#include "nw_i0_generic"

void main()
{
   object oCreature = GetEnteringObject();
   string sCreatureTag = GetTag(oCreature);
   if (sCreatureTag == "DrowPriestess")
   {
      AssignCommand(oCreature, ClearAllActions());
      DelayCommand(1.0, AssignCommand(oCreature, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 18.0)));
      DelayCommand(24.0, AssignCommand(oCreature, WalkWayPoints()));
   }
}
