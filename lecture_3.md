##lecture 3

#### Optional

Optional is an enum：


```
enum Optional<T>{
	case None
	case Some(T)
} 
```
```
	let x: String? = ....
	if let y = x：
```


如果unwrap成功，就用那个值；unwrap失败，则break
 
Optional can be "chained",两个optional连接起来unwrap:

```
if let x = display?.text?.hashValue {...}
```

??提供default value, 如果s是nil，default value 为 " "

```
let s : String? = ...

if s != nil {
	display.text = s
} else {
	display.text = " "
}

//用一句话

display.text = s ?? " "

```

#### Tuple

跟一般的tuple类似，只是命名的时候可以给tuple里面的每个变量一个名字。

之所以介绍tuple是因为这样function可以return多个值。

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