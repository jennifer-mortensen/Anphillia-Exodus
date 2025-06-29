//flying debris
#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    if (!X2PreSpellCastCode())
    {
       return;
    }
    int nDamage;
    float fDelay;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    effect eDeaf1 = EffectDeaf();
    effect eDeaf2 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eDeaf = EffectLinkEffects(eDeaf1,eDeaf2);
    effect eEffect1 = EffectVisualEffect(136);
    effect eEffect2 = EffectVisualEffect(135);
    effect eEffect3 = EffectVisualEffect(137);
    effect eEffect4 = EffectVisualEffect(319);
    effect eEffect5 = EffectVisualEffect(346);
    effect eEffect6 = EffectVisualEffect(133);
    effect eEffect7 = EffectVisualEffect(253);
    effect eEffect8 = EffectVisualEffect(322);
    effect eEffect9 = EffectVisualEffect(118);
    effect eExplodea = EffectVisualEffect(VFX_FNF_SWINGING_BLADE);
    effect eExplodeb = EffectVisualEffect(460);
    effect eExplodec = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eExploded = EffectVisualEffect(VFX_FNF_PWKILL);
    effect eExplode = EffectLinkEffects(eExplodea,eExplodeb);
    eExplode = EffectLinkEffects(eExplode,eExplodec);
    eExplode = EffectLinkEffects(eExplode,eExploded);
    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM);
    effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_RED_MEDIUM);
    effect eVis3 = EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA);
    effect eLink = EffectLinkEffects(eVis,eVis2);
    eLink = EffectLinkEffects(eLink,eVis3);
    int nSpellDC = MothDC();
    effect eDam1, eDam2, eDam3;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    location lTarget1 = GenerateNewLocationFromLocation(lTarget,3.0,0.0,10.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect1,lTarget1);
    location lTarget2 = GenerateNewLocationFromLocation(lTarget,3.0,75.0,75.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect2,lTarget2);
    location lTarget3 = GenerateNewLocationFromLocation(lTarget,1.0,150.0,150.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect3,lTarget3);
    location lTarget4 = GenerateNewLocationFromLocation(lTarget,3.0,175.0,175.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect4,lTarget4);
    location lTarget5 = GenerateNewLocationFromLocation(lTarget,3.0,250.0,250.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect5,lTarget5);
    location lTarget6 = GenerateNewLocationFromLocation(lTarget,3.0,40.0,40.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect6,lTarget6);
    location lTarget7 = GenerateNewLocationFromLocation(lTarget,3.0,100.0,100.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect7,lTarget7);
    location lTarget8 = GenerateNewLocationFromLocation(lTarget,3.0,150.0,150.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect8,lTarget8);
    location lTarget9 = GenerateNewLocationFromLocation(lTarget,3.0,200.0,200.0);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEffect9,lTarget9);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 16.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    if (nCasterLvl > 30)
    {
         nCasterLvl = 30;
    }
    while (GetIsObjectValid(oTarget))
    {
        if (!MothGetIsFortAlly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/30 + 0.5f;
            nDamage = d4(nCasterLvl);
            eDam1 = EffectDamage((nDamage/3)+3, DAMAGE_TYPE_SLASHING);
            eDam2 = EffectDamage((nDamage/3)+3, DAMAGE_TYPE_BLUDGEONING);
            eDam3 = EffectDamage((nDamage/3)+3, DAMAGE_TYPE_PIERCING);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam3, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
            {
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(nCasterLvl)));
            }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 16.0, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

