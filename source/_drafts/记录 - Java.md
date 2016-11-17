---
title: 记录
tags: 
---

为什么不能根据返回类型来区分重载?
* 我们在方法调用的时候，是不关注他的返回值的，所以如果两个方法的声明，仅仅是返回值不同，方法名，参数都相同的话，调用该方法时，程序就不知道该用哪一个了。


多态问题：
*
```
class A {
         public String show(D obj)...{
                return ("A and D");
         } 
         public String show(A obj)...{
                return ("A and A");
         } 
} 
class B extends A{
         public String show(B obj)...{
                return ("B and B");
         }
         public String show(A obj)...{
                return ("B and A");
         } 
}
class C extends B...{} 
class D extends B...{} 
```

A a1 = new A();
A a2 = new B();
B b = new B(); 
C c = new C(); 
D d = new D(); 
System.out.println(a1.show(b));   ①A and A
System.out.println(a1.show(c));   ②A and A
System.out.println(a1.show(d));   ③A and D
System.out.println(a2.show(b));   ④B and A
System.out.println(a2.show(c));   ⑤B and A
System.out.println(a2.show(d));   ⑥A and D
System.out.println(b.show(b));    ⑦B and B
System.out.println(b.show(c));    ⑧B and B
System.out.println(b.show(d));    ⑨A and D

