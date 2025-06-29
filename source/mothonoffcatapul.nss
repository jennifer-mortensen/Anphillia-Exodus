#include "X0_I0_SPELLS"
void main()
{
    object oTarget = GetNearestEnemy(OBJECT_SELF);
    float fDist = GetDistanceBetween(OBJECT_SELF,oTarget);
    object oUser = GetLastUsedBy();
    if(GetLocalInt(OBJECT_SELF,"MothReloadCat") == 1)
    {
     if (fDist >= 55.0){return;}
     while(GetIsObjectValid(oTarget))
     {
          if(GetIsReactionTypeHostile(oTarget)==TRUE)
            {
             if (!GetIsDead(oTarget))
                {
                PlaySound("zep_catapult");
                PlaySound("zep_catapult");
                DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
                ActionCastSpellAtObject(773,oTarget,METAMAGIC_ANY,TRUE,1,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
                oTarget = OBJECT_INVALID;
                int nInt;
                nInt = GetObjectType(OBJECT_SELF);
                if(nInt != OBJECT_TYPE_WAYPOINT){ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), OBJECT_SELF);}
                else{ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), GetLocation(OBJECT_SELF));}
                if(nInt != OBJECT_TYPE_WAYPOINT){ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), OBJECT_SELF);}
                else{ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(OBJECT_SELF));}
                SetLocalInt(OBJECT_SELF,"MothReloadCat",0);
                }
            }
     }
    }
    if(GetLocalInt(OBJECT_SELF,"MothReloadCat") == 0)
    {
        SetUseableFlag(OBJECT_SELF,0);
        PlaySound("as_dr_metlmedop2");
        FloatingTextStringOnCreature("<cþ þ>*Loading Catapult...*</c>",oUser,FALSE);
        DelayCommand(11.0,PlaySound("as_dr_metlvlgcl1"));
        DelayCommand(18.0,PlaySound("as_dr_metllgcl1"));
        DelayCommand(19.8,FloatingTextStringOnCreature("<cþ þ>*Catapult Loaded!*</c>",oUser,FALSE));
        DelayCommand(19.7,SetLocalInt(OBJECT_SELF,"MothReloadCat",1));
        DelayCommand(19.5,SetUseableFlag(OBJECT_SELF,1));
    }
}
