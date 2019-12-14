---
title: Everyday Leetcode 26
tags: [Leetcode]
date: 2019-12-02 14:09:08
---
### 110 Balanced Binary Tree
```
class Solution {
    public boolean isBalanced(TreeNode root) {
      if (root == null)
          return true;
      return helper(root)!= -1;
    }
    
    public int helper(TreeNode root){
        if (root == null)
            return 0;
        int left = helper(root.left);
        int right = helper(root.right);
        if( left == -1 || right == -1 || Math.abs(left-right)>1)
            return -1;
        return Math.max(left,right)+1;
    }
}
```
Time complexity:O(n) using DFS
<!-- more -->
### 235 Lowest Common Ancestor of a Binary Search Tree 
```
--- iterative version
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
     if((root == null) || (p == null) || (q == null))  {
         return null;
     } 
     while(true){
        if(root.val > p.val && root.val > q.val){
            root = root.left ;
        }
        else if (root.val < p.val && root.val < q.val){
            root = root.right;
        }
        else 
            return root;
     }
    }
}

--- recursive version
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if((root == null) || (p == null) || (q == null))  {
         return null;
     } 
     while(true){
        if(root.val > p.val && root.val > q.val){
            return lowestCommonAncestor(root.left,p,q);
        }
        else if (root.val < p.val && root.val < q.val){
            return lowestCommonAncestor(root.right,p,q);
        }
        else 
            return root;
     }
    }
}
```
Time Complexity : O(n)
Both uses BST's property to locate LCA. p,q's LCA must be larger than 


### 236 Lowest Common Ancestor of a Binary Tree 
```
class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if (root == null || p == root || q == root) return root;
        TreeNode left = lowestCommonAncestor(root.left, p , q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);
        if(left != null && right != null) return root;
        return left != null ? left: right;
    }
}
```

### 108 Convert Sorted Array to Binary Search tree
```
class Solution {
    public TreeNode sortedArrayToBST(int[] nums) {
        if(nums == null || nums.length == 0) return null;
        return helper(nums, 0, nums.length - 1); 
    }
    
    public TreeNode helper(int[] nums, int low, int high){
        if (low > high) return null;
        
        int mid = low + (high-low)/2;
        
        TreeNode root = new TreeNode(nums[mid]);
        
        root.left = helper(nums, low , mid - 1);
        
        root.right = helper(nums, mid + 1, high);
        
        return root;
        
        
    }
}
```
Time Complexity : O(n).  using low + (high-low)/2 instead of (low+high)/2 to avoid big integer overflow.
Space Complexity : O(logn)

### 109 Convert Sorted List to Binary Search tree
```
class Solution{
    public TreeNode sortedListToBST(ListNode head){
      return helper(head, null);
    }
    
    public TreeNode helper(ListNode head, ListNode tail){
        if (head == null || head == tail) return null;
        if (head.next == tail) return new TreeNode(head.val);
        ListNode fast = head, slow = head;
        while( fast != tail && fast.next != tail){
            fast = fast.next.next;
            slow = slow.next;
        }
        TreeNode root = new TreeNode(slow.val);
        root.left = helper(head, slow);
        root.right = helper(slow.next, tail);
        return root;
    }
}
```
Time Complexity : O(nlogn). 