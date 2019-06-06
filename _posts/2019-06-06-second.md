
考虑如下代码，三个大向量结合到第四个向量。

```
parameter max = 1024 * 1024
dimension a(max), b(max), c(max), d(max).
do i = 1, max
  a(i) = b(i) + c(i)d(i)
enddo
```
这四个向量逐个声明，因此他们在内存连续分配。每个向量都是 4MB 大小，1024*1024*4 bytes。因此这四个元素地址的低22位是相同的。向量映射到关联缓存的相同的位置。

为了执行某次计算，a(i), b(i), c(i), and d(i) 必须驻留在主存中，首先对 c(i), and d(i) 执行乘法。他们映射到缓存的相同位置，单两者可以同时驻留，因为缓存是2路组相联。在相同的地址位它可以容下2个cache line。为了执行加法，b(i) 需要在缓存中。它映射到缓存的相同位置，因此含c(i) 的cache line 挪出位置用于存放b(i)，这里假设最近访问的是c(i)。为了存储结果到a(i)，含d(i) 的 cache line 必须被替换。

现在，循环处理到了i+1迭代，含 c(i+1) 的cache line 必须重新载入cache，与因为有两个事实：
1.  c(i+1) 是一个不同于c(i) 的cache line，因此第一次它的 line 必须被载入
2.  c(i+1) 是一个相同于c(i)的cache line，但是已经被替换了在先前的迭代中，

相似的，cache line 含d(i+1) 的也同样需要被重新载入。事实上，每一个对一个向量元素的引用会导致一个cache miss，因为4个中只有两个需要的值可以同时驻留在cache中。尽管访问是一次一步的，没有cache line reuse。

这些行为称为 **cache trashing**，并且它导致非常差的性能。本质上减少了程序无缓存地使用内存。trashing 的原因是因为不合理的向量对准（vector alignment）。他们所有映射到相同的cache 位置。上面程序的对照是特别坏的因为 max 是非常大的会引起 trashing 在主存喻二级缓存。

使用 array padding 防止 trashing

**两种方法防止 cache trashing**
1. 改变向量维度，使得其不再是 2 的平方。一个新的size将溢出内存，因此a(1),b(1),c(1),d(1) 将所有映射到不同的位置是理想的，比如 max = 1024*1024+32 将偏置每一个向量32个元素，或128bytes。这是一个 二级cache line 的大小。因此每个向量开始于一个不同的cache 地址。所有4个值可能同时驻留在cache，因此可能实现 cache line reuse。
2. 对于2维向量。将主维改成奇数是有效的，如 
```
dimension a(1024+1, 1024)
```
对于多维数组，改变两个甚至更多的维数：
```
dimension a(64+1, 64=1, 64)
```
消除cache trashing 使得循环加速至少100倍。
