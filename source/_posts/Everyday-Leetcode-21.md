---
title: Everyday Leetcode 21
date: 2019-07-25 14:00:08
tags: [Leetcode]
---
### 7	Reverse Integer	
```
public int reverse(int x) {
          long rev= 0;
        while( x != 0){
            rev= rev*10 + x % 10;
            x= x/10;
            if( rev > Integer.MAX_VALUE || rev < Integer.MIN_VALUE)
                return 0;
        }
        return (int) rev;
    }
```
<!-- more -->

每次将最后一位*10+之前的一位。
### 165	Compare Version Numbers	
```
 public int compareVersion(String version1, String version2) {
    String[] levels1 = version1.split("\\.");
    String[] levels2 = version2.split("\\.");
    
    int length = Math.max(levels1.length, levels2.length);
    for (int i=0; i<length; i++) {
    	Integer v1 = i < levels1.length ? Integer.parseInt(levels1[i]) : 0;
    	Integer v2 = i < levels2.length ? Integer.parseInt(levels2[i]) : 0;
    	int compare = v1.compareTo(v2);
    	if (compare != 0) {
    		return compare;
    	}
    }
    
    return 0;
    }
```
首先把.去掉，取两个字符串中最大的长度，然后逐位比较。

### 66	Plus One	
```
 public int[] plusOne(int[] digits) {
        int n = digits.length;
        for (int i = digits.length - 1; i >= 0; --i) {
            if (digits[i] < 9) {
                ++digits[i];
                return digits;
            }
            digits[i] = 0;
        }
        int[] res = new int[n + 1];
        res[0] = 1;
        return res;
    }
}
```
如果该位小于9就+1返回，否则=0.这样可以完成进位。

### 8	String to Integer (atoi)
```
  public int myAtoi(String str) {
		if (str.isEmpty())
			return 0;
		str = str.trim();
       if (str.isEmpty())
			return 0;
		int i = 0, ans = 0, sign = 1, len = str.length();
		if (str.charAt(i) == '-' || str.charAt(i) == '+')
			sign = str.charAt(i++) == '+' ? 1 : -1;
		for (; i < len; ++i) {
			int tmp = str.charAt(i) - '0';
			if (tmp < 0 || tmp > 9)
				break;
			if (ans > Integer.MAX_VALUE / 10
					|| (ans == Integer.MAX_VALUE / 10 && Integer.MAX_VALUE % 10 < tmp))
				return sign == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;
			else
				ans = ans * 10 + tmp;
		}
		return sign * ans;
	}
```
首先，handle空字串，去掉空格后再handle，否则会越界。后面当ans越界时返回正无穷或负无穷。ans每次*10再加上tmp。

### 258	Add Digits
```
public int addDigits(int num) {
        return (num!=0 && num%9==0) ? 9 : num%9;
    }
```
返回9或对9取余的结果即可。
