void RockDamage(location lImpact);
#include "x2_inc_shifter"
#include "x0_i0_spells"
void main()
{
    int iTimer = GetLocalInt(OBJECT_SELF, "hurlboulder");
    if(iTimer == TRUE)
       {
        FloatingTextStringOnCreature("<c ее>*Hurl Boulder Focus lost!*</c>",OBJECT_SELF,FALSE);
        SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
        return;
       }
    effect eImpact = EffectVisualEffect(354);
    effect eImpac1 = EffectVisualEffect(460);
    int nDamage;
    location lImpact = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lImpact);
    DelayCommand(0.2f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpac1, lImpact));
    if(iTimer == FALSE)
      {
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Hurl Boulder Focus is lost!</c>"));
        RockDamage(lImpact);
        SetLocalInt(OBJECT_SELF, "hurlboulder", TRUE);
        DelayCommand(8.0, DeleteLocalInt(OBJECT_SELF, "hurlboulder"));
        DelayCommand(8.1, FloatingTextStringOnCreature("<c ее>*Hurl Boulder Focus Regained!*</c>",OBJECT_SELF,FALSE));
      }
}
void RockDamage(location lImpact)
{
    float fDelay;
    int nDamage;
    effect eDam;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lImpact, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD,TRUE)+11;
    int nDice = GetHitDice(OBJECT_SELF);
    int nExtra = nDice/3*2;
    while (GetIsObjectValid(oTarget))
    {

        if (spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetweenLocations(lImpact, GetLocation(oTarget))/20;
            nDamage = d2(nDice)+nExtra+26;
            if(MySavingThrow(SAVING_THROW_REFLEX,oTarget,nDC,SAVING_THROW_TYPE_TRAP,OBJECT_SELF, fDelay))
            {
             nDamage = nDamage/2;
            }
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_SEVEN);
            if(nDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lImpact, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
