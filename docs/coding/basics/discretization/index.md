# 离散化

- 如果现在给出这样的一些数据：这些数据的值域范围很广，例如从1到 $10^9$，但是他们是离散值，也就是说个数远远少于 $10^9$，例如呈现 `1 2 5 8 ...`的情况。
- 我们不可能开一个 $10^9$的数组去存它。那怎么办呢？可以把上述的1映射到下标0处，2映射下标1处，5映射下标2处，以此类推，这样我们只需要一个 $10^5$的数组即**可存放**。
- 但是a中可能有重复元素，所以我们需要**去重**。一般通过如下方式：其中，注意要先sort，并且unique的作用是将sort后的vector中的所有重复的元素放到正规vector的尾部一段区域内，并且返回这个区域开始位置前一个下标。于是我们只需要erase这段区域即可，它从这个区域开始处开始，从整个vector结束处结束。

```c++
vector<int> alls;
sort(alls.begin(),alls.end());
alls.erase(unique(alls.begin(),alls.end()),alls.end());
```

- 如果要从离散化数组中取原来输入的元素，只需要利用二分即可。
- 虽然有的时候前缀和可以解决类似的问题，但是如果数字的取值范围过大，且其中有效的部分过于稀疏，前缀和就是非常低效的。

## 例题

假定有一个无限长的数轴，数轴上每个坐标上的数都是 00。

现在，我们首先进行 nn 次操作，每次操作将某一位置 xx 上的数加 cc。

接下来，进行 mm 次询问，每个询问包含两个整数 ll 和 rr，你需要求出在区间 [l,r][l,r] 之间的所有数的和。

#### 输入格式

第一行包含两个整数 nn 和 mm。

接下来 nn 行，每行包含两个整数 xx 和 cc。

再接下来 mm 行，每行包含两个整数 ll 和 rr。

#### 输出格式

共 mm 行，每行输出一个询问中所求的区间内数字和。

#### 数据范围

−109≤x≤109−109≤x≤109,
1≤n,m≤1051≤n,m≤105,
−109≤l≤r≤109−109≤l≤r≤109,
−10000≤c≤10000−10000≤c≤10000

#### 输入样例：

```
3 3
1 2
3 6
7 5
1 3
4 6
7 8
```

#### 输出样例：

```
8
0
5
```

#### 代码实现

``` c++ title="代码实现" hl_lines="0" 
#include <bits/stdc++.h>
using namespace std;

const int N=300010;

int a[N],s[N];
typedef pair<int,int> ADDQ;

vector<ADDQ> addV,queryV;
vector<int> alls;

int find(int x){
    int l=0,r=alls.size();
    while(l<r){
        int mid=l+r>>1;
        if(alls[mid]>=x)r=mid;
        else l=mid+1;
    }
    return l;
}

int main(){
    // freopen("a.in","r",stdin);
    // freopen("a.out", "w", stdout);

    int n,m;
    cin>>n>>m;

    int x,c;
    for(int i=0;i<n;i++){
        scanf("%d %d",&x,&c);
        addV.emplace_back(x,c);
        alls.push_back(x);
    }

    int l,r;
    for(int i=0;i<m;i++){
        scanf("%d %d",&l,&r);
        queryV.emplace_back(l,r);
        alls.push_back(l);
        alls.push_back(r);
    }

    sort(alls.begin(),alls.end());
    alls.erase(unique(alls.begin(),alls.end()),alls.end());

    for(auto ite=addV.begin();ite!=addV.end();ite++){
        int x=find(ite->first)+1;
        a[x]+=ite->second;
    }

    for(int i=1;i<=alls.size();i++)
        s[i]=s[i-1]+a[i];

    for(auto ite=queryV.begin();ite!=queryV.end();ite++){
        int l=find(ite->first)+1;
        int r=find(ite->second)+1;
        printf("%d\n",s[r]-s[l-1]);
    }
    

    return 0;
}
```

#### 注意

- 这个题目要求输入很多插入请求，我们要做的是要去构建`alls`数组，也就是把题目输入的信息都转换到`alls`数组中。这个`alls`的作用是生成离散化的数字和下标的映射关系。
	- 这里的下标会被作为离散化数字实际存放的数组里面对应的下标。例如有请求要求在100处的数字+15，那么就把这个100打入`alls`，然后经过去重以后，它在`alls`中的下标可能是5（这个数字是我们手写二分查找从而查询得出的。这里只能我们手写二分查找了，因为C++自带的`lower_bound`并不能给出下标的值，只能给出迭代器。），那么在我们实际存放离散数值的数组`a`中，就有 `a[5]+=15`。
	- 然后，我们的前缀和也是以a数组为基础进行的，所以为了实现前缀和，对于每一个查询请求，也要注意把他们的`l、r`放入到`alls`数组进行离散化处理，这样我们才能得到查询的断点在a数组和前缀和数组里面的下标。