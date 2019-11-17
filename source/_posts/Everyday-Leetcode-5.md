---
title: Everyday Leetcode 5
date: 2019-05-04 18:12:24
tags: [Leetcode]
---
### 188	Best Time to Buy and Sell Stock IV
```
 public int maxProfit(int k, int[] prices) {
	int n = prices.length;
	if (n <= 1)
		return 0;
	
	if (k >=  n/2) {
		int maxPro = 0;
		for (int i = 1; i < n; i++) {
			if (prices[i] > prices[i-1])
				maxPro += prices[i] - prices[i-1];
		}
		return maxPro;
	}
	
    int[][] dp = new int[k+1][n];
    for (int i = 1; i <= k; i++) {
    	int localMax = dp[i-1][0] - prices[0];
    	for (int j = 1; j < n; j++) {
    		dp[i][j] = Math.max(dp[i][j-1],  prices[j] + localMax);
    		localMax = Math.max(localMax, dp[i-1][j] - prices[j]);
    	}
    }
    return dp[k][n-1];
  }
```
如果K大于N/2,说明可以做最多的交易次数，也就是N/2，此时只要是盈利的交易都做，得到最大的收益。 else的话进行dp。dp[i][j-1]是不交易的情况，prices[j]+localMax是在j天交易的情况。
<!-- more -->
### 309	Best Time to Buy and Sell Stock with Cooldown
```
 public int maxProfit(int[] prices) {
    if(prices.length==0 ||prices==null) return 0;
    int buy=Integer.MIN_VALUE;
    int presell=0,prebuy=0,sell=0;
        for(int i: prices){
            prebuy=buy;
            buy=Math.max(presell-i,prebuy);
            presell=sell;
            sell=Math.max(prebuy+i,presell);
        }
    return sell;
    }
```
递推式： buy的情况，要么不买（prebuy,记录i-1天），要么在i-2天前sell，然后在i天buy。 sell的情况，要么不卖（presell，记录i-1天），要么在（i-1天）buy，然后在i天sell。

### 11	Container With Most Water
```
//自己的初始想法 仅仅战胜5.02%
public int maxArea(int[] height) {
        if(height==null || height.length<=1) return 0;
        int ans=Integer.MIN_VALUE;
        for(int i=height.length-1;i>=0;i--)
            for(int j=0;j<height.length;j++){
                ans=Math.max(Math.min(height[i],height[j])*(i-j),ans);
            }
        return ans;
    }
//优化后 faster than 97.7%
 public int maxArea(int[] height) {
        if(height==null || height.length<=1) return 0;
        int left = 0, right = height.length - 1;
	    int maxArea = 0;

	    while (left < right) {
		maxArea = Math.max(maxArea, Math.min(height[left], height[right])
				* (right - left));
		if (height[left] < height[right])
			left++;
		else
			right--;
	    }

	return maxArea;
    }
}
```
开始想法太粗暴，其实只要两头往中间相遇，遍历一遍即可。

### 42	Trapping Rain Water
```
public int trap(int[] A){
    int a=0;
    int b=A.length-1;
    int max=0;
    int leftmax=0;
    int rightmax=0;
    while(a<=b){
        leftmax=Math.max(leftmax,A[a]);
        rightmax=Math.max(rightmax,A[b]);
        if(leftmax<rightmax){
            max+=(leftmax-A[a]);       // leftmax is smaller than rightmax, so the (leftmax-A[a]) water can be stored
            a++;
        }
        else{
            max+=(rightmax-A[b]);
            b--;
        }
    }
    return max;
}
```
也是两头往中间相遇，每格的面积刚好是leftmax-A[a]或者rightmax-A[b] 乘以1。

### 334	Increasing Triplet Subsequence
```
 public boolean increasingTriplet(int[] nums) {
         int small = Integer.MAX_VALUE, big = Integer.MAX_VALUE;
        for (int n : nums) {
            if (n <= small) { small = n; }
            else if (n <= big) { big = n; } 
            else return true; 
        }
        return false;
}
```
存储遍历过程中的最小值与大于最小值小于最大值的值。如果找到能构成序列的三个n则return true，否则return false。