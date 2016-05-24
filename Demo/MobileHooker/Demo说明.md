## Demo说明
#####Demo--->iostargetapphhly:目的,验证MSHookFunction对Function的指令总长度有限制
*  说明:针对MobileHooker的使用,CPPClass::CPPFunction,一个CFunction和一个ShortCFunction,作为hook的对象,CPPClass::CPPFunction和CFunction的目的是为了增加这两个函数的长度,使得针对它们俩的MSHookFunction生效,而ShortCFunction会因长度太短,导致针对它的MSHookFunction失效

#####Demo--->hook短函数
* MSHookFunction的指令长度是有限制的，至少为8字节，如果要hook住那些段函数该怎么办？---->一种变通的方法是hook住短函数内部调用的其他函数----短函数之所以短，是因为内部一般都是调用了其他函数，由其他函数来做出实际操作。因此，把长度符合要求的其他函数作为MSHookFunction的目标，然后在replacement里做一些逻辑判断，将它与函数关联上，再把对应的短函数的修改写在这里）