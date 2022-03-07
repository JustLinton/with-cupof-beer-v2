# 归并排序

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

