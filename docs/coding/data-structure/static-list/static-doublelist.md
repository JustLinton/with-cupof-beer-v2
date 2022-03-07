# 静态双链表

#### 数据结构

- 类似，也有idx，数组`e[n]`；不同的是这里next域由`l[n]`、`r[n]`表示。
- 这里没有head，而是一开始默认0号存head，1号存tail。因此0号和1号只是**用于标识**的，**并不会存实际值**。

#### 初始化

```c++
void init(){
    r[0]=1;
    l[1]=0;
    idx=2;
}
```



#### 在下标是k的结点右边插入

```c++
void add(int x,int k){
    e[idx]=x;
    l[idx]=k;
    r[idx]=r[k];
    l[r[k]]=idx;
  	r[k]=idx;
    idx++;
}
```



#### 在下标是k的结点的左边插入

```c++
void add_left(int x,int k){
    add(x,l[k]);
}
```



#### 删除第k个结点

```c++
void remove(int k){
    r[l[k]]=r[k];
    l[r[k]]=l[k];
}
```

- 同样不需要考虑内存泄漏。

