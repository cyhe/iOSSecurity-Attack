#import <substrate.h>


void (*old_ZN8CPPClass11CPPFuctionEPKc)(void *,const char *);

void new_old_ZN8CPPClass11CPPFuctionEPKc(void *hiddenThis,const char *arg0)
{
	if (strcmp(arg0,"this is a short C function!") == 0) 
		old_ZN8CPPClass11CPPFuctionEPKc(hiddenThis,"this is a hijacked short C function form new_ZN8CPPClass11CPPFuctionEPKc!");
	else old_ZN8CPPClass11CPPFuctionEPKc(hiddenThis,"this is a hijacked c++ function");
}

void (*old_CFunction)(const char *);

void new_CFunction(const char *arg0)
{
	old_CFunction("this is a hijacked C function!");  // call the original CFunction
}

void (*old_ShortCFuntion)(const char *);

void new_ShortCFunction(const char *arg0)
{
	old_shortCFuntion("this is a hijacked short C function form new_ShortCFunction!"); // call the original ShortCFunction
}

%ctor

{
    @atuoreleasepool
    {
        MSImageRef image = MSGetImageByName("/Application/iostargetapphhly.app/iostargetapphhly");
        void *__ZN8CPPClass11CPPFunctionEPKc = MSFindSymbol(image,"__ZN8CPPClass11CPPFunctionEPKc");
        if (__ZN8CPPClass11CPPFunctionEPKc = MSMSFindSymbol(image,"__ZN8CPPClass11CPPFunctionEPKc"));
        
    }
}



