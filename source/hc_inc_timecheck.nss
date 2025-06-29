// Archaegeo 2002 Aug 9th
int nConv=FloatToInt(HoursToSeconds(1));


// doesn't really return seconds since beginning anymore, just
// an absolute second since the start of time.
int SecondsSinceBegin()
{
    object oMod = GetModule();
    /* We do the start year so our float doesn't overflow */
    int iStartYear = GetLocalInt(oMod, "ModuleStartYear");
    int iCurYear = GetCalendarYear () - iStartYear;
    int iCurMonth = GetCalendarMonth();
    int iCurDay = GetCalendarDay();
    int iCurHour = GetTimeHour();
    int iCurMin = GetTimeMinute();
    int iCurSec = GetTimeSecond();

    int iElapsed = 0;

    // elapsed += year * 12 months in a year * 28 days in a month *
    // 24 hours in a day.
    iElapsed += iCurYear * 12 * 28 * 24;
    iElapsed += iCurMonth * 28 * 24;
    iElapsed += iCurDay * 24;
    iElapsed += iCurHour;

    /* Convert to seconds by multiplying by conversion rate. */
    iElapsed *= nConv;
    iElapsed += iCurMin * 60;
    iElapsed += iCurSec;

    return iElapsed;

    /*
    if(fCurYear==fStartYear)
    {
        if(fCurMonth==fStartMonth)
        {
            if(fCurDay==fStartDay)
            {
                fElapsed += (fCurHour-fStartHour);
            }
            else
            {
                if(fCurHour>fStartHour)
                {
                    fElapsed += 24.0 * (fCurDay-fStartDay);
                    fElapsed += fCurHour-fStartHour;
                }
                else
                {
                    fElapsed += 24.0 * (fCurDay-fStartDay-1.0);
                    fElapsed += 24.0 - fStartHour + fCurHour;
                }
            }
        }
        else
        {
            if(fCurDay>fStartDay)
            {
                fElapsed += 28.0 * 24.0 * (fCurMonth - fStartMonth);
                fElapsed += 24.0 * (fCurDay-fStartDay);
            }
            else
            {
                fElapsed += 28.0 * 24.0 * (fCurMonth - fStartMonth - 1.0);
                fElapsed += 24.0 * (28.0 - fStartDay + fCurDay);
            }
            if(fCurHour > fStartHour)
                fElapsed += fCurHour-fStartHour+2.0;
            else
                fElapsed += -24.0 + fStartHour + fCurHour;
        }
    }
    else
    {
        if(fCurMonth>fStartMonth)
        {
            fElapsed += 12.0 * 28.0 * 24.0 * (fCurYear - fStartYear);
            fElapsed += 28.0 * 24.0 * (fCurMonth-fStartMonth);
        }
        else
        {
            fElapsed += 12.0 * 28.0 * 24.0 * (fCurYear - fStartYear - 1.0);
            fElapsed += 28.0 * 24.0 * (12.0 - fStartMonth + fCurMonth);
        }
        if(fCurDay> fStartDay)
            fElapsed += 24.0 * (fCurDay-fStartDay);
        else
            fElapsed += 24.0 * (28.0 - fStartDay + fCurDay);
        if(fCurHour > fStartHour)
            fElapsed += fCurHour-fStartHour+2.0;
        else
            fElapsed += -24.0 + fStartHour + fCurHour;
    }

    fElapsed = IntToFloat(nConv)*fElapsed;
    fElapsed+=fCurMin*60.0;
    fElapsed+=fCurSec;
    return FloatToInt(fElapsed);
    */
}

