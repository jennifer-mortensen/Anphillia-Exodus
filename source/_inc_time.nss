//Returns the current time in seconds, assuming a module start year of 0.
int GetSecondsSinceServerBoot()
{
    int nStartYear = GetLocalInt(GetModule(), "ModuleStartYear");
    int nCurrentYear = GetCalendarYear() - nStartYear;
    int nCurrentMonth = GetCalendarMonth();
    int nCurrentDay = GetCalendarDay();
    int nCurrentHour = GetTimeHour();
    int nCurrentMinute = GetTimeMinute();
    int nCurrentSecond = GetTimeSecond();

    int nTimeElapsed;

    //Elasped += Year * Months (12 in a year) * Days (28 in a month) * Hours (24 in a day)
    nTimeElapsed += nCurrentYear * 12 * 28 * 24;
    nTimeElapsed += nCurrentMonth * 28 * 24;
    nTimeElapsed += nCurrentDay * 24;
    nTimeElapsed += nCurrentHour;

    //Convert to seconds.
    nTimeElapsed *= FloatToInt(HoursToSeconds(1));
    nTimeElapsed += nCurrentMinute * 60;
    nTimeElapsed += nCurrentSecond;

    return nTimeElapsed;
}
