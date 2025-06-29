void main()
{
object oPC = GetEnteringObject();

object oBeam;
object oRay;
object oChain;
object oBeam1;
object oRay1;
object oChain1;


oBeam = GetObjectByTag("mothoemitter1a");
oRay = GetObjectByTag("mothoemitter2a");
oChain = GetObjectByTag("mothoemitter3a");
oBeam1 = GetObjectByTag("mothoemitter1b");
oRay1 = GetObjectByTag("mothoemitter2b");
oChain1 = GetObjectByTag("mothoemitter3b");


if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);


{
    effect eBeam = EffectBeam(VFX_BEAM_LIGHTNING, oBeam, BODY_NODE_CHEST);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam, oBeam1);
    effect eBeam2 = EffectBeam(VFX_BEAM_LIGHTNING, oRay, BODY_NODE_CHEST);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam2, oRay1);
    effect eBeam3 = EffectBeam(VFX_BEAM_LIGHTNING, oChain, BODY_NODE_CHEST);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam3, oChain1);
}
}
