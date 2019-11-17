---
title: Everyday Leetcode 22
date: 2019-08-02 13:15:29
tags: [Leetcode]
---
### 67	Add Binary	
```
public String addBinary(String a, String b) {
      StringBuilder sb = new StringBuilder();
        int i=a.length()-1, j=b.length()-1, memo=0;
        while(j>=0 || i>=0){
        int sum= memo;
        if(i>=0) sum+= a.charAt(i--)-'0';
        if(j>=0) sum+= b.charAt(j--)-'0';
        memo=sum/2;
        sb.append(sum%2);
        }
        if(memo!=0) sb.append(memo);
        return sb.reverse().toString();
    }
```
从右往左计算，每一位算出当前位的和再对2取余，就是这一位的结果，最后把第一位的结果加入到StringBuilder再反向输出。
<!-- more-->
### 43	Multiply Strings
```
public String multiply(String num1, String num2) {
      int n=num1.length(), m=num2.length();
      int[] pos= new int[m + n];
      if(num1.length()==0 ||num2.length()==0) return "0";
        for(int i=n-1;i>=0;i--)
            for(int j=m-1;j>=0;j--){
                int res=(num1.charAt(i)-'0')* (num2.charAt(j)-'0');
                int p1=i+j, p2=i+j+1;
                int sum= res+=pos[p2];
                pos[p1]+=sum/10;
                pos[p2]=(sum)%10;
            }
         StringBuilder sb = new StringBuilder();
    for(int p : pos) if(!(sb.length() == 0 && p == 0)) sb.append(p);
    return sb.length() == 0 ? "0" : sb.toString();
}
```
计算每一位的结果并将进位的结果每次都累加。

### 29	Divide Two Integers	
```
  public int divide(int dividend, int divisor) {       
        if(dividend ==  Integer.MIN_VALUE && divisor == -1){
            return Integer.MAX_VALUE;
        }
        
        boolean isNeg = (dividend < 0) ^ (divisor < 0);
        if(dividend > 0) dividend = -dividend;
        if(divisor > 0) divisor = -divisor;
           
        return isNeg? -div(dividend, divisor) : div(dividend, divisor);
    }
    public int div(int divid, int divis){
        if(divid > divis) return 0;
        int curSum = divis << 1, prevSum = divis, q = 1;
        
        while(divid <= curSum && curSum < prevSum){
            prevSum = curSum;
            curSum <<= 1; q <<= 1;
        }
        return q + div(divid - prevSum, divis);
    }
```
每次将divisor×2，如果大于dividend就返回之前的结果+差的结果。

### 69	Sqrt(x)
```
  public int mySqrt(int x) {
        int i = 1;
        int j = x;
        int ans = 0;
        while (i <=j){
            int mid = i + (j-i)/2;
            if (mid <= x/mid){
                i = mid +1;
                ans = mid;
            }
            else
                j = mid-1;
        }
        
        return ans;
    }
```
二分法，当i小于j的时候，每次mid都=左指针+左右指针距离的的1/2，找到最接近x的n*n。

### 50	Pow(x, n)	
```
 public double myPow(double x, int n) {
        if(n == 0)
            return 1;
        if(n<0){
            if(n == Integer.MIN_VALUE) {
            n += 2;
        }
        n = -n;
        x = 1/x;
        }
        return (n%2 == 0) ? myPow(x*x, n/2) : x*myPow(x*x, n/2);
    }
```
每次都递归调用自身 n每次/2，要注意MIN_VALUE的情况会溢出，所以n+=2。

