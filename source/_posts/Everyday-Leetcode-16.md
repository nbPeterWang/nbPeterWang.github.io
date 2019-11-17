---
title: Everyday Leetcode 16
date: 2019-05-26 19:17:30
tags: [Leetcode]
---
### 65	Valid Number
```
 public boolean isNumber(String s) {
         s = s.trim();
        boolean pointSeen = false;
        boolean eSeen = false;
        boolean numberSeen = false;
        for(int i=0; i<s.length(); i++) {
            if('0' <= s.charAt(i) && s.charAt(i) <= '9') {
                numberSeen = true;
            } else if(s.charAt(i) == '.') {
                if(eSeen || pointSeen)
                    return false;
                pointSeen = true;
            } else if(s.charAt(i) == 'e') {
                if(eSeen || !numberSeen)
                    return false;
                numberSeen = false;
                eSeen = true;
            } else if(s.charAt(i) == '-' || s.charAt(i) == '+') {
                if(i != 0 && s.charAt(i-1) != 'e')
                    return false;
            } else
                return false;
        }
        return numberSeen;
    }
```
<!-- more -->
如上所示。

### 157	Read N Characters Given Read4	
```
int read(char *buf, int n) {
        int t = read4(buf);
        if (t >= n) return n;
        if (t < 4) return t;
        return 4 + read(&buf[4], n - 4);
    }
```
递归解法，如果返回值t大于等于n，说明此时n不大于4，直接返回n即可，如果此返回值t小于4，直接返回t即可，如果都不是，则直接返回调用递归函数加上4，其中递归函数的buf应往后推4个字符，此时n变成n-4即可。

### 158	Read N Characters Given Read4 II - Call multiple times
```
 public class Solution extends Reader4 {
    char[] buffer = new char[4];
    int readPos = 0;
    int writePos = 0;
    public int read(char[] buf, int n) {
        int idx = 0;
        while (idx < n) {
            if (readPos == 0) {
                writePos = read4(buffer);
            }
            while (readPos < writePos && idx < n) {
                buf[idx++] = buffer[readPos++];
            }
            if (readPos == writePos) {
                readPos = 0;
            }
            if (idx == n || writePos < 4) {
                break;
            }
        }
        return idx;
    }
}
```
比如file("abcdefg")，然后要求的是[read(1), read(2), read(2), read(1)]。
1. 调用read(1)后，此时buff为空，调用一个read4，buff中存储了“abcd”，writePos = 4，然后从buff中读出1个字符到buf，那么就是第一个字符["a"]，此时readPos = 1。
2. 调用read(2)，此时readPos = 1 < writePos = 4，所以先从buf中读取2个字符，也就是["bc"]，此时readPos = 3。
3. 然后read(2)，此时readPos = 3 < readPos = 4，所以继续从buff中读取，但是buffer中只剩下一个字符了，所以先把它读到buf中，["d"]，然后readPos == writePos了，所以readPos重置为0，继续循环。此时readPos = 0，我们调用一个read4填充buff，buff中为"efg"，然后我们可以继续读取一个字符到buf中，也就是这次最终读取的结果为["de"]。
4. 最后一次是调用read(1)，则是把buff中的1个字符复制到buf中，得到["f"]

### 76	Minimum Window Substring	
```
 public String minWindow(String s, String t) {
    int [] map = new int[128];
    for (char c : t.toCharArray()) {
      map[c]++;
    }
    int start = 0, end = 0, minStart = 0, minLen = Integer.MAX_VALUE, counter = t.length();
    while (end < s.length()) {
      final char c1 = s.charAt(end);
      if (map[c1] > 0) counter--;
      map[c1]--;
      end++;
      while (counter == 0) {
        if (minLen > end - start) {
          minLen = end - start;
          minStart = start;
        }
        final char c2 = s.charAt(start);
        map[c2]++;
        if (map[c2] > 0) counter++;
        start++;
      }
    }

    return minLen == Integer.MAX_VALUE ? "" : s.substring(minStart, minStart + minLen);
  }
```
使用两个指针+map，如果命中counter-1，当counter==-时说明找到包含substring的window，于是在window内找满足条件的最小window，最后返回最小的window。

### 30	Substring with Concatenation of All Words
```
public static List<Integer> findSubstring(String S, String[] L) {
    List<Integer> res = new ArrayList<Integer>();
    if (S == null || L == null || L.length == 0) return res;
    int len = L[0].length(); // length of each word
    
    Map<String, Integer> map = new HashMap<String, Integer>(); // map for L
    for (String w : L) map.put(w, map.containsKey(w) ? map.get(w) + 1 : 1);
    
    for (int i = 0; i <= S.length() - len * L.length; i++) {
        Map<String, Integer> copy = new HashMap<String, Integer>(map);
        for (int j = 0; j < L.length; j++) { // checkc if match
            String str = S.substring(i + j*len, i + j*len + len); // next word
            if (copy.containsKey(str)) { // is in remaining words
                int count = copy.get(str);
                if (count == 1) copy.remove(str);
                else copy.put(str, count - 1);
                if (copy.isEmpty()) { // matches
                    res.add(i);
                    break;
                }
            } else break; // not in L
        }
    }
    return res;
}
```
首先构建map，然后遍历查找是否match
