# 高精度

- 在C++中，没有“大数类”。也就是当数字大到一定程度，需要用特殊方法进行运算，否则溢出。
- 在Python、Java中都有大数类，不会存在这种情况。

#### 高精度是个什么问题

- 设A、B的位数有 $10^6$位以上，设b的值<10000。
- 则一般会考察A+B,A−B,A×b,A÷b.

#### 小端存储

- 可以开数组进行存储。用vector会更加方便。
- 例如一个数12345678，那么可以开个大小为8的vector，然后下标0处存8（也就是下标越小，存的位数的次序越小。）或者简言之就是**小端存储**。
- 为什么要小端存储？考虑在运算的过程中需要进位。最后可能会传递到最高位还要进位的话，就要增加一位。如果我们采用静态数组来做这个事情，如果采用大端存储就要让数组整体平移。由于这类问题的数据规模一般是 106位以上的数字（注意是位数，而不是数字的值！），所以每次这样移动一位的时间复杂度非常高！而采用小端存储，直接push_back就完成了高位进位。
