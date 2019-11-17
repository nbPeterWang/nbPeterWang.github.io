---
title: Everyday Leetcode 18
date: 2019-07-20 19:39:11
tags: [leetcode]
---
### 266	Palindrome Permutation	
```
bool canPermutePalindrome(string s) {
        unordered_map<char, int> m;
        int cnt = 0;
        for (auto a : s) ++m[a];
        for (auto a : m) {
            if (a.second % 2 == 1) ++cnt;
        }
        return cnt == 0 || (s.size() % 2 == 1 && cnt == 1);
    }
```
创建字符串的hashmap，字符是key，出现次数是value。统计出现次数为奇数的字符个数，如果为0则可以全排列回文，如果为1且只有1个字符出现奇数次，也可以全排列回文。
<!-- mroe -->
### 5	Longest Palindromic Substring	
```
 public String longestPalindrome(String s) {
        String res = "";
        int currLength = 0;
        for(int i=0;i<s.length();i++){
            if(isPalindrome(s,i-currLength-1,i)){
                res = s.substring(i-currLength-1,i+1);
                currLength = currLength+2;
            }
            else if(isPalindrome(s,i-currLength,i)){
                res = s.substring(i-currLength,i+1);
                currLength = currLength+1;
            }
        }
        return res;
    }
    
    public boolean isPalindrome(String s, int begin, int end){
        if(begin<0) return false;
        while(begin<end){
        	if(s.charAt(begin++)!=s.charAt(end--)) return false;
        }
        return true;
    }
```
首先写一个判断是否为回文的辅助函数，然后遍历，判断从当前右指针到前面length+1或者+2长度的字符串是否回文，是的话就更新长度，保存res。最后返回res。

### 9	Palindrome Number	
```
 public boolean isPalindrome(int x) {
        if (x < 0) return false;

    int p = x; 
    int q = 0; 
    
    while (p >= 10){
        q *=10; 
        q += p%10; 
        p /=10; 
    }
    
    return q == x / 10 && p == x % 10;
    }
```
p为x的第一位，q为x的逆序少去个位数。判断他们和原数字是否相等

### 214	Shortest Palindrome	
```
public String shortestPalindrome(String s) {
    String temp = s + "#" + new StringBuilder(s).reverse().toString();
    int[] table = getTable(temp);

    return new StringBuilder(s.substring(table[table.length - 1])).reverse().toString() + s;
}

public int[] getTable(String s){
    int[] table = new int[s.length()];

    int index = 0;
    for(int i = 1; i < s.length(); ){
        if(s.charAt(index) == s.charAt(i)){
            table[i] = ++index;
            i++;
        } else {
            if(index > 0){
                index = table[index-1];
            } else {
                index = 0;
                i ++;
            }
        }
    }
    return table;
}
```
我们把s和其转置r连接起来，中间加上一个其他字符，形成一个新的字符串t，我们还需要一个和t长度相同的一位数组 table，其中 table[i] 表示从 t[i] 到开头的子串的相同前缀后缀的个数，具体可参考 KMP 算法中解释。最后我们把不相同的个数对应的字符串添加到s之前即可。

### 336	Palindrome Pairs
```
class TrieNode {
    TrieNode[] next;
    int index;
    List<Integer> list;
    	
    TrieNode() {
    	next = new TrieNode[26];
    	index = -1;
    	list = new ArrayList<>();
    }
}
    
public List<List<Integer>> palindromePairs(String[] words) {
    List<List<Integer>> res = new ArrayList<>();

    TrieNode root = new TrieNode();
    for (int i = 0; i < words.length; i++) addWord(root, words[i], i);
    for (int i = 0; i < words.length; i++) search(words, i, root, res);
    
    return res;
}
    
private void addWord(TrieNode root, String word, int index) {
    for (int i = word.length() - 1; i >= 0; i--) {
        int j = word.charAt(i) - 'a';
    	if (root.next[j] == null) root.next[j] = new TrieNode();
    	if (isPalindrome(word, 0, i)) root.list.add(index);
    	root = root.next[j];
    }
    	
    root.list.add(index);
    root.index = index;
}
    
private void search(String[] words, int i, TrieNode root, List<List<Integer>> res) {
    for (int j = 0; j < words[i].length(); j++) {	
    	if (root.index >= 0 && root.index != i && isPalindrome(words[i], j, words[i].length() - 1)) {
    	    res.add(Arrays.asList(i, root.index));
    	}
    		
    	root = root.next[words[i].charAt(j) - 'a'];
      	if (root == null) return;
    }
    	
    for (int j : root.list) {
    	if (i == j) continue;
    	res.add(Arrays.asList(i, j));
    }
}
    
private boolean isPalindrome(String word, int i, int j) {
    while (i < j) {
    	if (word.charAt(i++) != word.charAt(j--)) return false;
    }
    	
    return true;
}
```
使用Trie来保存字符串。构建Trie树，将每个word和每步是否是回文的结果保存进去，随后再遍历查找，如果是从j到最后的回文串则加入该键值对到res，最后把list中本来就是回文的也加入res。

