---
title: Everyday Leetcode 7
date: 2019-05-06 19:02:15
tags: [Leetcode]
---
### 239	Sliding Window Maximum
```
public int[] maxSlidingWindow(int[] a, int k) {		
		if (a == null || k <= 0) {
			return new int[0];
		}
		int n = a.length;
		int[] r = new int[n-k+1];
		int ri = 0;
		// store index
		Deque<Integer> q = new ArrayDeque<>();
		for (int i = 0; i < a.length; i++) {
			// remove numbers out of range k
			while (!q.isEmpty() && q.peek() < i - k + 1) {
				q.poll();
			}
			// remove smaller numbers in k range as they are useless
			while (!q.isEmpty() && a[q.peekLast()] < a[i]) {
				q.pollLast();
			}
			// q contains index... r contains content
			q.offer(i);
			if (i >= k - 1) {
				r[ri++] = a[q.peek()];
			}
		}
		return r;
	}
```
这题用到了不熟悉的数据结构Deque，用q保存整个数组的下标遍历整个数组，如果此时队列的首元素是i - k的话，表示此时窗口向右移了一步，则移除队首元素。然后比较队尾元素和将要进来的值，如果小的话就都移除，然后此时我们把队首元素加入结果中即可。
<!-- more -->
### 295	Find Median from Data Stream
```
class MedianFinder {

    /** initialize your data structure here. */
   

    private Queue<Long> small = new PriorityQueue(),
                        large = new PriorityQueue();

    public void addNum(int num) {
        large.add((long) num);
        small.add(-large.poll());
        if (large.size() < small.size())
            large.add(-small.poll());
    }

    public double findMedian() {
        return large.size() > small.size()
               ? large.peek()
               : (large.peek() - small.peek()) / 2.0;
    }

}
```
这题用了两个PriorityQueue，分别记录数组的两端，始终保持large数量大于等于small，此时中位数要么是large.peek，要么是large与small头部元素的差/2。

### 53	Maximum Subarray
```
  public int maxSubArray(int[] nums) {
        int res=Integer.MIN_VALUE;
        if (nums==null||nums.length<1) return 0;
        if (nums.length==1) return nums[0];
        for(int i=1;i<nums.length;i++){
            if (nums[i-1]>0)
                nums[i]+=nums[i-1];
        }
        for(int j:nums){
            res= Math.max(res,j);
        }
        return res;
    }
```
注意边界情况。

### 325	Maximum Size Subarray Sum Equals k
```
class Solution {
public:
    int maxSubArrayLen(vector<int>& nums, int k) {
        int sum = 0, res = 0;
        unordered_map<int, int> m;
        for (int i = 0; i < nums.size(); ++i) {
            sum += nums[i];
            if (sum == k) res = i + 1;
            else if (m.count(sum - k)) res = max(res, i - m[sum - k]);
            if (!m.count(sum)) m[sum] = i;
        }
        return res;
    }
};
```
用一个变量sum边累加边处理，只要保存第一个出现该累积和的位置，后面再出现直接跳过，这样算下来就是最长的子数组。

### 209	Minimum Size Subarray Sum
```
//O（n）做法
 public int minSubArrayLen(int s, int[] nums) {
        int i = 0, j = 0, sum = 0, min = Integer.MAX_VALUE;
        while (j < nums.length) {
            while (sum < s && j < nums.length) sum += nums[j++];
            if(sum>=s){
                while (sum >= s && i < j) sum -= nums[i++];
                min = Math.min(min, j - i + 1);
            }
        }
        return min == Integer.MAX_VALUE ? 0 : min;
    }
//O（nlogn）做法
public int minSubArrayLen(int s, int[] nums) {
        int i = 1, j = nums.length, min = 0;
        while (i <= j) {
            int mid = (i + j) / 2;
            if (windowExist(mid, nums, s)) {
                j = mid - 1;
                min = mid;
            } else i = mid + 1;
        }
        return min;
    }


    private boolean windowExist(int size, int[] nums, int s) {
        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            if (i >= size) sum -= nums[i - size];
            sum += nums[i];
            if (sum >= s) return true;
        }
        return false;
    }
```
首先让 right 向右移，直到子数组和大于等于给定值或者 right 达到数组末尾，此时我们更新最短距离，并且将 left 像右移一位，然后再 sum 中减去移去的值，然后重复上面的步骤，直到 right 到达末尾，且 left 到达临界位置，即要么到达边界，要么再往右移动，和就会小于给定值。 此时即为最小序列。
nlogn，二分，不断查找这段中有没有序列值为s的序列，有则返回true，最后锁定size。