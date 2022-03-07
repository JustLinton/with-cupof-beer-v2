# 高精度除法

#### 思想

- 注意，每次对新的低位求除法，不是要把高位的余数落下来吗。这个落下来的过程就是高位余数×10。于是，新的需要除的数字就变成了高位余数×10+本位。

#### 模板

- 加、减、乘法模板都是i从0开始增，只有除法是i从size开始降。这样做是为了适配前面说的“小端存储”。因为只有除法是需要从高位往低位算的。
	- 于是，就注意要记得reverse。因为这里是从高位往低位算，所以C是按照从高位到低位的顺序把结果push进去了。显然，这就导致是大端存储。为了适配我们之前定义的规则，需要reverse一下变成小端。
- r的作用是本位被除数，或是余数。和其他高精度类似，分别是本位计算时和跨位计算时，分别代表了这两种不同的意义。
- 一定要注意获取本位除法结果和获取本位余数时，除数是b。因为我们在用C++中除法和取模的定义来做这个操作。而不是取10.

```c++
vector<int> div(vector<int>& A,int& b,int& r){
    //r是余数，用引用的方式传入

    vector<int> C;
    r=0;
    for(int i=A.size()-1;i>=0;i--){
        //注意，加、减、乘法模板都是i从0开始增，只有除法是i从size开始降。
        r=r*10+A[i];//获取本位被除数
        C.push_back(r/b);//获取本位结果
        r%=b;//获取余数（这里就体现了取模运算的意义：取余数。）
    }

    reverse(C.begin(),C.end());
    //去除前导零
    while(C.back()==0&&C.size()>1)C.pop_back();
    return C;
}
```



#### 练习

[Start 🕹](https://www.acwing.com/problem/content/796/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

vector<int> div(vector<int>& A,int& b,int& r){
    //TODO
}

int main(){
    // freopen("a.in","r",stdin);
    // freopen("a.out", "w", stdout);

    string a;
    int b,r=0;
    cin>>a>>b;
    vector<int> A;
    for(auto ite=a.rbegin();ite!=a.rend();ite++)A.push_back(*ite-'0');
    auto C=div(A,b,r);
    for(auto ite=C.rbegin();ite!=C.rend();ite++)cout<<*ite;
    cout<<'\n'<<r<<endl;
}

```

