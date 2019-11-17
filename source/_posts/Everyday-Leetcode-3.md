---
title: Everyday Leetcode 3
date: 2019-04-30 19:51:55
tags: [Leetcode]
---
### 277	Find the Celebrity
```
int findCelebrity(int n) {
        for (int i = 0, j = 0; i < n; ++i) {
            for (j = 0; j < n; ++j) {
                if (i != j && (knows(i, j) || !knows(j, i))) break;
            }
            if (j == n) return i;
        }
        return -1;
    }
```
遍历，如果遇到 i认识j或者j不认识i就break，完整循环下来的就是celebrity。
<!-- more-->
### 217	Contains Duplicate
```
import java.util.HashSet;
class Solution {
    public boolean containsDuplicate(int[] nums) {
        HashSet<Integer> hs = new HashSet<>();
        for(int i:nums)
        {
            if(hs.contains(i)) return true;
            else hs.add(i);
        }
        return false;
    }
}
```
hashset遍历，如果包含就返回true，否则就加入hashset。

### 243	Shortest Word Distance
```
int shortestDistance(vector<string>& words, string word1, string word2) {
        int p1 = -1, p2 = -1, res = INT_MAX;
        for (int i = 0; i < words.size(); ++i) {
            if (words[i] == word1) p1 = i;
            else if (words[i] == word2) p2 = i;
            if (p1 != -1 && p2 != -1) res = min(res, abs(p1 - p2));
        }
        return res;
    }
```
遍历一次数组找出p1,p2，得出结果。
### 244	Shortest Word Distance II
```
class WordDistance {
public:
    WordDistance(vector<string>& words) {
        for (int i = 0; i < words.size(); ++i) {
            m[words[i]].push_back(i);
        }
    }

    int shortest(string word1, string word2) {
        int res = INT_MAX;
        for (int i = 0; i < m[word1].size(); ++i) {
            for (int j = 0; j < m[word2].size(); ++j) {
                res = min(res, abs(m[word1][i] - m[word2][j]));
            }
        }
        return res;
    }
    
private:
    unordered_map<string, vector<int> > m;
};
```
hashmap解法。
### 245	Shortest Word Distance III
```
 int shortestWordDistance(vector<string>& words, string word1, string word2) {
        int p1 = words.size(), p2 = -words.size(), res = INT_MAX;
        for (int i = 0; i < words.size(); ++i) {
            if (words[i] == word1) p1 = word1 == word2 ? p2 : i;
            if (words[i] == word2) p2 = i;
            res = min(res, abs(p1 - p2));
        }
        return res;
    }
```
如果p1和p2相等，结果为p2-i。不相等则同243的做法。