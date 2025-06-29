#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int bImproved = (GetSpellId() == 645);
    int nSwitch = d10();
    switch (nSwitch)
    {
        case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
        case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
        case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    }
    if (bImproved)
    {
      effect eVis = EffectVisualEffect(460);
      effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_COLD);
      effect eHitVis = EffectVisualEffect(VFX_IMP_FROST_S);
      DelayCommand(1.1f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis2, GetLocation(OBJECT_SELF)));
      DelayCommand(1.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
      object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 4.5, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
      while(GetIsObjectValid(oTarget))
      {

            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
            {
                    float fDelay = GetRandomDelay(1.0, 1.2);
                    int nBase = GetHitDice(OBJECT_SELF)/2;
                    int nDamage = nBase + d6(2);
                    if(GetHasFeat(FEAT_EPIC_FIGHTER,OBJECT_SELF))
                    {
                      nDamage=nDamage*2;
                    }
                    if(nDamage > 0)
                    {
                          effect eHit = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_THREE);
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHit, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget));
                    }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 4.5, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
       }
    }
    DoWhirlwindAttack(TRUE,bImproved);
}

