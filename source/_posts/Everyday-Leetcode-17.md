---
title: Everyday Leetcode 17
date: 2019-07-19 18:32:28
tags: [Leetcode]
---
### 3	Longest Substring Without Repeating Characters	
```
 public int lengthOfLongestSubstring(String s) {
         if (s.length()==0) return 0;
        HashMap<Character, Integer> map = new HashMap<Character, Integer>();
        int max=0;
        for (int i=0, j=0; i<s.length(); ++i){
            if (map.containsKey(s.charAt(i))){
                j = Math.max(j,map.get(s.charAt(i))+1);
            }
            map.put(s.charAt(i),i);
            max = Math.max(max,i-j+1);
        }
        return max;
    }
```
构建字符串的hashmap，字符是key，位置是value。然后遍历，构建一个sliding window， j是左指针，i是右指针，如果出现过该字符，则更新hashmap，否则直接加入。
<!-- more -->
### 340	Longest Substring with At Most K Distinct Characters	
```
int lengthOfLongestSubstringTwoDistinct(string s) {
        int res = 0, left = 0;
        unordered_map<char, int> m;
        for (int i = 0; i < s.size(); ++i) {
            ++m[s[i]];
            while (m.size() > k) {
                if (--m[s[left]] == 0) m.erase(s[left]);
                ++left;
            }
            res = max(res, i - left + 1);
        }
        return res;
    }
```
同下题159，把2改成k
### 395	Longest Substring with At Least K Repeating Characters	
```
  public int longestSubstring(String s, int k) {
        if (s == null || s.length() == 0) return 0;
        char[] chars = new char[26];
        // record the frequency of each character
        for (int i = 0; i < s.length(); i += 1) chars[s.charAt(i) - 'a'] += 1;
        boolean flag = true;
        for (int i = 0; i < chars.length; i += 1) {
            if (chars[i] < k && chars[i] > 0) flag = false;
        }
        // return the length of string if this string is a valid string
        if (flag == true) return s.length();
        int result = 0;
        int start = 0, cur = 0;
        // otherwise we use all the infrequent elements as splits
        while (cur < s.length()) {
            if (chars[s.charAt(cur) - 'a'] < k) {
                result = Math.max(result, longestSubstring(s.substring(start, cur), k));
                start = cur + 1;
            }
            cur++;
        }
        result = Math.max(result, longestSubstring(s.substring(start), k));
        return result;
    }
```
递归做法，记录字符串中每个字符的出现次数，如果已经是valid string就返回，否则便遍历所有splits，在循环中递归调用自身（start到cur）。内层循环结束后，最后再递归调用自身（start到最后）。
### 159	Longest Substring with At Most Two Distinct Characters	
```
int lengthOfLongestSubstringTwoDistinct(string s) {
        int res = 0, left = 0;
        unordered_map<char, int> m;
        for (int i = 0; i < s.size(); ++i) {
            ++m[s[i]];
            while (m.size() > 2) {
                if (--m[s[left]] == 0) m.erase(s[left]);
                ++left;
            }
            res = max(res, i - left + 1);
        }
        return res;
    }
```
HashMap 记录每个字符的出现次数，然后如果 HashMap 中的映射数量超过两个的时候，我们需要删掉一个映射，然后我们更新结果为 i - left + 1。
### 125	Valid Palindrome
```
 public boolean isPalindrome(String s) {
    char[] c = s.toCharArray();
        for (int i = 0, j = c.length - 1; i < j; ) {
            if (!Character.isLetterOrDigit(c[i])) i++;
            else if (!Character.isLetterOrDigit(c[j])) j--;
            else if (Character.toLowerCase(c[i++]) != Character.toLowerCase(c[j--])) 
                return false;
        }
        return true;
    }
```
首先转换成char[]，然后如果不是letter就移动左右两个指针，随后比较tolowercase后的两个字符，如果有不一样就返回false，如果遍历完没有说明是palindrome，返回true。