---
title: Everyday Leetcode 12
date: 2019-05-14 18:30:22
tags: [Leetcode]
---
### 293	Flip Game
```
public generatePossibleNextMoves(string s) {
 StringBuilder sb = new StringBuilder();
        
        for (int i = 1; i < s.length(); ++i) {
            
            if (s.charAt(i) == '+'&& scharAt(i - 1) == '+') {
            sb.append(s.substring(0, i - 1) + "--" + s.substrting(i + 1)));
            
        }
        
        return sb.toString(); 
}
```
遍历 如果i和i-1都是加则加入字符串。
<!-- more -->
### 294	Flip Game II
```
bool canWin(string s) {
        for (int i = 1; i < s.size(); ++i) {
            if (s[i] == '+' && s[i - 1] == '+' && !canWin(s.substr(0, i - 1) + "--" + s.substr(i + 1))) {
                return true;
            }
        }
        return false;
    }
```
递归调用如果将这两个位置变为--的字符串，如果返回false，说明当前玩家可以赢，结束循环返回false。

### 290	Word Pattern
```
public boolean wordPattern(String pattern, String str) {
    String[] words = str.split(" ");
    if (words.length != pattern.length())
        return false;
    Map index = new HashMap();
    for (Integer i=0; i<words.length; ++i)
        if (index.put(pattern.charAt(i), i) != index.put(words[i], i))
            return false;
    return true;
 }
```
构建hashmap，和前面205原理一样。

### 242	Valid Anagram
```
public boolean isAnagram(String s, String t) {
        
        if (s.length() != t.length()) return false;

        int n = s.length();
        int[] freq = new int[26];

       
        for (int i = 0; i < n; i++) {
            freq[s.charAt(i) - 'a']++; 
        }

        for (int i = 0; i < n; i++) {
            if (freq[t.charAt(i) - 'a']-- == 0) {
                return false;
            } 
        }

        return true;
    }
```
建立单词表，两个for遍历。

### 49	Group Anagrams
```
 public List<List<String>> groupAnagrams(String[] strs) {
    if (strs == null || strs.length == 0) return new ArrayList<List<String>>();
        Map<String, List<String>> map = new HashMap<String, List<String>>();
        for (String s : strs) {
            char[] ca = s.toCharArray();
            Arrays.sort(ca);
            String keyStr = String.valueOf(ca);
            if (!map.containsKey(keyStr)) map.put(keyStr, new ArrayList<String>());
            map.get(keyStr).add(s);
        }
        return new ArrayList<List<String>>(map.values());
    }
```
把每个字符串排序，这样得到的keyStr都一样，然后将同个key的字符串add进同一个list。
