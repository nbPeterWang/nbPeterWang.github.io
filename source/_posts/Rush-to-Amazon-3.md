---
title: Rush to Amazon 3
date: 2019-12-28 20:51:31
tags: [Amazon]
---

### 253  Meeting Rooms II
```
// method 1 using min heap
 public int minMeetingRooms(int[][] intervals) {
        if(intervals == null || intervals.length == 0) return 0;
        Arrays.sort(intervals, (a, b) -> (a[0] - b[0]));
        int max = 0;
        PriorityQueue<int[]> queue = new PriorityQueue<>(intervals.length, (a, b) -> (a[1] - b[1]));
        for(int i = 0; i < intervals.length; i++){
            while(!queue.isEmpty() && intervals[i][0] >= queue.peek()[1])
                queue.poll();
            queue.offer(intervals[i]);
            max = Math.max(max, queue.size());
        }
        return max;
    }

//method 2 using two pointer
 public int minMeetingRooms(int[][] intervals) {
        int[]start = new int[intervals.length];   
        int[]end = new int[intervals.length];
        for(int i = 0; i < intervals.length; ++i){
            start[i] = intervals[i][0]; end[i] = intervals[i][1];
        }
        Arrays.sort(start); Arrays.sort(end);
        
        int i = 0; int j = 0; int count = 0; int len = 0;
        while(i < intervals.length && j < intervals.length){
            if(start[i] < end[j]){
               count++;   i++;  
               len = Math.max(len, count);   
            }else{
               j++;  count--;  
            }
        }
        return len;
    } 
```
<!-- more -->
First, sort intervals by their start time. Use a min heap to track the minimum end time of merged intervals. If the start time is right after the end time, poll. Then offer current intervals. Return the maximum queue size.
//method 2
copy the start time and end time, then sort. See if it merge. if merge, increase count. Return the maximum value of count.

### 973 K Closest Points to Origin
```
//method 1 sort
public int[][] kClosest(int[][] points, int K) {
        int N = points.length;
        int[] dists = new int[N];
        for (int i = 0; i < N; ++i)
            dists[i] = dist(points[i]);

        Arrays.sort(dists);
        int distK = dists[K-1];

        int[][] ans = new int[K][2];
        int t = 0;
        for (int i = 0; i < N; ++i)
            if (dist(points[i]) <= distK)
                ans[t++] = points[i];
        return ans;
    }

    public int dist(int[] point) {
        return point[0] * point[0] + point[1] * point[1];
    }
//method 2 quick sort.
public int[][] kClosest(int[][] points, int K) {
    int len =  points.length, l = 0, r = len - 1;
    while (l <= r) {
        int mid = helper(points, l, r);
        if (mid == K) break;
        if (mid < K) {
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }
    return Arrays.copyOfRange(points, 0, K);
}

private int helper(int[][] A, int l, int r) {
    int[] pivot = A[l];
    while (l < r) {
        while (l < r && compare(A[r], pivot) >= 0) r--;
        A[l] = A[r];
        while (l < r && compare(A[l], pivot) <= 0) l++;
        A[r] = A[l];
    }
    A[l] = pivot;
    return l;
}

private int compare(int[] p1, int[] p2) {
    return p1[0] * p1[0] + p1[1] * p1[1] - p2[0] * p2[0] - p2[1] * p2[1];
}
```
method 2 average O(N), worst case O(N^2).

### 49  Group Anagrams
```
public List<List<String>> groupAnagrams(String[] strs) {
    if (strs == null || strs.length == 0) return new ArrayList<List<String>>();
        Map<String, List<String>> map = new HashMap<String, List<String>>();
        for (String s : strs) {
            char[] ca = s.toCharArray();
            Arrays.sort(ca);
            String keyStr = String.valueOf(ca);
            if (!map.containsKey(keyStr)) map.put(keyStr, new ArrayList<String>());
            map.get(keyStr).add(s);
        }
        return new ArrayList<List<String>>(map.values());
    }
```
using hashmap,  sort every string and add it to the map.

### 380  Insert Delete GetRandom O(1)
```
public class RandomizedSet {
	Random random;
	Map<Integer, Integer> map;
	List<Integer> list;
	public RandomizedSet() {
		random = new Random();
		map = new HashMap<>();
		list = new ArrayList<>();
	}

	public boolean insert(int val) {
		if (map.containsKey(val)) return false;
		list.add(val);
		return map.put(val, list.size()-1) == null;
	}

	public boolean remove(int val) {
		if (!map.containsKey(val)) return false;
		Integer position = map.get(val);
		Collections.swap(list, position, list.size() - 1);
		map.put(list.get(position),position);
		list.remove(list.size()-1);
		return map.remove(val) != null;
	}

	public int getRandom() {
		int i = random.nextInt(list.size());
		return list.get(i);
	}
}
```
 ArrayList's remove method is O(n) if you remove from random location. To overcome that, we swap the values between (randomIndex, lastIndex) and always remove the entry from the end of the list. After the swap, you need to update the new index of the swapped value (which was previously at the end of the list) in the map.


### 124  Binary Tree Maximum Path Sum
```
int maxValue;
    
    public int maxPathSum(TreeNode root) {
        maxValue = Integer.MIN_VALUE;
        maxPathDown(root);
        return maxValue;
    }
    
    private int maxPathDown(TreeNode node) {
        if (node == null) return 0;
        int left = Math.max(0, maxPathDown(node.left));
        int right = Math.max(0, maxPathDown(node.right));
        maxValue = Math.max(maxValue, left + right + node.val);
        return Math.max(left, right) + node.val;
    }
```
The second maxValue contains the bigger between the left sub-tree and right sub-tree.
if (left + right + node.val < maxValue ) then the result will not include the parent node which means the maximum path is in the left branch or right branch.