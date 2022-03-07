# 静态栈

#### 数据结构
- 栈可以用数组`stk`模拟。同时，可以用`tt`这个整型来记录栈顶所在idx。
- 其中，`tt`初始化为0，表示栈空。

#### 入栈
``` c++ title="" hl_lines="0" 
	stk[tt++]=x;
```

#### 出栈
``` c++ title="" hl_lines="0" 
	tt--;
```

#### 判断是否为空
``` c++ title="" hl_lines="0" 
bool isEmpty(){
	return tt<=0;
}	
```

#### 取栈顶元素
``` c++ title="" hl_lines="0" 
	stk[tt];
```

