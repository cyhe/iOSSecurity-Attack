#import <substrate.h>


void (*old_ZN8CPPClass11CPPFuctionEPKc)(void *, const char *);

void new__ZN8CPPClass11CPPFunctionEPKc(void *hiddenThis, const char *arg0)
{
	if (strcmp(arg0,"this is a short C function!") == 0) 
		old_ZN8CPPClass11CPPFuctionEPKc(hiddenThis,"this is a hijacked short C function form new__ZN8CPPClass11CPPFunctionEPKc!");
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
	old_ShortCFuntion("this is a hijacked short C function form new_ShortCFunction!"); // call the original ShortCFunction
}

%ctor

{
    @autoreleasepool
    {
        MSImageRef image = MSGetImageByName("/Application/iostargetapphhly.app/iostargetapphhly");

        void *__ZN8CPPClass11CPPFunctionEPKc = MSFindSymbol(image,"__ZN8CPPClass11CPPFunctionEPKc");
        if (__ZN8CPPClass11CPPFunctionEPKc) NSLog(@"iosre : found cppfunction!");
        MSHookFunction((void *)__ZN8CPPClass11CPPFunctionEPKc, (void *)&new__ZN8CPPClass11CPPFunctionEPKc, (void **)&old_ZN8CPPClass11CPPFuctionEPKc);
        
        void *_CFunction = MSFindSymbol(image,"_CFunction");
        if (_CFunction) NSLog(@"iosre:found CFunction");
        MSHookFunction((void *)_CFunction, (void *)&new_CFunction, (void **)&old_CFunction);

        void *_ShortCFunction = MSFindSymbol(image, "_ShortCFunction");
        if (_ShortCFunction) NSLog(@"iosre: found ShortCFunction");
        MSHookFunction((void *)_ShortCFunction, (void *)&new_ShortCFunction, (void **)&old_ShortCFuntion); // This MSHookFunction will fail because ShortCFunction is too short to be hooked

    }
}

// MSFindSymbol的作用--->查找待hook的symbol,函数的指令被放在内存中,当进程需要执行这个函数时,它必须要知道去内存的哪个地方找到这个函数,然后执行它的指令,也就是说
// 进程要根据函数名,找到它在内存中的地址,而这个名称与地址的映射关系,是存储在"symbol table"中的-----"symbol table" 中的symbol就是这个函数的名称,进程会根据这个
// symbol找到它在内存中的地址.然后跳转过去执行.



