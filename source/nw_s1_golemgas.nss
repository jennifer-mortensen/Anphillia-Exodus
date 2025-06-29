#include "X0_I0_SPELLS"
void main()
{
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    effect eCone = EffectPoison(POISON_IRON_GOLEM);
    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    int nDC = 24;
    int nDamage;
    effect eDmg;
    //If Iron Golem
    if(GetAppearanceType(OBJECT_SELF) == 89
       || GetAppearanceType(OBJECT_SELF) == 420//new Iron
       )
    {
      nDC = GetHitDice(OBJECT_SELF);
    }
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
            nDamage = nDC/2 + d8(3);
            eDmg = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GOLEM_BREATH_GAS));
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eCone, oTarget));
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON, OBJECT_SELF, fDelay))
              {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
              }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE);
    }
}



