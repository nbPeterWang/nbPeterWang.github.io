---
title: Everyday Leetcode 6
date: 2019-05-05 12:57:24
tags: [Leetcode]
---
### 128	Longest Consecutive Sequence
```
public int longestConsecutive(int[] nums) {
        int res = 0;
        Set<Integer> s = new HashSet<Integer>();
        for (int num : nums) s.add(num);
        for (int num : nums) {
            if (s.remove(num)) {
                int pre = num - 1, next = num + 1;
                while (s.remove(pre)) --pre;
                while (s.remove(next)) ++next;
                res = Math.max(res, next - pre - 1);
            }
        }
        return res;
    }
```
首先都加入到hashset中，遍历nums，如果有，则remove，然后一个个remove前一个和后一个数，得出最大序列长度。
<!-- more-->
### 164	Maximum Gap
```
//我的做法，先排序。 faster than 37.82%，less than 85.87%。
 public int maximumGap(int[] nums) {
        if(nums.length<2||nums==null) return 0;
        int res=0;
        Arrays.sort(nums);
         if(nums.length==2)return nums[1]-nums[0];
        for(int i=0;i<=nums.length-2;i++){
        res=Math.max(res,nums[i+1]-nums[i]);
        }
        return res;
    }
//桶排序
public int maximumGap(int[] nums){
   if (num == null || num.length < 2)
        return 0;
    // get the max and min value of the array
    int min = num[0];
    int max = num[0];
    for (int i:num) {
        min = Math.min(min, i);
        max = Math.max(max, i);
    }
    // the minimum possibale gap, ceiling of the integer division
    int gap = (int)Math.ceil((double)(max - min)/(num.length - 1));
    int[] bucketsMIN = new int[num.length - 1]; // store the min value in that bucket
    int[] bucketsMAX = new int[num.length - 1]; // store the max value in that bucket
    Arrays.fill(bucketsMIN, Integer.MAX_VALUE);
    Arrays.fill(bucketsMAX, Integer.MIN_VALUE);
    // put numbers into buckets
    for (int i:num) {
        if (i == min || i == max)
            continue;
        int idx = (i - min) / gap; // index of the right position in the buckets
        bucketsMIN[idx] = Math.min(i, bucketsMIN[idx]);
        bucketsMAX[idx] = Math.max(i, bucketsMAX[idx]);
    }
    // scan the buckets for the max gap
    int maxGap = Integer.MIN_VALUE;
    int previous = min;
    for (int i = 0; i < num.length - 1; i++) {
        if (bucketsMIN[i] == Integer.MAX_VALUE && bucketsMAX[i] == Integer.MIN_VALUE)
            // empty bucket
            continue;
        // min value minus the previous value is the current gap
        maxGap = Math.max(maxGap, bucketsMIN[i] - previous);
        // update previous bucket value
        previous = bucketsMAX[i];
    }
    maxGap = Math.max(maxGap, max - previous); // updata the final max value gap
    return maxGap;
}
```
首先进行桶排序，然后遍历桶，算出并记录最大的gap，returnmaxGap。

### 287	Find the Duplicate Number
```
//我的解法，比较朴素。
 public int findDuplicate(int[] nums) {
        if(nums==null||nums.length<1) return 0;
        if(nums.length==2) return nums[0];
        Arrays.sort(nums);
        for(int i=0;i<nums.length-1;i++)
        {
            if (nums[i]==nums[i+1]) return nums[i];
        }
        return 0;
    }
//击败100%解法。
 public int findDuplicate(int[] nums) {
        if (nums.length > 1){
		int slow = nums[0];
		int fast = nums[nums[0]];
		while (slow != fast){
			slow = nums[slow];
			fast = nums[nums[fast]];
		}

		fast = 0;
		while (fast != slow){
			fast = nums[fast];
			slow = nums[slow];
		}
		return slow;
	}
	return -1;
}
```
使用两个指针，fast每次走两步，slow每次走一步，fast==slow时说明在环中，只要找到环的起始位置，此时fast为0,同步搜索。再次相等时就是答案。

### 4	Median of Two Sorted Arrays
```
 public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        int m = nums1.length, n = nums2.length, left = (m + n + 1) / 2, right = (m + n + 2) / 2;
        return (findKth(nums1, nums2, left) + findKth(nums1, nums2, right)) / 2.0;
    }
    int findKth(int[] nums1, int[] nums2, int k) {
        int m = nums1.length, n = nums2.length;
        if (m == 0) return nums2[k - 1];
        if (n == 0) return nums1[k - 1];
        if (k == 1) return Math.min(nums1[0], nums2[0]);
        int i = Math.min(m, k / 2), j = Math.min(n, k / 2);
        if (nums1[i - 1] > nums2[j - 1]) {
            return findKth(nums1, Arrays.copyOfRange(nums2, j, n), k - j);
        } else {
            return findKth(Arrays.copyOfRange(nums1, i, m), nums2, k - i);
        }
    }
  
```
首先我们要判断数组是否为空，为空的话，直接在另一个数组找第K个即可。还有一种情况是当 K = 1 时，表示我们要找第一个元素，只要比较两个数组的第一个元素，返回较小的那个即可。这里我们分别取出两个数组的第 K/2 个数字的位置坐标i和j，为了避免数组没有第 K/2 个数组的情况，我们每次都和数组长度做比较，取出较小值。

### 289	Game of Life
```
public void gameOfLife(int[][] board) {
    if (board == null || board.length == 0) return;
    int m = board.length, n = board[0].length;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int lives = liveNeighbors(board, m, n, i, j);

            // In the beginning, every 2nd bit is 0;
            // So we only need to care about when will the 2nd bit become 1.
            if (board[i][j] == 1 && lives >= 2 && lives <= 3) {  
                board[i][j] = 3; // Make the 2nd bit 1: 01 ---> 11
            }
            if (board[i][j] == 0 && lives == 3) {
                board[i][j] = 2; // Make the 2nd bit 1: 00 ---> 10
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            board[i][j] >>= 1;  // Get the 2nd state.
        }
    }
}

public int liveNeighbors(int[][] board, int m, int n, int i, int j) {
    int lives = 0;
    for (int x = Math.max(i - 1, 0); x <= Math.min(i + 1, m - 1); x++) {
        for (int y = Math.max(j - 1, 0); y <= Math.min(j + 1, n - 1); y++) {
            lives += board[x][y] & 1;
        }
    }
    lives -= board[i][j] & 1;
    return lives;
}
```
用1234纪录状态，>>1 来获得最终状态。 liveNeighbors统计周边活着的邻居。

### 57	Insert Interval
```
public int[][] insert(int[][] intervals, int[] newInterval) {
        // Time : O(n) Space : O(n)
        if(newInterval == null) return intervals;
        int[][] list = new int[intervals.length + 1][2];
        int i = 0;
        int idx = 0;
        while(i < intervals.length && intervals[i][1] < newInterval[0]) {
            list[idx][0] = intervals[i][0];
            list[idx++][1] = intervals[i++][1];
        }
        while(i < intervals.length && intervals[i][0] <= newInterval[1]) {
            newInterval[0] = Math.min(newInterval[0], intervals[i][0]);
            newInterval[1] = Math.max(newInterval[1], intervals[i++][1]);
        }
        list[idx][0] = newInterval[0];
        list[idx++][1] = newInterval[1];
        while(i < intervals.length) {
            list[idx][0] = intervals[i][0];
            list[idx++][1] = intervals[i++][1];
        }
        int[][] res = new int[idx][2];
        for(int j = 0; j < idx; j++) {
            res[j][0] = list[j][0];
            res[j][1] = list[j][1];
        }
        return res;
    }
```
首先如果原来的interval的第i个数对的第2个数小于newInterval的第一个数，说明不重叠，直接加入新的list。如果原来的interval的第i个数对的第1个数小于等于newInterval的第二个数，说明重叠，将两边的最小和最大值记录到newinterval。然后插入list。最后将interval剩下的值都插入list，再将list的前idx个数对取出，就是答案。

### 56	Merge Intervals
```
public int[][] merge(int[][] intervals) {
        List<int[]> arr = new ArrayList<>();
        Arrays.sort(intervals, new Comparator<int[]>(){
            @Override
            public int compare(int[] a, int[] b){
                return a[0] - b[0];
            }
        });
        for(int i = 0; i < intervals.length;i++){
            int[] interval = new int[2];
            interval[0] = intervals[i][0];
            int max = intervals[i][1];
            while(i < intervals.length-1 && max >= intervals[i+1][0]){
                max = Math.max(max, intervals[i+1][1]);
                i=i+1;
            }
            interval[1] = max;
            arr.add(interval);
        }
        int[][] answer = new int[arr.size()][2];
        for(int i = 0; i < arr.size(); i++){
            answer[i] = arr.get(i);
        }
        return answer;
    }
```
重写了compare方法，返回第一个数相减的结果。然后将intervals排序，遍历每个数对，记录最大值max，实现把重叠的merge的操作，将每个数对加入arr。

### 252	Meeting Rooms
```
//被锁只能找C++解法
bool canAttendMeetings(vector<Interval>& intervals) {
        sort(intervals.begin(), intervals.end(), [](const Interval &a, const Interval &b){return a.start < b.start;});
        for (int i = 1; i < intervals.size(); ++i) {
            if (intervals[i].start < intervals[i - 1].end) {
                return false;
            }
        }
        return true;
    }
```
先排序，如果区间的开始小于前一个区间的结束说明重叠。

### 253	Meeting Rooms II
```
//被锁只能找C++解法
int minMeetingRooms(vector<Interval>& intervals) {
        map<int, int> m;
        for (auto a : intervals) {
            ++m[a.start];
            --m[a.end];
        }
        int rooms = 0, res = 0;
        for (auto it : m) {
            res = max(res, rooms += it.second);
        }
        return res;
    }
```
遍历时间区间，对于起始时间，映射值自增1，对于结束时间，映射值自减1，然后定义结果变量 res，和房间数 rooms，遍历 TreeMap，时间从小到大，房间数每次加上映射值，然后更新结果 res，遇到起始时间，映射是正数，则房间数会增加，如果一个时间是一个会议的结束时间，也是另一个会议的开始时间，则映射值先减后加仍为0，并不用分配新的房间，而结束时间的映射值为负数更不会增加房间数。

### 352	Data Stream as Disjoint Intervals
```
//老题目用Interval时
class SummaryRanges {

    /** Initialize your data structure here. */
     Map<Integer, Interval> smap;
    Map<Integer, Interval> emap;
    Set<Integer> added;

    public SummaryRanges() {
        smap = new TreeMap<>();
        emap = new TreeMap<>();
        added = new HashSet<>();
    }
    
    public void addNum(int val) {
        
        if(added.contains(val)) return;
        added.add(val);
        
        Interval s = smap.get(val+1);
        Interval e = emap.get(val-1);
        
        smap.remove(val+1);
        emap.remove(val-1);
 
        Interval n = new Interval(e!=null?e.start:val, s!=null?s.end:val);
        smap.put(n.start, n);
        emap.put(n.end, n);
    }
    
    public List<Interval> getIntervals() {
        return new ArrayList<>(smap.values());
    }
}
//新题目用int[][]时
class SummaryRanges {
    
    List<int[]> intervals;

    /** Initialize your data structure here. */
    public SummaryRanges() {
        intervals = new ArrayList<>();
    }
    
    public void addNum(int val) {
        boolean find = false;
        for (int[] interval : intervals) {
            if (val == interval[0] - 1) {
                interval[0] = val;
                find = true;
            } else if (val == interval[1] + 1) {
                interval[1] = val;
                find = true;
            }
        }
        if (!find) {
            int[] tmp = new int[2];
            tmp[0] = val;
            tmp[1] = val;
            intervals.add(tmp);
        }
    }
    
    public int[][] getIntervals() {
        Collections.sort(intervals, (a, b) -> {
            if (a[0] == b[0]) {
                return a[1] - b[1];
            } else {
                return a[0] - b[0];
            }
        });
        //merge
        List<int[]> merged = new ArrayList<>();
        int[] prev = null;
        for (int[] cur : intervals) {
            if (prev == null || cur[0] > prev[1] + 1) {
                merged.add(cur);
                prev = cur;
            } else if (cur[1] > prev[1]) {
                prev[1] = cur[1];
            }
        }
        intervals = merged;
        int[][] res = new int[merged.size()][2];
        for (int i = 0; i < merged.size(); i++) {
            res[i] = merged.get(i);
        }
        return res;
    }
}
```
当addNum时， 先从startmap和endmap里面尝试get，如果有就用原来的start/end值作为新的区间，没有就用val作为新的区间并put进smap和emap。新题目思想一样，多了在getInterval中 merg等等过程，如果cur[0]大于前一个的end+1或者前一个为null则直接add，否则前一个的end为现在的end。
