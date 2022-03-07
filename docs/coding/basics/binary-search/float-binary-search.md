# 浮点二分

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

