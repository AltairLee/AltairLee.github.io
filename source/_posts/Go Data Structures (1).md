---
title: Go Data Structures (1)
date: 2017-07-15 21:24:32
tags: Go
categories: Go
---

# 1.Basic types

1. 布尔型：`bool`，默认为`false`。
2. 整型：支持无符号`int`和有符号`uint`，具体长度有编译器类型决定。也可以指定长度：rune, int8, int16, int32, int64和byte, uint8, uint16, uint32, uint64。rune是int32的别称，byte是uint8的别称。这些类型间不允许直接相互赋值或者操作。
3. 浮点型：`float32`和`float64`两种，，默认是`float64`。

下图是各类型在内存中的存储方式：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%20Data%20Structures%20%281%2901.png)

<!--more-->

# 2.Strings

每个字符串对象在内存中包含两部分，一个是指向其数据的指针，一个是字符串的长度。string对象是不可变的，所以多个字符串对象共享同一块内存是安全的，字符串对象虽不能修改，但是可以进行切片操作，见下图。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%20Data%20Structures%20%281%2902.png)

字符串的切片操作，不会创建一个副本。

如果非要修改，可以通过string转[]byte，然后[]byte转string的方式实现。

```
    s := "hello"
    c := []byte(s) 
    c[0] = 'c'
    s = string(c)
    fmt.Printf("%s\n", s)
```

即便是这种方式，最初的`hello`字符串在内存中也是没有改变的，只不过这个过程中进行了复制。

# 3.Slices

## 3.1. slice内存存储格式

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%20Data%20Structures%20%281%2903.png)

上图显示的是slice在内存中的存储方式，Go中数组存储在一段连续的内存中，slice对象是引用的数组的一部分，在内存中它有3个部分：
1. 指向第一个元素的指针
2. 切片的长度
3. 切片的容量

其中长度是索引的上限，如x[i]；容量是切片等操作的上限，如x[i:j]。

## 3.2. slice的len&cap

```go
	x := []int{1, 2, 3, 4, 5, 6}
	y := x[1:3]
	fmt.Println("x :", x)
	fmt.Println("y :", y)
	fmt.Println("y len :", len(y))
	fmt.Println("y[1] : ", y[1])
	fmt.Println("y cap :", cap(y))
	fmt.Println("y[2:4] : ", y[2:4])
```

就像字符串的切片一样，数组的切片也不会创建一个副本，他们在内存中指向的还是同一块内存区域。示例中的y执行了一个切片操作，这里仅仅是写入一个新的slice对象（pointer、length and capacity），pointer指向切片的起始地址，len是切片的长度，cap与所在数组有关。

```
    x : [1 2 3 4 5 6]
    y : [2 3]
    y len : 2
    y cap : 5
    y[2] :  3
    y[2:4] :  [4 5]
```

## 3.3. slice扩容

看以下两个代码示例：

代码一：
```
    func main(){
        s := []int{5}
        s = append(s, 7)
        s = append(s, 9)
        x := append(s, 11)
        y := append(s, 12)
       fmt.Println(s, x, y)
    }
```

代码二：
```
    func main(){
    	s := []int{5, 7, 9}
    	x := append(s, 11)
    	y := append(s, 12)
    	fmt.Println(s,x,y)
    }
```
可以先考虑一下结果是什么。

代码一的执行结果：

```
[5 7 9] [5 7 9 12] [5 7 9 12]
```

代码二的执行结果：

```
[5 7 9] [5 7 9 11] [5 7 9 12]
```

为什么会是这样呢？

这就要关注一下slice的扩容策略和append的方法。

扩容规则：
- 如果新的大小是当前大小2倍以上，则大小增长为新大小
- 否则循环以下操作：如果当前大小小于1024，按每次2倍增长，否则每次按当前大小1/4增长。直到增长的大小超过或等于新大小。

slice的append方法在go文档中是这样写的：https://golang.org/pkg/builtin/#append

> `func append(slice []Type, elems ...Type) []Type`
>
> The append built-in function appends elements to the end of a slice. If it has sufficient capacity, the destination is resliced to accommodate the new elements. If it does not, a new underlying array will be allocated. Append returns the updated slice. It is therefore necessary to store the result of append, often in the variable holding the slice itself:
> 
> `slice = append(slice, elem1, elem2)`
>
> `slice = append(slice, anotherSlice...)`
>
> As a special case, it is legal to append a string to a byte slice, like this:
> 
> `slice = append([]byte("hello "), "world"...)`

append新的元素到slice尾部时，如果slice有足够的cap，元素会被直接添加到最后，然后将新slice返回；如果cap不足，则会按照新的cap分配内存并copy原数组，然后append元素，并返回。所以有必要将append操作的结果重新赋值给原有变量。

在之前的两个代码中，这两句话是有风险的：

```
    x := append(s, 11)
    y := append(s, 12)
```

分析代码一：

```
    s := []int{5}           // pointer(0x1111),len(s) = 1,cap(s) = 1
    s = append(s, 7)        //s的cap不足，需扩容，完成后：pointer(0x2222),len(s) = 2,cap(s) = 2 
    s = append(s, 9)        //s的cap不足，需扩容，完成后：pointer(0x3333),len(s) = 3,cap(s) = 4 
    x := append(s, 11)      //s的cap足够，不需要扩容（既不需要分配新的地址）
                            //s：pointer(0x3333),len(s) = 3,cap(s) = 4（5 7 9）
                            //x: pointer(0x3333),len(s) = 4,cap(s) = 4（5 7 9 11）
    y := append(s, 12)      //s的cap足够，不需要扩容（既不需要分配新的地址，直接在s后增加）
                            //s: pointer(0x3333),len(s) = 3,cap(s) = 4（5 7 9）
                            //x: pointer(0x3333),len(s) = 4,cap(s) = 4（5 7 9 12）
                            //y: pointer(0x3333),len(s) = 4,cap(s) = 4（5 7 9 12）
   fmt.Println(s, x, y)     
```
s,x,y都指向同一个地址。


分析代码二：

```	
    s := []int{5, 7, 9}     //pointer(0xaaaa),len(s) = 3,cap(s) = 3
	x := append(s, 11)      //cap不足，需扩容，完成后
	                        //s: pointer(0xaaaa),len(s) = 3,cap(s) = 3
	                        //x: pointer(0xbbbb),len(s) = 4,cap(s) = 6
	y := append(s, 12)      //cap不足，需扩容，完成后
	                        //s: pointer(0xaaaa),len(s) = 3,cap(s) = 3
	                        //x: pointer(0xbbbb),len(s) = 4,cap(s) = 6
	                        //y: pointer(0xcccc),len(s) = 4,cap(s) = 6
	fmt.Println(s,x,y)      
```
s,x,y都指向不同的地址。

所以如果使用slice的append操作，最好将append的结果重新赋值给原有对象，否则要格外注意slice是否扩容的问题。



文中部分内容转自：https://research.swtch.com/godata
