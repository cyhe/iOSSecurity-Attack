### CydiaSubstrate 

CydiaSubstrate 是绝大部分tweak正常工作的基础，主要分为三部分：MobileHooker,CydiaSubstrate，Safe mode

##### 一、MobileHooker
	
1. MobileHooker的作用是替换系统函数(即hook)

	~~~
	// 作用于OC函数,可直接替换掉方法    
	void MSHookMessageEx(Class class, SEL selector, IMP replacement, IMP *result);
	(Logos语法对此函数进行了封装，但底层实现完全基于MSHookMessageEx)
	// 作用于C , C++
	void MSHookFunction(void* function, void* replacement, void** original);
	(通过编写汇编指令，在进程执行到function时转而执行replacement,同时保存function的指令返回其地址，可选择性的执行function,并保证进程能够执行完replacement后继续正常执行)
	<ps:之前hook必须进行越狱才能操作，现在直接汇编就能实现hook>
	~~~
	repalce替换进程--->下表进程由上向下执行进程

	正常执行的进程1 | 勾住函数A替换为函数B的进程2
	------------- | -------------
	☟Instructions  | ☟Instructions
	☟FunctionA  | ☟FunctionB  （FunctionA暂存）
	☟Instructions | ☟Instructions
	进程先执行一些指令，在原本应该执行的函数A的地方跳转到了函数B的位置执行函数B，同时函数A的	代码被MobielHooker暂时保存了下来。在函数B中，可以选择是否执行函数A，在函数B执行完成	后，则会继续执行剩下的指令。（ps:MSHookFunction的指令长度是有限制的，至少为8字节，如	果要hook住那些段函数该怎么办？---->一种变通的方法是hook住短函数内部调用的其他函数----	短函数之所以短，是因为内部一般都是调用了其他函数，由其他函数来做出实际操作。因此，把长度	符合要求的其他函数作为MSHookFunction的目标，然后在replacement里做一些逻辑判断，将它	与函数关联上，再把对应的短函数的修改写在这里）
	
##### 二、MobileLoader
MobileLoader的作用是加载第三方dylib。在iOS启动时，会由launched将MobileLoader载入内存，然后MobileLoader会根据dylib的同名plist文件指定的作用范围，有选择的在不同进程里通过dlopen函数打开目录/Library/MobileSubstrate/DynamicLibraries/下的所有dylib.
##### 三、Safe mode
应用的质量良莠不齐，程序崩溃再说难免，因为tweak的本质是dylib，寄生在别的进程里，一旦出错，可能导致整个进程崩溃，而一旦崩溃的是SpringBoard等系统进程，则会造成iOS瘫痪，所以CydiaSubstrate引入了Safe mode，它会补获SIGTRAP、SIGTBRT、SIGILL、SIGBUS、SIGSEGV、SIGSYS这六种信号，然后进入安全模式。
（ps:在安全模式里，所有基于CydiaSubstrate的第三方dylib会被禁用，便于查找于修复；如果设备因为dylib的原因无法进入系统，比如，开机一直卡在白苹果上，或者进度圈不停地转--->home+lock+然后音量上键禁用CydiaSubstrate，系统重启后再查错与排修，修复后重启iOS，CydiaSubstrate会自动重启）