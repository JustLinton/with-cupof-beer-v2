# 静态队列

- 可以采用数组`q`，队首下标`hh`，队尾下标`tt`来描述。

#### 入队
``` c++ title="" hl_lines="0" 
	q[tt++]=x; //元素放到队尾，队尾++
```

#### 出队
``` c++ title="" hl_lines="0" 
	hh++; //队头后移
```

#### 判断是否为空
``` c++ title="" hl_lines="0" 
bool isEmpty(){
	return tt<=hh;
}
```

#### 取队头、取队尾
!!! beer-tips inline end "浅记" 
    可以看出，虽然我们是一个队列，但是我们可以随便访问队头、队尾哈哈哈
``` c++ title="" hl_lines="0" 
q[hh];\\队头
q[tt];\\队尾
```