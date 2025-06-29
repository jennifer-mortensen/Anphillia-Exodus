#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void  AddACBonusToArmor(object oMyArmor, float fDuration, int nAmount)
{
    IPSafeAddItemProperty(oMyArmor,ItemPropertyACBonus(nAmount), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
   return;
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration  = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nAmount = MothGetCasterLevel(OBJECT_SELF)/4;
    if (nAmount <1)
    {
        nAmount =1;
    }
    if (nAmount>=4)
    {
        nAmount =4;
    }
    object oMyArmor   =  IPGetTargetedOrEquippedArmor(TRUE);
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    //object oScroll = GetSpellCastItem();
    //if(!GetIsObjectValid(oScroll))
    //{
        if(GetHasFeat(FEAT_PROTECTION_DOMAIN_POWER,OBJECT_SELF))
        {
            nAmount +=1;
            SendMessageToPC(OBJECT_SELF, "Protection Domain grants you +1 extra bonus!");
        }
        else if(GetLocalInt(OBJECT_SELF,"MOTHPROTECTIONDOMAIN"))
        {
            nAmount +=1;
            SendMessageToPC(OBJECT_SELF, "Protection Domain grants you +1 extra bonus!");
        }
    //}
    if(GetIsObjectValid(oMyArmor) )
    {
        SignalEvent(GetItemPossessor(oMyArmor ), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nDuration>0)
        {

            location lLoc = GetLocation(GetSpellTargetObject());
            DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyArmor)));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyArmor), TurnsToSeconds(nDuration));
            AddACBonusToArmor(oMyArmor, TurnsToSeconds(nDuration),nAmount);
    }
        return;
    }
        else
    {
           FloatingTextStrRefOnCreature(83826, OBJECT_SELF);
           return;
    }
}
