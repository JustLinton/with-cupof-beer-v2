# 高精度加法

#### 模板

- 注意输入数据的时候不要忘记`-'0'`.
- add方法默认A的位数比B多，所以一开始判断他们的位数情况。如果不满足A位数比B的多，就要倒过来。这样可以杜绝特殊处理，非常聪明。（这么做的原因是：下面按十进制位进行运算的时候，那个for里面是用的`A.size()`.）
- t在本位运算中代表本位和，在上一位切换到下一位运算的过程中代表进位。前者可取任意0-9，后者可取0-1

```c++
vector<int> add(vector<int>&A,vector<int>&B){
    //add方法默认A的位数比B多，这样就不需要特殊处理了
    if(A.size()<B.size())return add(B,A);
    
    vector<int> C;
    int t=0;
    for(int i=0;i<A.size();i++){
        t+=A[i];//我们要做的是t+=A[i]+B[i]
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


