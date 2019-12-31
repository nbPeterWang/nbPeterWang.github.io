---
title: Rush to Amazon 4
date: 2019-12-30 09:57:17
tags: [Amazon]
---

###  139  Word Break
```
public boolean wordBreak(String s, List<String> wordDict) {
        Set<String> wordDictSet=new HashSet(wordDict);
        boolean[] dp = new boolean[s.length() + 1];
        dp[0] = true;
        for (int i = 1; i <= s.length(); i++) {
            for(int j = i-1 ; j >= 0; j--) {
                if (dp[j] && wordDictSet.contains(s.substring(j, i))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        return dp[s.length()];
    }
```
<!-- more -->
Using Dynamic Programming,  we further check if s2's2 ′is present in the dictionary. It might end the loop early with smaller substring.

### 240  Search a 2D Matrix II
```
public boolean searchMatrix(int[][] matrix, int target) {
        if(matrix == null || matrix.length == 0 || matrix[0].length <1) return false;
        int row = matrix.length -1;
        int col = 0;
        while(row >= 0 && col < matrix[0].length){
            if(matrix[row][col] > target){
                row--;
            }else if(matrix[row][col] < target){
                col++;
            }else{
                return true;
            }
        }
        return false;
    }
```
Time complexity : O(n+m). Search Space Reduction


### 127  Word Ladder
```
 public int ladderLength(String beginWord, String endWord, List<String> wordList) {
        if (!wordList.contains(endWord)) return 0;       
        Set<String> dict = new HashSet<>(wordList);
        Set<String> beginSet = new HashSet<>();
        Set<String> endSet = new HashSet<>();
        beginSet.add(beginWord);
        endSet.add(endWord);

        int step = 1;
        Set<String> visited = new HashSet<>();
        while (!beginSet.isEmpty() && !endSet.isEmpty()) {
            if (beginSet.size() > endSet.size()) {
                Set<String> set = beginSet;
                beginSet = endSet;
                endSet = set;
            }
            Set<String> temp = new HashSet<>();
            for (String word : beginSet) {
                char[] chs = word.toCharArray();
                for (int i = 0; i < chs.length; i++) {
                    for (char c = 'a'; c <= 'z'; c++) {
                        char old = chs[i];
                        chs[i] = c;
                        String target = String.valueOf(chs);
                        if (endSet.contains(target)) {
                            return step + 1;
                        }
                        if (!visited.contains(target) && dict.contains(target)) {
                            temp.add(target);
                            visited.add(target);
                        }
                        chs[i] = old;
                    }
                }
            }
            beginSet = temp;
            step++;
        }
        return 0;
    }
```
Bidirectional  BFS search.


### 642  Design Search Autocomplete System
```
class AutocompleteSystem {
    class TrieNode implements Comparable<TrieNode> {
        TrieNode[] children;
        String s;
        int times;
        List<TrieNode> hot;
        
        public TrieNode() {
            children = new TrieNode[128];
            s = null;
            times = 0;
            hot = new ArrayList<>();
        }
        
        public int compareTo(TrieNode o) {
            if (this.times == o.times) {
                return this.s.compareTo(o.s);
            }
            
            return o.times - this.times;
        }
        
        public void update(TrieNode node) {
            if (!this.hot.contains(node)) {
                this.hot.add(node);
            }
            
            Collections.sort(hot);
            
            if (hot.size() > 3) {
                hot.remove(hot.size() - 1);
            }
        }
    }
    
    TrieNode root;
    TrieNode cur;
    StringBuilder sb;
    public AutocompleteSystem(String[] sentences, int[] times) {
        root = new TrieNode();
        cur = root;
        sb = new StringBuilder();
        
        for (int i = 0; i < times.length; i++) {
            add(sentences[i], times[i]);
        }
    }
    
    
    public void add(String sentence, int t) {
        TrieNode tmp = root;
        
        List<TrieNode> visited = new ArrayList<>();
        for (char c : sentence.toCharArray()) {
            if (tmp.children[c] == null) {
                tmp.children[c] = new TrieNode();
            }
            
            tmp = tmp.children[c];
            visited.add(tmp);
        }
        
        tmp.s = sentence;
        tmp.times += t;
        
        for (TrieNode node : visited) {
            node.update(tmp);
        }
    }
    
    public List<String> input(char c) {
        List<String> res = new ArrayList<>();
        if (c == '#') {
            add(sb.toString(), 1);
            sb = new StringBuilder();
            cur = root;
            return res;
        }
        
        sb.append(c);
        if (cur != null) {
            cur = cur.children[c];
        }
        
        if (cur == null) return res;
        for (TrieNode node : cur.hot) {
            res.add(node.s);
        }
        
        return res;
    }
}
```
TrieNode 

### 212  Word Search II
```
public List<String> findWords(char[][] board, String[] words) {
    List<String> res = new ArrayList<>();
    TrieNode root = buildTrie(words);
    for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board[0].length; j++) {
            dfs (board, i, j, root, res);
        }
    }
    return res;
}

public void dfs(char[][] board, int i, int j, TrieNode p, List<String> res) {
    char c = board[i][j];
    if (c == '#' || p.next[c - 'a'] == null) return;
    p = p.next[c - 'a'];
    if (p.word != null) {   // found one
        res.add(p.word);
        p.word = null;     // de-duplicate
    }

    board[i][j] = '#';
    if (i > 0) dfs(board, i - 1, j ,p, res); 
    if (j > 0) dfs(board, i, j - 1, p, res);
    if (i < board.length - 1) dfs(board, i + 1, j, p, res); 
    if (j < board[0].length - 1) dfs(board, i, j + 1, p, res); 
    board[i][j] = c;
}

public TrieNode buildTrie(String[] words) {
    TrieNode root = new TrieNode();
    for (String w : words) {
        TrieNode p = root;
        for (char c : w.toCharArray()) {
            int i = c - 'a';
            if (p.next[i] == null) p.next[i] = new TrieNode();
            p = p.next[i];
       }
       p.word = w;
    }
    return root;
}

class TrieNode {
    TrieNode[] next = new TrieNode[26];
    String word;
}
```
Trie DFS.