# 整数二分

#### 思想

- 如果是整数二分，那么这两个区间甚至不会连接。
- 于是，我们只需要找出左边那个区间的右边界，或是找出右边区间的左边界，都是正确的答案。
- 对于这种二分，我们有两种不同的模板。也就是根据是找的左区间右边界还是右区间左边界来判断。
- 二分的性质：每轮迭代，所在的区间内一定包含了正确答案。所以是一个不断缩小范围的过程。这种缩小的过程是log的。



#### lower_bound和upper_bound问题

- 对应C++库函数中的这两个函数。分别的意思是：用整数二分查找的方法，在单调性数组中，找出第一个>=某个数的位置，最后一个<=某个数的位置。



#### 模板

- l和r，不管是lower还是upper，其初始化的方法都是完全一致的，while循环的条件也是完全一致的，if后面的赋值l或r=mid也是完全一致的。
- 两种模板的区别是：mid的初始化值不一样，以及else后的赋值不一样，if条件不一样，其他是完全一样的。
- 如果是lower模板，那么肯定是偏向让答案存在的区间往左边走，所以会去让r=mid,并且if的写法是`x<=q[mid]`(这样才能保证答案区间往左边移动)；如果是upper模板，肯定倾向于让答案存在的区间往右边走，也就是让l=mid，if写法同理。
- if-else的对称性：如果if后是l，那么else后就是r。反之同理。
- 最后都`return l`即可。
- 注意，mid是在while中被确定的，而不是一开始初始化来的。
- 注意，两个if的条件都带等号。
- 注意，确定mid的时候可以先粗暴地写`l+r>>1`，到后面再判断。如果r是mid，则l是mid+1`l+r>>1`，mid是；否则如果l是mid，那么r是mid-1,mid是`l+r+1>>1`；

```c++
//q:查询数组，x：查询目标，n：数组长度
int lower_bound(int* q,int x,int n){
    int l=0,r=n-1;
    while(l<r){
        int mid=l+r>>1;
        if(q[mid]>=x)r=mid;
        else l=mid+1;
    }
    return l;
}
```

```c++
//q:查询数组，x：查询目标，n：数组长度
int upper_bound(int* q,int x,int n){
    int l=0,r=n-1;
    while(l<r){
        int mid=l+r+1>>1;
        if(q[mid]<=x)l=mid;
        else r=mid-1;
    }
    return l;
}
```



#### 练习

[Start 🕹](https://www.acwing.com/problem/content/791/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int q[N];

//q:查询数组，x：查询目标，n：数组长度
int lower_bound(int* q,int x,int n){
    //TODO
}

//q:查询数组，x：查询目标，n：数组长度
int upper_bound(int* q,int x,int n){
	//TODO
}

int main(){
    // freopen("a.in","r",stdin);
	// freopen("a.out", "w", stdout);
    int n,m;
    cin>>n>>m;
    for(int i=0;i<=n-1;i++)cin>>q[i];

    while(m--){
        int x;
        cin>>x;
        int ind=lower_bound(q,x,n);
        if(q[ind]!=x)cout<<-1<<' '<<-1<<endl;
        else {
            cout<<ind<<' ';
            ind=upper_bound(q,x,n);
            cout<<ind<<endl;
        }
    }
}
```



