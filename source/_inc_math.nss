//::///////////////////////////////////////////////
//:: Math Function Library
//:: _inc_math
//:://////////////////////////////////////////////
/*
    Contains math functions.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 15, 2009
//:://////////////////////////////////////////////

//Returns the factorial of nInteger.
int factorial(int nInteger);

//::///////////////////////////////////////////////
//:: factorial
//:://////////////////////////////////////////////
/*
    Returns the factorial of nInteger.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 15, 2009
//:://////////////////////////////////////////////
int factorial(int nInteger)
{
    if (nInteger <= 1)
          return 1;
    else
        return nInteger * factorial(nInteger - 1);
}
