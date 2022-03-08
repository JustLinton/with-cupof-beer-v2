# 并查集

!!! beer-tips "浅记" 
    并查集的作用是高效地管理集合。具体来讲，涉及集合的合并和询问元素属于哪个集合。

!!! beer-tips "浅记" 
    并查集的官方定义不包括元素的删除。
#### 数据结构
- 并查集是森林。每棵树是一个集合。树根元素称为集合的代表元。
- 这个森林可以用父节点数组表示，`p[i]`表示结点i的父亲是谁。
- 一开始，单个元素看成单个集合。

#### 判断树根
``` c++ title="" hl_lines="0" 
bool isRoot(int x){
	return p[x]==x;
}
```

#### 求属于哪个集合
``` c++ title="" hl_lines="0" 
int find(int x){
	while(p[x]!=x)x=p[x];
	return x;
}
```

#### 合并集合
把一棵树的根节点直接插到另一棵树的根节点的下面。
注意，这里的意思是“合并x所在的集合和y所在的集合”。
``` c++ title="" hl_lines="0" 
void union(int x,int y){
	x=find(x);
	y=find(y);
	p[x]=y;
}
```
