---
title: Everyday Leetcode 27
date: 2019-12-16 15:08:42
tags: [Leetcode]
---

### 173	Binary Search Tree Iterator
```
class BSTIterator {

    private Stack<TreeNode> stack = new Stack<TreeNode>();
    
    public BSTIterator(TreeNode root) {
        pushAll(root);
        
    }
    
    /** @return the next smallest number */
    public int next() {
        TreeNode temp = stack.pop();
        pushAll(temp.right);
        return temp.val;
    }
    
    /** @return whether we have a next smallest number */
    public boolean hasNext() {
        return !stack.isEmpty();
    }
    
    public void pushAll(TreeNode root){
        while(root!=null){
            stack.push(root);
            root = root.left;
        }
    }
    
}
```
<!-- more -->
Time complexity (next): average O(1). Using stack.
### 230 Kth Smallest Element in a BST 
```
---- using Stack
class Solution {
    private Stack<TreeNode> stack = new Stack<TreeNode>();
    public int kthSmallest(TreeNode root, int k) {
        helper(root);
        int ans = 0;
        for(int i = 0; i < k; ++i){
            TreeNode temp = stack.pop();
            helper(temp.right);
            ans = temp.val;
        }
        return ans;
        
    }
    public void helper(TreeNode root){
        while(root != null){
            stack.push(root);
            root = root.left;
        }
    }
}

---- DFS inorder recursive
private static int number = 0;
  private static int count = 0;

  public int kthSmallest(TreeNode root, int k) {
      count = k;
      helper(root);
      return number;
  }
  
  public void helper(TreeNode n) {
      if (n.left != null) helper(n.left);
      count--;
      if (count == 0) {
          number = n.val;
          return;
      }
      if (n.right != null) helper(n.right);
  }
```
Time complexity: O(n) using DFS inorder recursive
### 297 Serialize and Deserialize Binary Tree
```
 public String serialize(TreeNode root) {
        return serial(new StringBuilder(), root).toString();
    }
    
    // Generate preorder string
    private StringBuilder serial(StringBuilder str, TreeNode root) {
        if (root == null) return str.append("#");
        str.append(root.val).append(",");
        serial(str, root.left).append(",");
        serial(str, root.right);
        return str;
    }

    public TreeNode deserialize(String data) {
        return deserial(new LinkedList<>(Arrays.asList(data.split(","))));
    }
    
    // Use queue to simplify position move
    private TreeNode deserial(Queue<String> q) {
        String val = q.poll();
        if ("#".equals(val)) return null;
        TreeNode root = new TreeNode(Integer.valueOf(val));
        root.left = deserial(q);
        root.right = deserial(q);
        return root;
    }
```
DFS recursive. Time complexity is O(n);

### 285	Inorder Successor in BST
```
 public TreeNode inorderSuccessor(TreeNode root, TreeNode p) {
  if (root == null)
    return null;

  if (root.val <= p.val) {
    return inorderSuccessor(root.right, p);
  } else {
    TreeNode left = inorderSuccessor(root.left, p);
    return (left != null) ? left : root;
  }
}
```
inorder recursive. Time Complexity: O(h)
### 270	Closest Binary Search Tree Value
```
 public int closestValue(TreeNode root, double target) {
    int ret = root.val;   
    while(root != null){
        if(Math.abs(target - root.val) < Math.abs(target - ret)){
            ret = root.val;
        }      
        root = root.val > target? root.left: root.right;
    }     
    return ret;
    }
```
iterative. Time Complexity:O(h)