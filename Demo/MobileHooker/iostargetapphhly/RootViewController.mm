//
//  RootViewController.cpp
//  ssd
//
//  Created by esirnus on 16/5/23.
//  Copyright © 2016年 esirnus. All rights reserved.
//

#import "RootViewController.h"


class CPPClass
{
public:
    void CPPFunction(const char *);
};

void CPPClass::CPPFunction(const char *args0)
{
    for (int i = 0; i < 66; i++) // 这个循环可以有足够长的时间来验证 MSHookFunction
    {
        u_int32_t randomNumber;
        if (i % 3 == 0) randomNumber = arc4random_uniform(i);
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSString *hostName = processInfo.hostName;
        int pid = processInfo.processIdentifier;
        NSString *globallyUniqueString = processInfo.globallyUniqueString;
        NSString *processName = processInfo.processName;
        NSArray *junks = @[hostName,globallyUniqueString,processName];
        NSString *junk = @"";
        for (int j = 0; j < pid; j++)
        {
            if (pid % 6 == 0) junk = junks[j % 3];
        }
        if (i % 68 == 1) NSLog(@"Junk: %@",junk);
    }
    NSLog(@"HHLY: CPPFunction:%s",args0);
}

extern "C" void CFunction(const char *args0)
{
    for (int i = 0; i < 66; i++)
    {
        u_int32_t randomNumber;
        if (i % 3 == 0) randomNumber = arc4random_uniform(i);
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSString *hostName = processInfo.hostName;
        int pid = processInfo.processIdentifier;
        NSString *globallyUniqueString = processInfo.globallyUniqueString;
        NSString *processName = processInfo.processName;
        NSArray *junks = @[hostName,globallyUniqueString,processName];
        NSString *junk = @"";
        for (int j = 0; j < pid; j++)
        {
            if (pid % 6 == 0) junk = junks[j % 3];
        }
        if (i % 68 == 1) NSLog(@"Junk: %@",junk);
    }
    NSLog(@"HHLY: CFunction:%s",args0);
}

extern "C" void shortCFunction(const char *args0) // shortCFunction is too short to be hooked
{
    CPPClass cppclass;
    cppclass.CPPFunction(args0);
}


@implementation RootViewController


- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
    //    self.view  = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CPPClass cppclass;
    cppclass.CPPFunction("this is cpp function");
    CFunction("this is c function");
    shortCFunction("this is a short C function");
}


@end
