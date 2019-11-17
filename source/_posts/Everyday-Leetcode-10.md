---
title: Everyday Leetcode 10
date: 2019-05-11 17:48:05
tags: [Leetcode]
---
### 28	Implement strStr()
```
 public int strStr(String haystack, String needle) {
        if(needle==null||needle.length()==0) return 0;
        if(haystack.length()<needle.length()) return -1;
        for(int i=0;i<=haystack.length()-needle.length();++i){
            int j=0;
            for(;j<needle.length();++j){
                 if (haystack.charAt(i + j) != needle.charAt(j)) break;
            }
            if (j == needle.length()) return i;
            }
        return -1;
        }
```
如果有位置不等的就跳出循环，如果循环长度等于n长度就返回i。前面两个cornercase。
<!-- more -->
### 14	Longest Common Prefix
```
 public String longestCommonPrefix(String[] strs) {
        if (strs == null || strs.length == 0) return "";
        for (int j = 0; j < strs[0].length(); ++j) {
            for (int i = 0; i < strs.length; ++i) {
                if (j >= strs[i].length() || strs[i].charAt(j) != strs[0].charAt(j)) {
                    return strs[i].substring(0, j); 
                }   
            }
        }
        return strs[0];
    }
```
如果不相等说明最长前缀已找到，否则最后返回第一个单词就是结果。

### 58	Length of Last Word	
```
 public int lengthOfLastWord(String s) {
    if(s.length()<1) return 0;
        int res=0;
        int i=s.length()-1;
        while(i>=0&&s.charAt(i)==' ') i--;
        while(i>=0&&s.charAt(i)!=' ') {
            res++;
            i--;
        }
       return res;
    }
```
从末尾找齐，把空格去掉，再遇到空格就统计到这段为止的长度。注意i>=0一定要在前面，不然会越界。

### 387	First Unique Character in a String	
```
 public int firstUniqChar(String s) {
    if(s==null||s.length()<1) return -1;
    if(s.length()==1) return 0;
    for(int i=0;i<s.length();i++){
        if(s.lastIndexOf(s.charAt(i))==i &&s.indexOf(s.charAt(i))==i) return i;
      }
     return -1;
    }
//5ms
public int firstUniqChar(String s) {
    int[] count = new int[26];
        
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        
        int i = 0;
        for (char c : s.toCharArray()) {
            if (count[c- 'a'] == 1) {
                return i;
            }
            i++;
        }
        
        return -1;
}
```
如果first和lastindex都是i，说明是唯一的。
第二种解法，统计每个字母的个数，然后==1的就是唯一的。
### 383	Ransom Note
```
public boolean canConstruct(String ransomNote, String magazine) {
    
     int[] arr = new int[26];
        for (int i = 0; i < magazine.length(); i++) {
            arr[magazine.charAt(i) - 'a']++;
        }
        for (int i = 0; i < ransomNote.length(); i++) {
            if(--arr[ransomNote.charAt(i)-'a'] < 0) {
                return false;
            }
        }
        return true;
     }
```
统计每个字母出现次数。如果--后小于0说明false 否则true。