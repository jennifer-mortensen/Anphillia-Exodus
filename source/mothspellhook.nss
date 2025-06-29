#include "x2_inc_switches"
#include "x2_inc_itemprop"
#include "moth_inc"

void main()
{
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    int iTargetIsPC = GetIsPC(oTarget);
    int nHostile;
    int nSpellLevel;
    int nSpell;
    string sSpellName;

    if(iTargetIsPC){
       nSpellLevel = MothGetCasterLevel(OBJECT_SELF);
       nSpell = GetSpellId();
       nHostile = StringToInt(Get2DAString("spells", "HostileSetting", nSpell)); //J. Persinne; no need to track hostile spells.
       if(nHostile)
        return;
       sSpellName = Get2DAString("spells", "Label", nSpell);
       SetLocalInt(oTarget, IntToString(nSpell), nSpellLevel);
    }
}
