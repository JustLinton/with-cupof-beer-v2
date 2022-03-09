# STL的那些事

#### deque是翻版的vector
- 两者都支持`push/pop_back/front`，支持随机访问

#### vector的初始化
- 若以`vector(10,3)`初始化，其中的内容就是10个3.这相当于memset的升级版（可以对数据类型长度的连续字节为单位进行初始化了。）
- 这样，我们就不需要用for循环不断push来完成一定大小的vector初始化了。

#### 任何容器都有的函数
- `size`和`empty`是任意容器都有的，并且复杂度都是$O(1)$。
- 某些queue、priority_queue、stack没有`clear`（清空）。这时，可以用例如`q=queue<int>()`的方式新建，相当于清空。

#### 更简单的遍历vector的方法
``` c++ title="范围遍历" hl_lines="0" 
for(auto a:v)cout<<a<<endl;
```

#### vector的比较运算
- vector支持像string那样的按元素比较。
``` c++ title="比较" hl_lines="0" 

vector<int> a(3,4);
vector<int> b(4,3);

if(a<b)cout<<"a<b"<<endl;

//输出：a<b

```

#### pair也是支持比较运算的
- 以`first`为第一关键字，以`second`为第二关键字。
- 于是，pair常用于双关键字排序的需求场景。

#### C++11中，pair的构建
- 除了`make_pair`，还可以：
``` c++ title="" hl_lines="0" 
pair<int,string> p={1,"hello"};
```
- pair可以看做是一个已经重载了比较运算符的有俩成员的结构体。这样就比写结构体方便。

#### string的加法操作
``` c++ title="" hl_lines="0" 
string a="hello";
a+="world";
```

#### 把大根堆变成小根堆的方法
- STL的优先队列默认是大根堆。
- 可以插入相反数，这样就可以反着排序了。
- 或者，可以用如下方式定义这个堆：
``` c++ title="" hl_lines="0" 
priority_queue<int,vector<int>,greater<int>> heap;
```

#### deque慢得令人发指
- 同一个题，用deque会比用vector慢好几倍。

#### set的几个操作
- 如果找不到，就返回`end`迭代器。
- 如果只是想看是否存在，可以`count`。对于multiset，count是可以>1.
- 如果对set进行insert，如果已经存在则忽略这个操作。
- `erase`可以传入数据或迭代器。如果传入数据，就是删除所有这个数据（multiset可能会删除>1个），如果传入迭代器，只删除这一个数据。删除的复杂度是$O(k+log(n))$，其中k是x的个数，n是`size`。

#### set的最重要的操作：lower_bound和upper_bound
- `lower_bound`返回大于等于x的最小的元素的**迭代器**；
- `upper_bound`返回大于x的最小的元素的**迭代器**。

#### map和set在insert和erase上的不同
- map的`insert`要传入`pair`，但是set只需要元素值。
- map的`erase`要传入`pair`或迭代器，但是set只需要元素值或迭代器。

#### map同样支持lower_bound和upper_bound
- 如题。

#### unordered版本和红黑树版本的区别
!!! beer-tips inline end "浅记" 
    unordered版本更快，但是不支持和顺序有关的那俩操作；红黑树虽然慢点，但是支持和顺序有关的那俩操作。

- unordered版本的增删改查都是$O(1)$.但是红黑树的增删改查是log的。红黑树版本的迭代器移动也是log的。
- 但是，unordered版本不支持那两个最重要的lower_bound和upper_bound，不支持迭代器的前后移动（`++`、`--`）
- 除了不支持lower_bound和upper_bound和自增自减外，其他操作都能和红黑树版本一一对应。

#### bitset
- bitset也是一种STL容器。这在之前的程序设计思维与实践课程上并没有学到。
- 它是模板，但是T要求提供一个整数，表示这个bitset有多少位组成。
- 它重载了与位运算相关的一切运算符，包括移位、取反、XOR、AND、OR、等于和不等于。
- 它支持随机访问，利用中括号`[]`可以取出其中的特定位的值。
- 支持`count()`，返回**1的个数**。
- 此外，`any()`判断是否非全0（至少一个1）；`none()`判断是否全是0.
- `set()`把所有位变成1；`set(k,v)`把第k位变成v。
- `reset()`把所有位变成0；
- `flip()`全部取反；`flip(k)`取反第k位；

