Logos语法解析

* 1.%hook
> 指定需要hook的class,必须以％end结尾。

* 2.％log
> 该指令在%hook内部使用，将函数的类名、参数等信息写入syslog,可以％log([(),…..])的格式追加其他打印信息。

* 3.％orig
> 该指令在%hook内部使用，执行被hook的函数的原始代码；也可以用％orig更改原始函数的参数。

* 4.%group
> 该指令用于将%hook分组，便于代码管理及按条件初始化分组，必须以%end结尾。
> 一个％group可以包含多个%hook,所有不属于某个自定义group的％hook会被隐式归类到％group_ungrouped中。

* 5.%init
> 该指令用于初始化某个％group，必须在%hook或％ctor内调用；如果带参数，则初始化指定的group，如果不带参数，则初始化_ungrouped.
注：
切记，只有调用了％ini,对应的%group才能起作用！

* 6.%ctor
> tweak的constructor,完成初始化工作；如果不显示定义，Theos会自动生成一个%ctor,并在其中调用%init(_ungrouped)。

* 7.%new
> 在%hook内部使用，给一个现有class添加新函数，功能与class_addMethod相同。

	> 注：
Objective-C的category与class_addMethod的区别：
前者是静态的而后者是动态的。

* 8.%c
> 该指令的作用等同于objc_getClass或NSClassFromString,即动态获取一个类的定义，在%hook或％ctor内使用 。 