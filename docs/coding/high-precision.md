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



## 高精度减法

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



## 高精度乘法

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

## 高精度除法

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

