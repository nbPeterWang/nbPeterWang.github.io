---
title: Everyday Leetcode 1
date: 2019-04-28 21:12:16
tags: [Leetcode]
---
### 1 Two Sum
```
class Solution {
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
       throw new IllegalArgumentException();
 }
}
```
用到hashmap，大大提高了效率。 可以用throw new IlleaglArgumentException的办法跳过必须return的检查。
<!-- more -->

### 27	Remove Element
```
public int removeElement(int[] nums, int val) {
       int ans=0;
        for(int i=0;i<nums.length;i++){
            if(nums[i]!=val){
                nums[ans]=nums[i];
                ans++;
            }
        }
        return ans;  
    }
```
没什么好说的。

### 26	Remove Duplicates from Sorted Array
```
public int removeDuplicates(int[] nums) {
        int ans=0;
        for(int i=0;i<nums.length;i++){
            if (nums[i]!=nums[ans])
                nums[++ans]=nums[i];
            
        }
        return ++ans;
    }
```
没什么好说的。

### 80	Remove Duplicates from Sorted Array II
```
public int removeDuplicates(int[] nums) {
    int ans=0;
    for (int i : nums)
    {
        if (ans<2 ||i>nums[ans-2])
            nums[ans++]=i;
    }
        return ans;
    }
```
没什么好说的。

###  189	Rotate Array
```
public void rotate(int[] nums, int k) {
        
    k %= nums.length;
    reverse(nums, 0, nums.length - 1);
    reverse(nums, 0, k - 1);
    reverse(nums, k, nums.length - 1);
}

public void reverse(int[] nums, int start, int end) {
    while (start < end) {
        int temp = nums[start];
        nums[start] = nums[end];
        nums[end] = temp;
        start++;
        end--;
    }
}
```
k可能大于nums.length,所以就需要%=一下。

