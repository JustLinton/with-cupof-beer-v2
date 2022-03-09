# 题解



## 799 - 最长连续不重复子序列

给定一个长度为 nn 的整数序列，请找出最长的不包含重复的数的连续区间，输出它的长度。

#### 输入格式

第一行包含整数 nn。

第二行包含 nn 个整数（均在 0∼1050∼105 范围内），表示整数序列。

#### 输出格式

共一行，包含一个整数，表示最长的不包含重复的数的连续区间的长度。

#### 数据范围

1≤n≤1051≤n≤105

#### 输入样例：

```
5
1 2 2 3 5
```

#### 输出样例：

```
3
```



#### 题解

- 注意ans的更新是在双指针的while循环之外的，因为有的时候慢指针不需要移动，如果写在while内部，就没法更新答案。
- while里面，`j<=i`是必写的，后面的条件就是决定是否要去移动慢指针。
	- 注意，无论是否移动慢指针，快指针肯定每次都是移动的。当快指针移动到了不符合规则的位置，这个时候慢指针就要出发，去收拾烂摊子。所以`while`循环的判断作用就是慢指针是否要出马，帮快指针收拾烂摊子。
	- 当且仅当烂摊子终于收拾完毕，慢指针即可停下（因为在移动的过程中会不断更新当前状况，也就是下面的`app[a[j]]--;`，当满足条件时，while自动结束，j停在了满足条件情况下让区间最大的位置）。然后这个时候确立出来的区间就是**在快指针现在位置的前提下**，满足条件的最大区间了。
!!! beer-tips "浅记" 
    总之，快指针只管跑，掌握主动权；慢指针掌握被动权。当快指针导致条件不满足，慢指针被迫移动，在j移动的过程中，**尝试**满足条件（移动到了满足的地方，就停止）。

``` c++ title="代码实现" hl_lines="0" 
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int a[N],app[N];

int main(){
    freopen("a.in","r",stdin);
    freopen("a.out", "w", stdout);

    int n,ans;
    cin>>n;

    for(int i=0;i<n;i++)
        scanf("%d",&a[i]);
    
    for(int i=0,j=0;i<n;i++){
        app[a[i]]++;
        while(j<=i&&app[a[i]]>1){
            app[a[j]]--;
            j++;
        }
        ans=max(ans,i-j+1);
    }

    cout<<ans<<endl;

    return 0;
}

```