# vector去重

- 一般通过如下方式：首先设vector中有j个不重复元素，注意要先sort，于是unique的作用是将sort后的vector中的去重后的元素放到前j个位置，并且返回下标j的迭代器。于是我们只需要erase这段从j迭代器到vector末尾的区域即可。

```c++
vector<int> alls;
sort(alls.begin(),alls.end());
alls.erase(alls.unique(alls.begin(),alls.end()),alls.end());
```

- 实际上，也可以自己实现`unique()`的功能，这是一个双指针算法，可以对**有序**vector进行类似于stl中的unique操作。注意，根据原理可以看出，返回的迭代器之后的元素是原vector中对应位置的元素，实际上没有发生改变。模板：

```c++
vector<int>::iterator unique(vector<int> alls){
    int j=0;//j用来标定不重复的元素存入的下标
    for(int i=0;i<alls.size();i++){
        if(!i||alls[i]!=alls[i-1])   //!i的意思是i=0就直接打入
            alls[j++]=alls[i];
    }
    return alls.begin()+j;
}
```

