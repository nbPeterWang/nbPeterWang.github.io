---
title: Rush to Amazon
date: 2019-12-20 18:38:07
tags: [Amazon]
---
Amazon tag leetcode
### 42 Trapping Rain Water
```
class Solution {
    public int trap(int[] A) {
        int a = 0;
        int b = A.length - 1;
        int max = 0;
        int leftmax = 0;
        int rightmax = 0;
        while( a <= b){
            leftmax = Math.max(leftmax, A[a]);
            rightmax = Math.max(rightmax, A[b]);
            if(leftmax < rightmax){
                max += (leftmax - A[a]);
                a++;
            }
            else{
                max += (rightmax - A[b]);
                b--;
            }
        }
        return max;
    }
}
```
For every iteration, just move one of two pointers. If leftmax is less than rightmax, move left pointer. Otherwise, move right pointer. By each move, we can count the rain water at pointer's current column.
<!-- more -->

### 1 two sum
```
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> ans = new HashMap<>();
        for (int i = 0; i < nums.length; ++i){
            int diff = target - nums[i];
                if (ans.containsKey(diff)){
                    return new int[]{ans.get(diff),i};
                }
            ans.put(nums[i],i);
        }
        
        return new int[]{};
    }
```
Using one way hashmap.

### 1192 Critical Connections in a network
```
class Solution {
     public List<List<Integer>> criticalConnections(int n, List<List<Integer>> connections) {
            List<Integer>[] grah = new ArrayList[n];
            for (int i = 0; i < n; i++) grah[i] = new ArrayList<>();
            for (List<Integer> e : connections) {
                int from = e.get(0);
                int to = e.get(1);
                grah[from].add(to);
                grah[to].add(from);
            }
            int[] low = new int[n];
            int[] dfn = new int[n];
            List<List<Integer>> res = new ArrayList<>();
            dfs(dfn, low, 0, -1, grah, res);
            return res;
        }

        int seq = 0;
        void dfs(int[] dfn, int[] low, int cur, int parent, List<Integer>[] graph, List<List<Integer>> res) {
            if (dfn[cur] > 0) return;
            dfn[cur] = ++seq;
            low[cur] = seq;
            for (int neighbour : graph[cur]) {
                if (neighbour == parent) continue;
                if (dfn[neighbour] == 0) dfs(dfn, low, neighbour, cur, graph, res);
                low[cur] = Math.min(low[cur], low[neighbour]);
            }
            if (cur != 0 && low[cur] > dfn[parent]) {
                res.add(Arrays.asList(parent, cur));
            }
        }
}
```
using dfs, Tarjin 's bridge algorithm.

### 200 Number of Islands
```
class Solution {
    private int n,m;
    public int numIslands(char[][] grid) {
        int count = 0;
        n = grid.length;
        if (n == 0) return 0;
        m = grid[0].length;
        for (int i = 0; i < n; ++i){
            for (int j = 0; j < m; ++j)
                if (grid[i][j] == '1') {
                    DFSMarking(grid, i, j);
                    ++count;
                }
        }
        return count;
    }
    private void DFSMarking(char[][] grid, int i, int j){
        if (i < 0 || j<0 || i >= n || j >=m || grid[i][j] != '1') return;
        grid[i][j] = '0';
        DFSMarking(grid, i + 1, j);
        DFSMarking(grid, i - 1, j);
        DFSMarking(grid, i, j + 1);
        DFSMarking(grid, i, j - 1);
    }
}
```
Using DFS, making every "1" into "0", so that we only meet every island once.

### 146 LRU Cache
```
class LRUCache {
    private class Node{
        int key, value;
        Node prev, next;
        Node (int k, int v){
            this.key = k;
            this.value = v;
        }
        Node(){
            this(0, 0);
        }
    }
    private int capacity, count;
    private Map<Integer, Node> map;
    private Node head, tail;
    
    public LRUCache(int capacity) {
        this.capacity = capacity;
        this.count = 0;
        map = new HashMap<>();
        head = new Node();
        tail = new Node();
        head.next = tail;
        tail.prev = head;
    }
    
    public int get(int key) {
        Node n = map.get(key);
        if(n == null){
            return -1;
        }
        update(n);
        return n.value;
    }
    
    public void put(int key, int value){
        Node n = map.get(key);
        if(n == null){
            n = new Node(key, value);
            map.put(key, n);
            add(n);
            ++count;
        }
        else{
            n.value = value;
            update(n);
        }
        if(count > capacity){
            Node toDel = tail.prev;
            remove(toDel);
            map.remove(toDel.key);
            --count;
        }
    }
    
    private void update(Node node){
        remove(node);
        add(node);
    }
    
    private void add(Node node){
        Node after = head.next;
        head.next = node;
        node.prev = head;
        node.next = after;
        after.prev = node;
    }
    
    private void remove(Node node){
        Node before = node.prev, after = node.next;
        before.next = after;
        after.prev = before;
    }
    
}
```
Using hashmap and double linked list.