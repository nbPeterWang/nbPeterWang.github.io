---
title: Everyday Leetcode 25
date: 2019-10-24 20:08:51
tags: [Leetcode]
---
### 113	Path Sum II	
```
public List<List<Integer>> pathSum(TreeNode root, int sum) {
    List<List<Integer>>ret = new ArrayList<List<Integer>>(); 
    List<Integer> cur = new ArrayList<Integer>(); 
    pathSum(root, sum, cur, ret);
    return ret;
}

public void pathSum(TreeNode root, int sum, List<Integer>cur, List<List<Integer>>ret){
    if (root == null){
        return; 
    }
    cur.add(root.val);
    if (root.left == null && root.right == null && root.val == sum){
        ret.add(new ArrayList(cur));
    }else{
        pathSum(root.left, sum - root.val, cur, ret);
        pathSum(root.right, sum - root.val, cur, ret);
    }
    cur.remove(cur.size()-1);
}
```
<!--more-->
Using ArrayList to save the result, if find pathsum, add to the ret. Test.

### 129	Sum Root to Leaf Numbers	
```
public int sumNumbers(TreeNode root) {
	return sum(root, 0);
}

public int sum(TreeNode n, int s){
	if (n == null) return 0;
	if (n.right == null && n.left == null) return s*10 + n.val;
	return sum(n.left, s*10 + n.val) + sum(n.right, s*10 + n.val);
}
```
Everytime we should return result * 10 plus the value of node, then we do the recursion.


### 298	Binary Tree Longest Consecutive Sequence
```
private int max = 0;
    public int longestConsecutive(TreeNode root) {
        if(root == null) return 0;
        helper(root, 0, root.val);
        return max;
    }
    
    public void helper(TreeNode root, int cur, int target){
        if(root == null) return;
        if(root.val == target) cur++;
        else cur = 1;
        max = Math.max(cur, max);
        helper(root.left, cur, root.val + 1);
        helper(root.right, cur, root.val + 1);
    }
```
using private variable max to save the maximum result of longest Consecutive.

### 111	Minimum Depth of Binary Tree
```
 public static int minDepth(TreeNode root) {
	if (root == null)	return 0;
	if (root.left == null)	return minDepth(root.right) + 1;
	if (root.right == null) return minDepth(root.left) + 1;
	return Math.min(minDepth(root.left),minDepth(root.right)) + 1;
}
```
using DFS.


### 104	Maximum Depth of Binary Tree
```
 public int maxDepth(TreeNode root) {
         return root==null? 0 : Math.max(maxDepth(root.left), maxDepth(root.right))+1;
    }
```
using DFS.
