---
title: Everyday Leetcode 4
date: 2019-05-03 18:41:50
tags: [Leetcode]
---
### 55	Jump Game
```
class Solution {
     public boolean canJump(int[] nums) {
        if(nums.length<2)
            return true;
        if(nums[0]<1)
            return false;
        int curr=nums[0];
        for(int i =1;i<nums.length;i++){
            if(nums[i]>=curr) curr=nums[i];   
            else curr--;
            if(curr<=0&&i!=nums.length-1) return false;
        }
        return true;        
    }
}
```
遍历数组，如果下一步能比current走得远就走，否则current-1（每一步花的距离）。如果current<=0时还没有走到尽头，说明无法跳到。如果没有return false说明可以跳到。此处greedy比dp更好。
<!-- more -->
### 45	Jump Game II
```
 public int jump(int[] nums) {
        int end = 0;
        int furthest =0;
        int result=0;
        
        for(int i=0;i<nums.length-1;i++){
            furthest = Math.max(furthest, i+nums[i]);
            if(i==end){
                result+=1;
                end = furthest;
            }
        }
        
        return result;
    }
```
每一步走最远，记录下步数到result，更新end到最远。 也是greedy。


### 121	Best Time to Buy and Sell Stock
```
 public int maxProfit(int[] prices) {
        int buy=0;
        int sell=1;
        int maxProfit=0;
        while(sell<prices.length){
            int profit=prices[sell]-prices[buy];
            maxProfit=Math.max(maxProfit,profit);
            if(profit<0) buy=sell;
            sell++;
        }
        return maxProfit;
    }
```
遍历所有盈利最大值并存储，如果无法profit就把buy设置成那天（价格低）。这样可以在最低的价格买入。

### 122	Best Time to Buy and Sell Stock II
```
   public int maxProfit(int[] prices) {
        int result = 0;
        for(int i=1;i<prices.length;i++)
        result=Math.max(result+prices[i]-prices[i-1],result);
        return result;
    }
```
只要盈利就做卖出操作，遍历后即可得到最大收益。

### 123	Best Time to Buy and Sell Stock III
```
 public int maxProfit(int[] prices) { 
        if (prices == null || prices.length <= 1) {
             return 0;
         }
        int cost1 = Integer.MAX_VALUE, cost2 = Integer.MAX_VALUE, profit1 = 0, profit2 = 0;

        for (int price : prices){
            cost1 = Math.min(cost1, price);
            profit1 = Math.max(profit1, price - cost1);
            cost2 = Math.min(cost2, price - profit1);
            profit2 = Math.max(profit2, price - cost2);
        }
        return profit2;
    }
```
该做法较直观，其实dp也可以。