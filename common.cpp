#include "common.h"

//source: http://www.guyrutenberg.com/2007/09/22/profiling-code-using-clock_gettime/
timespec diff(timespec start, timespec end)
{
        timespec temp;
        if ((end.tv_nsec-start.tv_nsec)<0) {
                temp.tv_sec = end.tv_sec-start.tv_sec-1;
                temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
        } else {
                temp.tv_sec = end.tv_sec-start.tv_sec;
                temp.tv_nsec = end.tv_nsec-start.tv_nsec;
        }
        return temp;
}

long long int getMilliseconds(timespec t)
{
  return t.tv_sec*1000 + t.tv_nsec/1000000;
}

long long int getNanoseconds(timespec t)
{
  return (1000000000*t.tv_sec) + t.tv_nsec;
}

void gettime(timespec& t)
{
  clock_gettime(CLOCK_REALTIME,&t);
}
