---
title: Everyday Leetcode 2
date: 2019-04-29 18:45:00
tags: [Leetcode]
---
### 41	First Missing Positive
```
import java.util.HashMap;
class Solution {
    public int firstMissingPositive(int[] nums) {
        HashMap map = new HashMap<>();
        for (int i:nums){
            map.put(i,1);
        }
        for (int j=1;j<Integer.MAX_VALUE;j++)
        {
            if (!map.containsKey(j)){
                return j;
            }
        }
        return 0;
    }
}
```
第一道自己做出的Hard，可能是最简单的Hard。 faster than 83.02%，less than 86.32%.
<!-- more -->
```
public int firstMissingPositive(int[] nums) {
    int n = nums.length;
    
    // 1. mark numbers (num < 0) and (num > n) with a special marker number (n+1) 
    // (we can ignore those because if all number are > n then we'll simply return 1)
    for (int i = 0; i < n; i++) {
        if (nums[i] <= 0 || nums[i] > n) {
            nums[i] = n + 1;
        }
    }
    // note: all number in the array are now positive, and on the range 1..n+1
    
    // 2. mark each cell appearing in the array, by converting the index for that number to negative
    for (int i = 0; i < n; i++) {
        int num = Math.abs(nums[i]);
        if (num > n) {
            continue;
        }
        num--; // -1 for zero index based array (so the number 1 will be at pos 0)
        if (nums[num] > 0) { // prevents double negative operations
            nums[num] = -1 * nums[num];
        }
    }
    
    // 3. find the first cell which isn't negative (doesn't appear in the array)
    for (int i = 0; i < n; i++) {
        if (nums[i] >= 0) {
            return i + 1;
        }
    }
    
    // 4. no positive numbers were found, which means the array contains all numbers 1..n
    return n + 1;
}
```
最佳解。
### 299	Bulls and Cows
```
public String getHint(String secret, String guess) {
    int bulls = 0;
    int cows = 0;
    int[] numbers = new int[10];
    for (int i = 0; i<secret.length(); i++) {
        int s = Character.getNumericValue(secret.charAt(i));
        int g = Character.getNumericValue(guess.charAt(i));
        if (s == g) bulls++;
        else {
            if (numbers[s] < 0) cows++;
            if (numbers[g] > 0) cows++;
            numbers[s] ++;
            numbers[g] --;
        }
    }
    return bulls + "A" + cows + "B";
}
```
很坑爹的题，题目表示不清楚。为什么1123，0111是1B，1122，2211却是4B。

### 134	Gas Station
```
public int canCompleteCircuit(int[] gas, int[] cost) {
    int res=-1;
        for (int i=0;i<gas.length;i++){
            int tank=gas[i];
            int j=i;
            
            while(tank-cost[j]>=0){
                if(j==gas.length-1)
                tank=tank-cost[j]+gas[0];
                else
                tank=tank-cost[j]+gas[j+1];
                j++;
                if(j==gas.length) j=0;
                if(j==i) return i;
            }
        }
        return res;
    }
```
思路很简单，但是要小心corner case。

### 274	H-Index
```
public int hIndex(int[] citations) {
    int n = citations.length;
    int[] buckets = new int[n+1];
    for(int c : citations) {
        if(c >= n) {
            buckets[n]++;
        } else {
            buckets[c]++;
        }
    }
    int count = 0;
    for(int i = n; i >= 0; i--) {
        count += buckets[i];
        if(count >= i) {
            return i;
        }
    }
    return 0;
 }
```
bucket sort，空间换时间。首先为长度为n的数组设置n+1个桶，大于n长度的引用数都放到n+1个桶里，然后从尾到头遍历，如果count>=index，这说明我们得到了题目要求的引用数>=index的index。

### 275	H-Index II
```
public int hIndex(int[] citations) {
        int len = citations.length, left = 0, right = len - 1;
        while (left <= right) {
            int mid = 0.5 * (left + right);
            if (citations[mid] == len - mid) return len - mid;
            else if (citations[mid] > len - mid) right = mid - 1;
            else left = mid + 1;
        }
        return len - left;
    }
```
用bucket sort也可以，但这里更适合binary search，因为是有序数组。




