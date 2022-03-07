# 高精度乘法

#### 思想

- 对于乘法，只要求一个大数和一个很小的数进行乘法。算法中记作A、b。前者用字符串存储，后者用`int`即可。
- 注意，这里的t只需要一步就完全确定。不需要像之前那样拆成两步，因为b不需要判断位数。
- 而且注意，这里里面的if是对A的长度进行判断了。因为存在A的位数用完了，但是还需要处理高位进位的情况。这里要和加法减法区分开，因为加法减法是对B的长度进行判断的。

#### 模板

```c++
vector<int> mul(vector<int>& A,int& b){
    
    int t=0;vector<int> C;
    
    for(int i=0;i<A.size()||t;i++){//这里“||t”是为了考虑最高位进位
        if(i<A.size())t+=A[i]*b;
        C.push_back(t%10);//取本位或进位的方法和加法一致
        t/=10;
    }

    //例如123*0，如果不消除前导0，就是000。WA。
    while(C.back()==0&&C.size()>1)C.pop_back();

    return C;
}
```

#### 练习

[Start 🕹](https://www.acwing.com/problem/content/795/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int q[N];

vector<int> mul(vector<int>& A,int& b){
    //TODO
}

int main(){
    // freopen("a.in","r",stdin);
    // freopen("a.out", "w", stdout);
    string a;
    int b;
    vector<int> A;
    cin>>a>>b;
    for(auto ite=a.rbegin();ite!=a.rend();ite++)A.push_back(*ite-'0');

    auto C=mul(A,b);

    for(auto ite=C.rbegin();ite!=C.rend();ite++)cout<<*ite;

    cout<<endl;
}

```

## 