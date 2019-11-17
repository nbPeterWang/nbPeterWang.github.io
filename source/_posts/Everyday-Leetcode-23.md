---
title: Everyday Leetcode 23
date: 2019-09-10 14:10:31
tags: [Leetcode]
---
### 367	Valid Perfect Square	
```
 public boolean isPerfectSquare(int num) {
        if (num==1) return true;
     else if(num<2) return true;
        else 
     {
            long low=1,high=num;
            long mid,prod;
            while(low<high)
            {
                 mid=(low+high)/2;
                prod=mid*mid;
                if(prod==(long)num) return true;
                else if (prod<(long)num){
                    low=mid+1;
                }else high=mid-1;
            }
            
         if (low==high) return (low*low==(long)num);
        }
        return false;
    }
```
<!-- more -->
基本二分查找
### 365	Water and Jug Problem	
```
public boolean canMeasureWater(int x, int y, int z) {
        if(z == 0) return true;
        if(x + y < z)
            return false;
        return (z%gcd(x, y)==0);
        
    }
    public int gcd(int x, int y){
        if (y==0) return x;
            return gcd(y,x%y);
    }
```
如果x,y的最大公约数能被z整除，则可以。
### 204	Count Primes
```
public int countPrimes(int n) {
        if(n <=1 ) return 0;
    
    boolean[] notPrime = new boolean[n];        
    notPrime[0] = true; 
    notPrime[1] = true; 

    for(int i = 2; i < Math.sqrt(n); i++){
        if(!notPrime[i]){
            for(int j = 2; j*i < n; j++){
                notPrime[i*j] = true; 
            }
        }
    }
    
    int count = 0; 
    for(int i = 2; i< notPrime.length; i++){
        if(!notPrime[i]) count++;
    }
    return count; 
    }
```
using a cache to store the prime count, improve the performance.
### 1	Two Sum	
```
 public int[] twoSum(int[] nums, int target) {
        Map<Integer,Integer> ans= new HashMap<>();
        for (int i=0; i<nums.length;i++){
          int diff=target-nums[i];
              if (ans.containsKey(diff))
              {
                  
                  return new int[]{ans.get(diff),i};
              }
            ans.put(nums[i],i);
          
    }
        return new int[]{};
```
using one-pass hashmap.

### 167	Two Sum II - Input array is sorted
```
public int[] twoSum(int[] numbers, int target) {
      int start = 0, end = numbers.length - 1;
        while(start < end){
            if(numbers[start] + numbers[end] == target) break;
            if(numbers[start] + numbers[end] < target) start++;
            else end--;
        }
        return new int[]{start + 1, end + 1};
    }
```
search from both start and end , using two int as a pointer.

### 15	3Sum
```
 
     Arrays.sort(num);
    List<List<Integer>> res = new LinkedList<>(); 
    for (int i = 0; i < num.length-2; i++) {
        if (i == 0 || (i > 0 && num[i] != num[i-1])) {
            int lo = i+1, hi = num.length-1, sum = 0 - num[i];
            while (lo < hi) {
                if (num[lo] + num[hi] == sum) {
                    res.add(Arrays.asList(num[i], num[lo], num[hi]));
                    while (lo < hi && num[lo] == num[lo+1]) lo++;
                    while (lo < hi && num[hi] == num[hi-1]) hi--;
                    lo++; hi--;
                } else if (num[lo] + num[hi] < sum) {
                    // improve: skip duplicates
                    while (lo < hi && num[lo] == num[lo+1]) lo++;
                    lo++;
                } else {
                    // improve: skip duplicates
                    while (lo < hi && num[hi] == num[hi-1]) hi--;
                    hi--;
                }
            }
        }
    }
    return res;  
```
First, sort the array. Second, using one for loop and a while loop inside the for loop. In the while loop, using high and low to do the 2sum. And using serveral while loops to move the pointers.
### 18	4Sum
```
public List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> res=new LinkedList<>();
        if(nums.length<4) return res;
        Arrays.sort(nums);
        for(int i=0;i<nums.length-3;i++){
            if(i>0&&nums[i]==nums[i-1]) continue;
            
            if(nums[i]*4>target) break;// Too Big!!
            if(nums[i]+3*nums[nums.length-1]<target) continue;//Too Small
            
            for(int j=i+1;j<nums.length-2;j++){
                if(j>i+1&&nums[j]==nums[j-1]) continue;
                
                if(nums[j]*3>target-nums[i]) break;//Too Big
                if(nums[j]+2*nums[nums.length-1]<target-nums[i]) continue;// Too Small
                
                int begin=j+1;
                int end=nums.length-1;
                while(begin<end){
                    int sum=nums[i]+nums[j]+nums[begin]+nums[end];
                    if(sum==target){
                        res.add(Arrays.asList(nums[i],nums[j],nums[begin],nums[end]));
                        while(begin<end && nums[begin]==nums[begin+1]){begin++;}
                        while(begin<end && nums[end]==nums[end-1]){end--;}
                        begin++;
                        end--;
                    }else if (sum<target){
                        begin++;
                    }else{
                        end--;
                    }
                }
            }
        }
    return res;
    }
```
Same as 3sum and 2sum, the difference is  we have to judge two samll or two beg. and using 2 for loop and a while loop. Also using begin end.
### 144	Binary Tree Preorder Traversal	
```
public List<Integer> preorderTraversal(TreeNode root) {
		List<Integer> pre = new LinkedList<Integer>();
		preHelper(root,pre);
		return pre;
	}
	public void preHelper(TreeNode root, List<Integer> pre) {
		if(root==null) return;
		pre.add(root.val);
		preHelper(root.left,pre);
		preHelper(root.right,pre);
	}
```
using helper function, so that we dont have to initiate a new List at each recursion
### 94	Binary Tree Inorder Traversal	
```
 public List<Integer> inorderTraversal(TreeNode root) {
        
		List<Integer> in = new LinkedList<Integer>();
		inHelper(root,in);
		return in;
	}
	public void inHelper(TreeNode root, List<Integer> in) {
		if(root==null) return;
		inHelper(root.left,in);
        in.add(root.val);
		inHelper(root.right,in);
	}
```
same
### 145	Binary Tree Postorder Traversal
```
 public List<Integer> postorderTraversal(TreeNode root) {
     LinkedList<Integer> ans = new LinkedList<>();
	Stack<TreeNode> stack = new Stack<>();
	if (root == null) return ans;
	
	stack.push(root);
	while (!stack.isEmpty()) {
		TreeNode cur = stack.pop();
		ans.addFirst(cur.val);
		if (cur.left != null) {
			stack.push(cur.left);
		}
		if (cur.right != null) {
			stack.push(cur.right);
		} 
	}
	return ans;
    }
```
No recursion version. using linkedlist and stack. Because insertion is O(1) in LinkedList, and it's O(n) in ArrayList. 