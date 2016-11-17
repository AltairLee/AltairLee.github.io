---
title: 记录
tags: 
---
```
package cn.lzblog.first;

/**
 * 线性表，自定义arraylist实现
 * 
 * @author lizhen
 * 
 */
public class MyArrayList<AnyType> {

	public static int initSize = 5;// 设置list初始长度为5
	private AnyType[] tempArray;// 存储list的内容的数组
	private int tempSize;// 存储list的实际长度

	/**
	 * 无参构造
	 */
	public MyArrayList() {
		this(10);
	}
	
	/**
	 * 自定义长度构造 
	 * @param size
	 */
	public MyArrayList(int size){
		tempArray = (AnyType[]) new Object[size];
	}
	
	/**
	 * 自定义数组长度
	 * @param newSize
	 */
	public void ensureCapacity(int newSize){
		if(newSize<=tempSize){
			return;
		}
		AnyType[] temp = (AnyType[])new Object[newSize];
		
		for(int i=0;i<tempSize;i++){
			temp[i] = tempArray[i];
		}
		tempArray = temp;
	}
	
	/**
	 *  arraylist长度
	 * @return
	 */
	public int size() {
		return tempSize;
	}

	public boolean isEmpty(){
		return tempSize==0;
	}
	/**
	 *  清空list
	 */
	public void clear() {
		for(int i=0;i<tempSize;i++){
			tempArray[i] = null;
		}
		tempSize = 0;
	}

	/**
	 *  获取下标为index的元素
	 * @param index
	 * @return
	 */
	public AnyType get(int index) {
		if(index>=tempSize){
			throw new ArrayIndexOutOfBoundsException();
		}
		return tempArray[index];
	}

	/**
	 *  在下标index位置，设置元素为any
	 * @param any
	 * @param index
	 */
	public void set(AnyType any, int index) {
		if(index>=tempSize){
			throw new ArrayIndexOutOfBoundsException();
		}
		tempArray[index] = any;
	}

	/**
	 *  在list末尾添加一个元素
	 * @param any
	 */
	public void add(AnyType any) {
		add(any, tempSize);
	}

	/**
	 *  在list指定位置插入一个元素
	 * @param any
	 * @param index
	 */
	public void add(AnyType any, int index) {
		
		if (index > tempSize) {
			System.out.println("下标越界");//这里应该抛出异常
			return;
		}
		
		//如果数组长度不够，需要拓展数组
		if (tempSize >= tempArray.length) {
			ensureCapacity(tempSize*2);
		}
	
		// 所有元素后移
		for (int i = tempSize; i>index; i--) {
			tempArray[i] = tempArray[i-1];
		}
		tempArray[index] = any;

		tempSize++;
	}

	/**
	 *  在list末尾刪除一个元素
	 */
	public void remove() {
		remove(tempSize-1);
	}

	/**
	 *  删除指定位置index处的元素
	 * @param index
	 */
	public void remove(int index) {
		if(index>=tempSize){
			System.out.println("越界");//这里应该抛出异常
			return;
		}
		
		//index后的元素前移
		for(int i=index;i<tempSize-1;i++){
			tempArray[i] = tempArray[i+1];
		}
		tempArray[--tempSize] = null;
	}

	/**
	 * TODO 内部类：迭代器实现
	 */
	
	
	
	
	/**
	 * 测试main方法
	 * @param args
	 */
	public static void main(String[] args) {
		MyArrayList<Integer> arrayList = new MyArrayList<Integer>();
		arrayList.add(34);
		arrayList.add(12, 0);
		arrayList.add(31, 1);
		arrayList.add(32, 1);
		arrayList.add(33);
		arrayList.add(34,14);
		System.out.println(arrayList.size());
		arrayList.remove();
		System.out.println(arrayList.size());
		arrayList.remove(1);
		System.out.println(arrayList.size());
		System.out.println(arrayList.get(1));
		arrayList.set(10, 1);
		
		
	}
}
```


