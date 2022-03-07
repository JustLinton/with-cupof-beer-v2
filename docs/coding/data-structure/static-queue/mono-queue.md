# 单调队列

!!! beer-tips "浅记" 
    单调队列的应用场景也非常固定。一般是求滑动窗口的最大值或最小值。

#### 滑动窗口最值问题
- 考虑用一个队列去暴力地做这个问题。则可以用队列来模拟一个滑动窗口，每次窗口移动，都会有一个新元素入队，有一个元素出队，此时队列的`size`就是窗口大小。
- 考虑这种情况，当`a[i]>a[k]`，且`i>k`：
	- 因为`k`排在`i`后面，所以只要`i`在队列中，`k`必然在队列中；`i`快要被弹出去了，`k`还在队列里。因为`k`活的一定比`i`久。
	- 因此，`i`必然永远都没有成为答案的机会。
- 我们删除这样的逆序对，会发现又转化到了单调序列问题。我们维护一个单调的队列，应用这种单调序列的思想即可。
