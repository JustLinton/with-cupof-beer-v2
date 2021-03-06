# 字符串哈希

!!! beer-tips "浅记" 
    字符串哈希可以把一个字符串的任意子串算出其哈希值，从而通过比对哈希值是否相等，达到字符串比对的目的。

#### 哈希
- 这里的哈希函数是取模哈希。根据经验，这个模是$2^{64}$.也就是`unsigned long long`的取值范围。因此我们在进行哈希的时候，不需要取模了，因为溢出就相当于自动取模了。

#### 思想
- 给定一个字符串，把它看做是一个p进制的数字，然后把这个数字转换成10进制，然后取模$2^{64}$，就是其哈希值了。一般情况下，p取131或13331都是可以的。
- 为什么我们规定这个经验值？因为可以最大限度避免哈希冲突。**我们这个算法是建立在不会出现哈希冲突的前提下的，否则只要出现哈希冲突就会出错**。根据经验，这组p和模数的取值可以把哈希冲突几率降低到0.01%以下，做题是够用了。
!!! beer-tips inline end "浅记" 
    注意，给字符编码一定要从1开始，不能编码0.否则，例如给A编码0，就会导致对于A和AA、AAA等字符串，转换成0，从而引起哈希冲突。于是算法出错。因为我们错误地认为本不相等的两个字符串相等。（因为哈希值相等。）

- 例如给定ABCD字符串，我们可以编码为$(1234)_p$,转换成十进制就是$1\times p^3+2 \times p^2 + 3 \times p^1 + 4 \times p ^0$，并且因为我们使用自动溢出，这个过程不需要取模。
- 接下来可以给输入的字符串的任意前缀进行求哈希，例如对于字符串ABCDEF，应当求ABCDE、ABCD、ABC、AB、A的哈希。
- 之后，如果我们需要获得该字符串的任意子串的哈希，例如从下标l到下标r的子串，那么只需要对`[0,l-1],[0,r]`这两个前缀进行操作。**注意是l-1，这个和前缀和是一个道理。** 具体做法是先让`[0,l-1]`子串在p进制下左移`r-l+1`位，于是就可以与`[0,r]`对齐了，然后让后者减去前者，即可得到中间这段 `[l,r]`子串的字符串哈希值。之后，我们要进行子串比对，只需要比对哈希值即可。