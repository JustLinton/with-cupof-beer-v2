# 高精度减法

#### 思想

- 考虑从低位开始做减法，设这一位做完减法，并减去可能存在的借位，得到a（显然可正可负），则当前位做完减法后的结果必然是`(a+10)%10`. （如果a>0，那么就是a本身；如果a<0，那就是10-a。）
- 仍然用t来记录是否有借位。那么可以用a是否大于零来看出是否需要借位。如果都>=0了，说明自给自足，不需要借位。
- 对于给定的两个大数A、B，需要先判断A和B的大小关系，再调用大数减法，从而避免答案为负。因为我们的减法模板无法处理结果为负的情况。具体方式是：

```
if A >= B
then ans = sub(A,B)
else ans = "-" + sub(B,A)
```

#### 模板

- t在本位运算中代表本位差，在运算位的切换过程中代表借位。前者可取任意0-9，后者可取0-1。
- 注意，cmp判断的是是否A>=B.所以最后不要忘了`return true`.因为如果二者相等，前面两个return就都不会触发。函数的返回值是未定义的。
- 注意，这里的sub仍然默认A的位数比B的多。因此sub函数中，for循环的结束条件仍然只需要考虑A的长度。

```c++
 //判断是否A>=B
bool cmp(vector<int>& A,vector<int>& B){
   
    //位数不相等，很好判断
    if(A.size()!=B.size())return A.size()>B.size();

    //接下来就是两者的位数相等:逐位比较即可，只要有一位出现了不相等就决出了胜负。
    for(int i=A.size()-1;i>=0;i--)
        if(A[i]!=B[i])
            return A[i]>B[i];

    return true;
}

vector<int> sub(vector<int>&A,vector<int>&B){
    vector<int> C;
    int t=0;
    for(int i=0;i<A.size();i++){
        t=A[i]-t; //本位差=被减数-借位t
        if(i<B.size())t-=B[i]; //然后再减去本位的减数
        C.push_back((t+10)%10); //如果a>0，那么就是a本身；如果a<0，那就是10-a。
        if(t<0)t=1; //手动算出借位（加法的进位可是自动得出的呢。）
        else t=0;
    }

    //因为back代表着高位，所以可以用popback的方式消除前导零
    while(C.size()>1&&C.back()==0)C.pop_back();

    return C;
}
```



#### 练习

[Start 🕹](https://www.acwing.com/problem/content/794/){: .md-button }

```c++
#include <bits/stdc++.h>
using namespace std;

const int N=100010;

int q[N];

 //判断是否A>=B
bool cmp(vector<int>& A,vector<int>& B){
   //TODO
}

vector<int> sub(vector<int>&A,vector<int>&B){
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

    vector<int> C;
    if(cmp(A,B))C=sub(A,B);
    else {
        C=sub(B,A);
        cout<<'-';
    }

    for(auto ite=C.rbegin();ite!=C.rend();ite++)cout<<*ite;
    cout<<endl;
}

```

