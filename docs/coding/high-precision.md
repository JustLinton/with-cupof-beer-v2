# 高精度

## C++高精度

- 在C++中，没有“大数类”。也就是当数字大到一定程度，需要用特殊方法进行运算，否则溢出。
- 在Python、Java中都有大数类，不会存在这种情况。

#### 高精度是个什么问题

- 设A、B的位数有 106位以上，设b的值<10000。
- 则一般会考察A+B,A−B,A×b,A÷b.

#### 小端存储

- 可以开数组进行存储。用vector会更加方便。
- 例如一个数12345678，那么可以开个大小为8的vector，然后下标0处存8（也就是下标越小，存的位数的次序越小。）或者简言之就是**小端存储**。
- 为什么要小端存储？考虑在运算的过程中需要进位。最后可能会传递到最高位还要进位的话，就要增加一位。如果我们采用静态数组来做这个事情，如果采用大端存储就要让数组整体平移。由于这类问题的数据规模一般是 106位以上的数字（注意是位数，而不是数字的值！），所以每次这样移动一位的时间复杂度非常高！而采用小端存储，直接push_back就完成了高位进位。

## 高精度加法

#### 模板

- 注意输入数据的时候不要忘记`-'0'`.
- add方法默认A的位数比B多，所以一开始判断他们的位数情况。如果不满足A位数比B的多，就要倒过来。这样可以杜绝特殊处理，非常聪明。（这么做的原因是：下面按十进制位进行运算的时候，那个for里面是用的`A.size()`.）

```c++
vector<int> add(vector<int>&A,vector<int>&B){
    //add方法默认A的位数比B多，这样就不需要特殊处理了
    if(A.size()<B.size())return add(B,A);
    
    vector<int> C;
    int t=0;
    for(int i=0;i<A.size();i++){
        t+=A[i];//t=A[i]+B[i]
        if(i<B.size())t+=B[i];
        C.push_back(t%10);//得到C的第i位，也就是模10即可
        t/=10;//得到下一进位。如果t>10，则除10自动得到1.
    }

    //最高位进位
    if(t)C.push_back(t);

    return C;
}
```

#### 练习

[Start 🕹](https://www.acwing.com/problem/content/793/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int q[N];

vector<int> add(vector<int>&A,vector<int>&B){
   //TODO
}

int main(){
    // freopen("a.in","r",stdin);
    // freopen("a.out", "w", stdout);
    string a,b;
    vector<int> A,B;
    cin>>a>>b;
    for(auto ite=a.rbegin();ite!=a.rend();ite++)A.push_back(*ite-'0');
    for(auto ite=b.rbegin();ite!=b.rend();ite++)B.push_back(*ite-'0');
    auto C=add(A,B);
    for(auto ite=C.rbegin();ite!=C.rend();ite++)cout<<*ite;
    cout<<endl;
}

```



## 高精度减法

- 考虑从低位开始做减法，设这一位做完减法，并减去可能存在的借位，得到a（显然可正可负），则当前位做完减法后的结果必然是`(a+10)%10`. （如果a>0，那么就是a本身；如果a<0，那就是10-a。）
- 仍然用t来记录是否有借位。那么可以用a是否大于零来看出是否需要借位。如果都>=0了，说明自给自足，不需要借位。
- 对于给定的两个大数A、B，需要先判断A和B的大小关系，再调用大数减法，从而避免答案为负。因为我们的减法模板无法处理结果为负的情况。具体方式是：

```
if A >= B
then ans = sub(A,B)
else ans = "-" + sub(B,A)
```

#### a,A,0

- a:97,b:65,0:48.

## 
