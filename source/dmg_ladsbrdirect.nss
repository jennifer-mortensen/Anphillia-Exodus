#include "_inc_assault"

//Redirects damage to this object's ladder.
void main()
{
    object oLadder = GetLadderBaseFromID(GetAssaultObjectID(OBJECT_SELF));

    if(!GetIsObjectValid(oLadder))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    int nDamage = GetDamageDealtByType(DAMAGE_TYPE_ACID);
    int nDamage2 = GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING);
    int nDamage3 = GetDamageDealtByType(DAMAGE_TYPE_COLD);
    int nDamage4 = GetDamageDealtByType(DAMAGE_TYPE_DIVINE);
    int nDamage5 = GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
    int nDamage6 = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    int nDamage7 = GetDamageDealtByType(DAMAGE_TYPE_MAGICAL);
    int nDamage8 = GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE);
    int nDamage9 = GetDamageDealtByType(DAMAGE_TYPE_PIERCING);
    int nDamage10 = GetDamageDealtByType(DAMAGE_TYPE_POSITIVE);
    int nDamage11 = GetDamageDealtByType(DAMAGE_TYPE_SLASHING);
    int nDamage12 = GetDamageDealtByType(DAMAGE_TYPE_SONIC);
    int nDamage13 = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);

    int nTotalDamage;

    if(nDamage > 0)
        nTotalDamage += nDamage;
    if(nDamage2 > 0)
        nTotalDamage += nDamage2;
    if(nDamage3 > 0)
        nTotalDamage += nDamage3;
    if(nDamage4 > 0)
        nTotalDamage += nDamage4;
    if(nDamage5 > 0)
        nTotalDamage += nDamage5;
    if(nDamage6 > 0)
        nTotalDamage += nDamage6;
    if(nDamage7 > 0)
        nTotalDamage += nDamage7;
    if(nDamage8 > 0)
        nTotalDamage += nDamage8;
    if(nDamage9 > 0)
        nTotalDamage += nDamage9;
    if(nDamage10 > 0)
        nTotalDamage += nDamage10;
    if(nDamage11 > 0)
        nTotalDamage += nDamage11;
    if(nDamage12 > 0)
        nTotalDamage += nDamage12;
    if(nDamage13 > 0)
        nTotalDamage += nDamage13;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nTotalDamage), oLadder);
}
