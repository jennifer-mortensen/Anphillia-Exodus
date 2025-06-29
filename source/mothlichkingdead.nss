#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void main()
{
        if (!X2PreSpellCastCode())
        {
            return;
        }
    int nDamage1, nDamage2, nDamage3, nDamage4, nDamage5;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON);
    effect eExplode1 = EffectVisualEffect(464);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eExplode3 = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eExplode4 = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eExplode5 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis3 = EffectVisualEffect(VFX_IMP_SONIC);
    int nCasterLevel = 50;
    effect eDam1, eDam2, eDam3, eDam4, eDam5, eDam6, eKnock;
    eKnock= EffectKnockdown();
    float fKnock = IntToFloat(nCasterLevel);
    fKnock = fKnock*0.1 + 4.0;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode2, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode5, lTarget);
    DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode5, lTarget));
    DelayCommand(2.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode5, lTarget));
    DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode5, lTarget));
    DelayCommand(4.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode5, lTarget));
    DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode5, lTarget));
    DelayCommand(5.2,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode1, lTarget));
    DelayCommand(5.4,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode3, lTarget));
    DelayCommand(5.4,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode4, lTarget));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 40.0f, lTarget, FALSE, OBJECT_TYPE_CREATURE);
    int nTotalDamage;
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        fDelay = 5.7;
            nDamage1 = d6(11);
            nDamage2 = d6(11);
            nDamage3 = d6(11);
            nDamage4 = d6(11);
            nDamage5 = d6(11);
            nTotalDamage = nDamage1+nDamage2+nDamage3+nDamage4+nDamage5;
            eDam1 = EffectDamage(nDamage1, DAMAGE_TYPE_POSITIVE);
            eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_DIVINE);
            eDam3 = EffectDamage(nDamage3, DAMAGE_TYPE_NEGATIVE);
            eDam4 = EffectDamage(nDamage4, DAMAGE_TYPE_MAGICAL);
            eDam5 = EffectDamage(nDamage5, DAMAGE_TYPE_NEGATIVE);
            if(nTotalDamage > 0)
            {
                if (nTotalDamage > 20)
                {
                    DelayCommand(fDelay+0.3f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget,fKnock));
                }
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam3, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam4, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam5, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay+0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                DelayCommand(fDelay+0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 40.0f, lTarget, FALSE, OBJECT_TYPE_CREATURE);
    }


}

