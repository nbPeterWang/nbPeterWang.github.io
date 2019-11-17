---
title: Everyday Leetcode 24
date: 2019-10-19 14:40:12
tags: [Leetcode]
---
### 100	Same Tree		
```
 public boolean isSameTree(TreeNode p, TreeNode q) {
         if (p == null || q == null) return p == q;
    return p.val == q.val && isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
    }
```
<!-- more -->
recursion way, easy.

### 101	Symmetric Tree	
```
 public boolean isSymmetric(TreeNode root) {
        if(root==null) return true;
        return isMirror(root, root);
    }
     
    public boolean isMirror(TreeNode l, TreeNode r) {
        if (l==null || r==null) return l==r;
        return (l.val==r.val) && isMirror(l.left,r.right) && isMirror(l.right,r.left);
    }

   public boolean isSymmetric(TreeNode root) {
    if (root == null) return true;
    Stack<TreeNode> stack = new Stack<>();
    stack.push(root.left);
    stack.push(root.right);
    while (!stack.empty()) {
        TreeNode n1 = stack.pop(), n2 = stack.pop();
        if (n1 == null && n2 == null) continue;
        if (n1 == null || n2 == null || n1.val != n2.val) return false;
        stack.push(n1.left);
        stack.push(n2.right);
        stack.push(n1.right);
        stack.push(n2.left);
    }
    return true;
}
```
   Recursion way is easy. For iteration, I use stack.

### 226	Invert Binary Tree	
```
  public TreeNode invertTree(TreeNode root) {
        if(root == null) return root;
        invertTree(root.left);
        invertTree(root.right);
        TreeNode temp =root.left;
        root.left=root.right;
        root.right=temp;
        return root;
    }

    public TreeNode invertTree(TreeNode root) {
         if (root == null) return null;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while(!queue.isEmpty()) {
             TreeNode node = queue.poll();
             TreeNode left = node.left;
            node.left = node.right;
            node.right = left;

            if(node.left != null) {
                queue.offer(node.left);
            }
            if(node.right != null) {
                queue.offer(node.right);
            }
        }
        return root;
    
    }
```
Recursion way is easy. For iteration, I use queue.

### 257	Binary Tree Paths	
```
  public List<String> binaryTreePaths(TreeNode root) {
        List<String> res = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        helper(res, root, sb);
        return res;
    }
    
    private void helper(List<String> res, TreeNode root, StringBuilder sb) {
        if(root == null) {
            return;
        }
        int len = sb.length();
        sb.append(root.val);
        if(root.left == null && root.right == null) {
            res.add(sb.toString());
        } else {
            sb.append("->");
            helper(res, root.left, sb);
            helper(res, root.right, sb);
        }
        sb.setLength(len);
    }
```
Track of the length of the StringBuilder before we append anything to it before recursion and afterwards set the length back.

### 112	Path Sum
```
 public boolean hasPathSum(TreeNode root, int sum) {
         if(root == null) return false;

        if(root.left == null && root.right == null) return sum == root.val;

        return hasPathSum(root.left, sum - root.val) || hasPathSum(root.right, sum - root.val);
    }
```

Rucursion way is easy. Just try to use  sum-root.val to  get the PathSum.