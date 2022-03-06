# 二分

- 有单调性，则必然可以二分；可以二分，不代表有单调性。
- 二分的意思是，在一个区间内，存在某一点，使得某种性质对于这个点右边的区域是满足的，但是这个点右边的区域是不满足的。
- 只要满足这种“区间中有一个分界点，左边都不满足，右边都满足”的情况，就可以使用二分，把这个分界点找出来。

## 整数二分

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



## 浮点二分

#### 思想

- 浮点二分和整数二分的区别是：不需要区分两种模板的情况。它怎么写都是对的，没有边界问题。
- 结束条件采用l和r之间的距离，也就是eps，来决定。
- 或者也可以更加粗暴，直接for循环若干次。很多题只要循环100次就能得到答案，而且显然不会TLE。因为循环n次，就是让区间长度变成2的-n次方。这样就能看出是否能满足精度要求了。
- 一般情况，eps要比保留的小数位数多2个次方，例如如果保留6位小数，那就是eps要到10的负8.



#### 精度输出

- 如果题目要求保留n位小数的情况，就不要粗暴cout了！
- 可以用printf，这样比cout的iosflag要方便一些：

```c++
printf("%.6lf\n",l);
```



#### 模板

- 这里的例子是要求平方根，所以l和r选取的是数据范围的三次方根可能出现的范围，于是这个范围取了正负的100（因为题目要求正负10000）。
- 这里可以使用二分的原因是：存在这样一个区间分界点，在这个之前不可能出现答案，在这个之后必然会出现答案，这也就是传说中的**二分答案**。
- 可见，浮点二分在`if-else`结构中，确定l和r的方式就非常简单了。不需要+1之类的。
- 最后仍然输出l即可。
- 注意，浮点二分题目，能用double的地方都用double。虽然本题输入整数，但是仍然被输入到了double中。
- 注意，浮点二分不适用r>l作为while条件，而是让他们做差，以落到可接受的误差内。
- 一定要注意mid是在while中计算的，否则死循环。
- 注意，浮点二分不存在upper_bound问题或lower_bound问题。所以它只存在一种模板。换句话说，while中的if不管是>=还是=<都没有关系。
- 注意，if是>=、<=，一定要注意等号的取得。这一点和整数二分是一样的。

```c++
double tri_root(double x){
    double l=-100,r=100;
    while(r-l>1e-8){
        //根据精确度的规则，确定r-l，也就是比保留位数多2
        double mid=(l+r)/2;//注意：浮点数不要再使用移位操作了
        if(mid*mid*mid>=x)r=mid;
        else l=mid;//浮点二分没有这么麻烦
    }
    return l;
}
```



#### 练习

[Start 🕹](https://www.acwing.com/problem/content/792/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=10010;

double tri_root(double x){
    //TODO
}

int main(){
    // freopen("a.in","r",stdin);
    // freopen("a.out", "w", stdout);

    double x;
    cin>>x;
    printf("%.6lf\n",tri_root(x));
}

```

