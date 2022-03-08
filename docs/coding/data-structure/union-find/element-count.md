# 元素计数

!!! beer-tips "浅记" 
    如果要实现对集合内元素的计数，只需要在合并的时候加点料。

#### 数据结构
- 可以用`size[i]`来表示代表元为i的集合的元素个数。因为最初都是把单个元素看做集合，所以任意集合的size初始值都是1.

#### 更新计数
!!! beer-tips inline end "浅记" 
    注意，如果x和y属于一个集合，需要特判。否则会导致集合`size`原地翻倍。

``` c++ title="" hl_lines="0" 
void union(int x,int y){
	x=find(x);
	y=find(y);
	if(x==y)return;
	size[x]+=size[y];
	p[y]=x;
}
```
