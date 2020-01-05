---
title: Rush to Amazon 8
date: 2020-01-05 14:00:45
tags: [Amazon]
---

### 99. Recover Binary Search Tree
```
class Solution {
    TreeNode x = null, y = null, pred = null;
    
    public void recoverTree(TreeNode root) {
        
        findTwoSwapped(root);
        swap(x, y);
    }
    public void swap(TreeNode a, TreeNode b){
        int tmp = a.val;
        a.val = b.val;
        b.val = tmp;
    }
    
    public void findTwoSwapped(TreeNode root){
        if (root == null) return;
        findTwoSwapped(root.left);
        if (pred != null && root.val < pred.val){
           y = root;
           if (x == null) x = pred;
            else return;
        }
        pred = root;
        findTwoSwapped(root.right);
    }
    
}
```
<!-- more -->
Using inorder recursion to find the two swapped node, then swap.

### 980. Unique Paths III
```
 int res = 0, empty = 1, sx, sy, ex, ey;
    public int uniquePathsIII(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) empty++;
                else if (grid[i][j] == 1) {
                    sx = i;
                    sy = j;
                } else if (grid[i][j] == 2) {
                    ex = i;
                    ey = j;
                }
            }
        }
        dfs(grid, sx, sy);
        return res;
    }

    public void dfs(int[][] grid, int x, int y) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] < 0)
            return;
        if (x == ex && y == ey) {
            if (empty == 0) res++;
            return;
        }
        grid[x][y] = -2;
        empty--;
        dfs(grid, x + 1, y);
        dfs(grid, x - 1, y);
        dfs(grid, x, y + 1);
        dfs(grid, x, y - 1);
        grid[x][y] = 0;
        empty++;
    }
```
using brute force dfs.

### 545. Boundary of Binary Tree
```
List<Integer> nodes = new ArrayList<>(1000);
public List<Integer> boundaryOfBinaryTree(TreeNode root) {
    
    if(root == null) return nodes;

    nodes.add(root.val);
    leftBoundary(root.left);
    leaves(root.left);
    leaves(root.right);
    rightBoundary(root.right);
    
    return nodes;
}
public void leftBoundary(TreeNode root) {
    if(root == null || (root.left == null && root.right == null)) return;
    nodes.add(root.val);
    if(root.left == null) leftBoundary(root.right);
    else leftBoundary(root.left);
}
public void rightBoundary(TreeNode root) {
    if(root == null || (root.right == null && root.left == null)) return;
    if(root.right == null)rightBoundary(root.left);
    else rightBoundary(root.right);
    nodes.add(root.val); // add after child visit(reverse)
}
public void leaves(TreeNode root) {
    if(root == null) return;
    if(root.left == null && root.right == null) {
        nodes.add(root.val);
        return;
    }
    leaves(root.left);
    leaves(root.right);
}
```


### 1167. Minimum Cost to Connect Sticks
```
//min-heap
  public int connectSticks(int[] sticks) {
        int res = 0;
        //add all elements to the min heap
        PriorityQueue<Integer> pq = new PriorityQueue();
        for (int s : sticks)
            pq.add(s);
        
        //iterate over all elements in the heap
        while (pq.size() > 1) {
            int cost = pq.poll() + pq.poll();
            res += cost;
            pq.add(cost);
        }
        
        return res;
    }

//
class Solution {
     int left = 0, right = 0, numSticks, numResults = 0, num;
    // Gets the minimum from InputSet and ResultSet
    private boolean getMin(int[] sticks) {
        // check if there are numbers available from InputSet and ResultSet
        boolean f = right < numSticks, s = left < numResults;
        // If number is available from both sets, choose the smallest
        if (f && s) num = (sticks[left] <= sticks[right]) ? sticks[left++] : sticks[right++];
        // If number is available from InputSet only
        else if (f) num = sticks[right++];
        // If number is available from ResultSet only
        else if (s) num = sticks[left++];
        return f || s; // Returns result saying if we could find a number from any one of the Sets.
    }
    
    public int connectSticks(int[] sticks) {
        numSticks = sticks.length;
        Arrays.sort(sticks); // Initial sort
        int result = 0, first, second; // Result and place holders to get the smallest two numbers.
        // Continue till you can get two numbers every time from the Sets.
        while (true) {
            if (!getMin(sticks)) break;
            first = num;
            if (!getMin(sticks)) break;
            second = num;
            result += sticks[numResults++] = first + second; // Store the sum back in the ResultSet
        }
        return result;
    }
}
```
using the min heap.


###
```
 public int mergeStones(int[] stones, int K) {
        int n = stones.length;
        if((n - 1) % (K - 1) != 0)  return -1;
        int[][] f = new int[n][n];
        int[] pre = new int[n + 1];
        for(int i = 1; i <= n; i++){
            pre[i] = pre[i - 1] + stones[i - 1];
        }
       
        return search(0, n - 1, f, pre, K);
    }
    private int search(int x, int y, int[][] f, int[] pre, int K){
        int len = y - x + 1;
        if(len < K) return 0;
        if(f[x][y] != 0)   return f[x][y];
        f[x][y] = Integer.MAX_VALUE;
        for(int mid = x; mid < y; mid += K - 1){
            f[x][y] = Math.min(f[x][y], search(x, mid, f, pre, K) + search(mid + 1, y, f, pre, K));
        }
        if((y - x) % (K - 1) == 0)  f[x][y] += pre[y + 1] - pre[x];
        return f[x][y];
    }
```
using recursion dp.
increase the speed.