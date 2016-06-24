##lecture 3

#### Optional

一个Optional值和非Optional值的区别就在于：Optional值未经初始化虽然为nil，但普通变量连nil都没有。

```
//未被初始化，但是是一个Optional类型，为nil
var str: String?
str //输出nil
//未被初始化，也不是Optional类型
var str2: String
str2 //使用时出错
```
Optional is an enum：


```
enum Optional<T>{
	case None
	case Some(T)
} 
```
当Optional没有值时，返回的nil其实就是Optional.None，即没有值。除了None以外，还有一个Some，当有值时就是被Some<T>包装的真正的值，所以我们拆包的动作其实就是将Some里面的值取出来。

```
	let x: String? = ....
	if let y = x：
```


如果unwrap成功，就用那个值；unwrap失败，则break
 
```
if let x = display?.text?.hashValue {...}
```

当一个Optional值调用它的另一个Optional值的时候，Optional Chaining就形成了，基本上，Optional Chaining就是总是返回一个Optional的值，只要这个Chaining中有一个值为nil，整条Chaining就为nil，和Objective-C的向nil发消息类似。

```
let s : String? = ...

if s != nil {
	display.text = s
} else {
	display.text = " "
}
```
"??"提供default value, 如果s是nil，default value 为 " " 

将以上进行简单的表达

```
display.text = s ?? " "
```

#### Tuple

* 元组的长度任意
* 元组中的数据可以是不同的数据类型

元组的定义很简单，用小括号括起来，然后以逗号隔开就可以了

```
var userInfo = ("Bannings" ,true, 22)  
```
不管是可变还是不可变元组，元组在创建后就不能对其长度进行增加和删除之类的修改，只有可变元组能在创建之后修改元组中的数据。

需要注意的是，可变元组虽然可以修改数据，但却不能改变其数据的数据类型。

使用元祖function可以return多个值。

#### Range

two end points

```
struct Range<T>{
	var startIndex ; T
	var endIndex : T
}
```
一个Array的range是 Range<Int>， String的subrange则是Range<String.Index>...

```

let array = ["a","b","c","d"]
let subArray1 = array[2...3] // ["c","d"]
let subArray2 = array[2..<3] //["c"]

for i in 27...104 { }

```

#### Data  Structures

* Declaration syntax
* Properties and Functions
* Initializers (again, not enum)

```
class CalculatorBrain {
}

struct Vertex { 
}

enum Op {
}
```

区别：

- Inheritance 继承（class）
- value type（struct， enum） vs reference type(class)

**You must note any func that can mutate a struct/enum with the keyword mutating**

基本一般class prefer than struct，因为是OOP。Struct用于更基础的type，比如string, double ,int ,arrays, dictionarys , 同样还用于drawing， points, rectangles.

#### methods

方法的所有参数都有一个内部参数和一个外部参数，内部参数(internalName)是在方法中拥有一个本地变量的名字，外部参数(external)是在内部参数前的部分，给调用者提供。

可以同时拥有外部参数和内部参数，名字可以不同。可以使用下划线来省略外部参数名。

Swift语言中，函数的第一个参数的外部参数默认为下划线，如果想强制显示第一个参数的外部参数可以把第一个参数名在前面再写一遍(即写出外部参数名)。

除第一个参数外的参数外部参数默认与内部参数相同,也可自己指定

* override
* final subclass没法override
* types/instances 可以有methods/properties 

##### instance propery vs Class property


For this example, lets consider using the struct Double (yes, Double is a struct)  
```  var d: Double = ...  if d.isSignMinus {      d = Double.abs(d)}
```isSignMinus is an instance property of a Double (you send it to a particular Double)abs is a type method of Double (you send it to the type itself, not to a particular Double)
You declare a type method or property with a static prefix ...
static func abs(d: Double) -> Double

#### properties

属性观察器

属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，甚至新的值和现在的值相同的时候也不例外。

可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重载属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。

属性观察器有以下两种，可选择性添加：

* willSet : 在设置新的值之前调用。
* didSet : 在新的值被设置之后立即调用。

willSet 观察器会将新的属性值作为固定参数传入，在 willSet 的实现代码中可以为这个参数指定一个名称，或者使用默认名称 newValue 表示。

didSet 观察器会将旧的属性值作为固定参数传入，在 didSet 的实现代码中可以为这个参数指定一个名称，或者使用默认名称 oldValue 表示。

注意：willSet 和 didSet 观察器在属性初始化过程中不会被调用，他们只会当属性的值在初始化之外的地方被设置时调用。

#### Lazy Initalization

someProperty 不会被初始化直到被使用。

Lazy 属性的代码块只会调用一次，lazy修饰的是一个存储属性。

#### Array

```
var a = [String]()
	
filter//筛选
let bigNumbers = [2,47,118,5,9].filter({$0 > 20}) // bigNumbers = [47,118]
	
map//映射
let stringified: [String] = [1,2,3].map {String($0)} // stringified = ["1", "2", "3"]
	
reduce//合计
let sum: Int = [1,2,3].reduce(0){ $0 + $1 } // sum = 6
```


#### Dictionary

	var pac10teamRankings = [String:Int]()
	
	for (key, value) in pac10teamRankings {
		print("\(key) = \(value)")
	}


#### String 

	var characters: String.CharacterView { get }
	

Methods熟悉起来是为了用

```
	startIndex -> String.Index	endIndex -> String.Index	hasPrefix(String) -> Bool	hasSuffix(String) -> Bool	capitalizedString -> String	lowercaseString -> String	uppercaseString -> String	componentsSeparatedByString(String) -> [String] // “1,2,3”.csbs(“,”) = [“1”,”2”,”3”]
```


#### NSObject

Base class for all Objective-C classes

#### NSNumber

	let n = NSNumber(35.5)
	let intversion: Int  = n.intValue

#### NSDate

Used to find out the date and time right now or to store past or future dates.

#### NSData

a bag of bits

Used to save/restore/transmit raw data throughout the iOS SDK.

#### Initialization


#### AnyObject 

* AnyObject可以代表任何class类型的实例。
* Any可以表示任何类型，除了方法类型(function types)。

```
let ao: AnyObject = ...if let foo = ao as? SomeClass {// we can use foo and know that it is of type SomeClass in here}
```
#### Property List

String, Array, Dictionary, a number (Double, Int, etc.), NSData, NSDate

#### NSUserDefaults

NSUserDefaults is essentially a very tiny database that stores Propery List data.

用来存plist，就是一些简单的用户设置

```
let defaults = NSUserDefaults.standardUserDefaults()
let plist = defaults.objectForKey(“foo”)defaults.setObject(plist, forKey: “foo”)
```

Your changes will be automatically saved.

But you can be sure they are saved at any time by synchronizing.

#### Cast

类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。

类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。

#### Assertion

和if的作用相似,判断条件 都是判断一个Bool的表达式, 不过if判断失败最多不会去执行部分代码, 断言(assertion)判断失败的话,不仅仅是不执行代码, 并且还会抛出异常。