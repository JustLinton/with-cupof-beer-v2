# 排序



## 快速排序

#### 和归并排序的区别

- 归并：先划分递归， 后排序
- 快排：先排序，后划分递归
- 二者都属于分而治之

#### 模板

- 递归结束条件：l和r相等或超越。因为当l和r相等，说明区间长度=1，也就是不需要继续递归划分了
- 一般习惯把数据范围定义为常量，这样之后如果范围出现问题可以只修改一个地方.
- +的优先级高于移位。
- 一开始，i和j分别是`l-1`和`r+1`（因为需要用`do-while`结构来进行，也就是先移动，后判断），否则会陷入死循环。
- while的条件是`i<j`，也就是i和j**没有相遇或超过**。
- 最后进行递归调用的时候，区间分别是l到`j`和`j+1`到r。
- 注意，这是就地排序，所以传入的是数组名，快速排序方法是void类型。
- 注意，是 `>>1`，而不是 `>>2`.
- 注意，是 `if(i<j) swap`，而不是 `if(q[i]<q[j])`。

```c++
void quick_sort(int *q,int l,int r){
    
	//为避免边界情况，左指针指向数组开始前一个，右指针指向数组开始后一个
    int i=l-1,j=r+1,x=q[l+r>>1];
    
	//递归结束条件
    if(l>=r)return;

    while (i<j)
    {
        //优雅地移动两个指针
        do i++;while(q[i]<x);
        do j--;while(q[j]>x);
        if(i<j)swap(q[i],q[j]);
    }

    quick_sort(q,l,j);
    quick_sort(q,j+1,r);
}
```

#### 练习

[Start 🕹](https://www.acwing.com/problem/content/787/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int q[N];

void quick_sort(int *q,int l,int r){
	//TODO
}

int main(){
    // freopen("a.in","r",stdin);
	// freopen("a.out", "w", stdout);
    int n;
    cin>>n;
    for(int i=0;i<=n-1;i++)cin>>q[i];
    quick_sort(q,0,n-1);
    for(int i=0;i<=n-1;i++)cout<<q[i]<<' ';
    cout<<endl;
}
```



## 归并排序

#### 模板

- 递归返回后，归并过程中，那个k指针是属于tmp数组的，而i、j是属于q数组的，注意。
- tmp数组的作用是保存每次递归后，合并的过程。也就是合并的过程并不是原地的，否则你也没法实现这种合并。tmp数组每次使用后不需要清零。
- 注意，最后从tmp取回到q数组，仍然采用之前k的定义，用k去操纵`tmp`数组比较好理解。且结束条件是 `i<=r`，而不是 `k<=r`.因为tmp数组里面没有`r`。
- 在归并过程中，下标都采用了自增的设计。这样能保证归并的持续进行。
- 可以看到，递归返回后的while中和两个子串不等长处理中，i、j的范围限定分别是相同的；并且k因为操纵tmp数组，所以k永远从0开始取得。
- 递归返回后，准备开始归并时，i和j分别初始化为两段数字串的开始处。k显然仍然是从0开始取。

```c++
int tmp[N];

void merge_sort(int *q,int l,int r){
    //和快排相同
    int mid=l+r>>1;
    if(l>=r)return;

    merge_sort(q,l,mid),merge_sort(q,mid+1,r);

    //递归返回后，把得到的两个有序串归并起来
    int k=0,i=l,j=mid+1;
  	while(i<=mid&&j<=r){
        if(q[i]<=q[j])tmp[k++]=q[i++];
        else tmp[k++]=q[j++];
    }    

    //如果两个子串不等长，则如下处理（到这里一定是下面两个while只有一个成立）
    while(i<=mid)tmp[k++]=q[i++];
    while(j<=r)tmp[k++]=q[j++];

    //从tmp取回到q数组
   	for(i=l,k=0;i<=r;)q[i++]=tmp[k++];
}
```

#### 练习

[Start 🕹](https://www.acwing.com/problem/content/789/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int q[N],tmp[N];

void merge_sort(int *q,int l,int r){
    //TODO
}

int main(){
    // freopen("a.in","r",stdin);
	// freopen("a.out", "w", stdout);
    int n;
    cin>>n;
    for(int i=0;i<=n-1;i++)cin>>q[i];
    merge_sort(q,0,n-1);
    for(int i=0;i<=n-1;i++)cout<<q[i]<<' ';
    cout<<endl;
}
```

