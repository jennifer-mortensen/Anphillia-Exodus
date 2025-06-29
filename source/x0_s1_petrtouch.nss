//::///////////////////////////////////////////////////
//:: X0_S1_PETRGAZE
//:: Petrification touch attack monster ability.
//:: Fortitude save (DC 15) or be turned to stone permanently.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/14/2002
//::///////////////////////////////////////////////////

#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nHitDice = GetHitDice(OBJECT_SELF);
    int nSpellID = GetSpellId();
    int nDC = 22;
    MothPetrify(OBJECT_SELF,oTarget, nHitDice, nSpellID, nDC);
}

