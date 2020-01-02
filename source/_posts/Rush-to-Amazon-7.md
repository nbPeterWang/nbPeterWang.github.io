---
title: Rush to Amazon 7
date: 2020-01-02 13:49:10
tags: [Amazon]
---

### 126   Word Ladder II
```
class Solution {
    public List<List<String>> findLadders(String beginWord, String endWord, List<String> wordList) {
        List<List<String>> res = new ArrayList<>();
        Set<String> words = new HashSet<>(wordList);
        if(!words.contains(endWord)) return res;
        
        Map<String, List<String>> map = new HashMap<>(); // current word and nexts
        Set<String> startSet = new HashSet<>();
        Set<String> endSet = new HashSet<>();
        startSet.add(beginWord);
        endSet.add(endWord);
        
        bfs(startSet, map, words, endSet, false);
        
        List<String> list = new ArrayList<>();
        list.add(beginWord);
        dfs(res, list, endWord, beginWord, map);
        
        return res;
    }
    
    private void dfs(List<List<String>> res, List<String> list, String endWord, String curword, Map<String, List<String>> map) {
        if(curword.equals(endWord)) {
            res.add(new ArrayList<>(list));
            return;
        }
        
        if(map.get(curword) == null) return;
        for(String next : map.get(curword)) {
            list.add(next);
            dfs(res, list, endWord, next, map);
            list.remove(list.size() - 1);
        }
    }
    
    private void bfs(Set<String> startSet, Map<String, List<String>> map, Set<String> words, Set<String> endSet, boolean reverse) {
        if (startSet.size() == 0) return;
        
        if (startSet.size() > endSet.size()) {
            bfs(endSet, map, words, startSet, !reverse);
            return;
        }
        
        Set<String> nextLevelSet = new HashSet<>();
        boolean finish = false;
        words.removeAll(startSet);
        
        for (String word : startSet) {
            char[] curword = word.toCharArray();
            for (int i = 0; i < curword.length; i++) {
                char oldchar = curword[i];
                for (char c = 'a'; c <= 'z'; c++) {
                    curword[i] = c;
                    String word_after = new String(curword);
                    
                    if (words.contains(word_after)) {
                        if(endSet.contains(word_after)) {
                            finish = true;
                        }
                        else {
                            nextLevelSet.add(word_after);
                        }
                        
                        String key = reverse ? word_after : word;
                        String value = reverse ? word : word_after;
                        
                        if(map.get(key) == null) {
                            map.put(key, new ArrayList<>());
                        }
                        
                        map.get(key).add(value);
                    }
                }
                curword[i] = oldchar;
            }
        }
        if(finish == false) {
            bfs(nextLevelSet, map, words, endSet, reverse);
        }
    }

}
```
<!-- more -->
using bfs to find the shortest distance, use DFS to output paths with the same distance.


### 103  Binary Tree Zigzag Level Order Traversal
```
public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        if (root == null) {
      return new ArrayList<List<Integer>>();
    }

    List<List<Integer>> results = new ArrayList<List<Integer>>();

    // add the root element with a delimiter to kick off the BFS loop
    LinkedList<TreeNode> node_queue = new LinkedList<TreeNode>();
    node_queue.addLast(root);
    node_queue.addLast(null);

    LinkedList<Integer> level_list = new LinkedList<Integer>();
    boolean is_order_left = true;

    while (node_queue.size() > 0) {
      TreeNode curr_node = node_queue.pollFirst();
      if (curr_node != null) {
        if (is_order_left)
          level_list.addLast(curr_node.val);
        else
          level_list.addFirst(curr_node.val);

        if (curr_node.left != null)
          node_queue.addLast(curr_node.left);
        if (curr_node.right != null)
          node_queue.addLast(curr_node.right);

      } else {
        // we finish the scan of one level
        results.add(level_list);
        level_list = new LinkedList<Integer>();
        // prepare for the next level
        if (node_queue.size() > 0)
          node_queue.addLast(null);
        is_order_left = !is_order_left;
      }
    }
    return results;
  }
```
using bfs. One list node queue to record node list. One level_list to record every level.


### 472   Concatenated Words
```
class Solution {
    public List<String> findAllConcatenatedWordsInADict(String[] words) {
        
        Set<String> hset=new HashSet<>(10000);
        List<String> l=new ArrayList<>();
        int min=Integer.MAX_VALUE;
        for(String s:words){
            if(s.length()==0) continue;
            hset.add(s);
            min=Math.min(min,s.length());
            
        }
        
        for(String s:words){
            if(check(hset,s,0,min)) l.add(s);
        }
        
        return l;
    }
    
    public boolean check(Set<String> hset,String w,int start,int min){
        
        for(int i=start+min; i<=w.length()-min;i++){
            if(hset.contains(w.substring(start,i)) &&(hset.contains(w.substring(i)) ||
                                                     check(hset,w,i,min))) return true;
        }
        
        return false;
    }
    
}
```
using set.

### 957  Prison Cells After N Days
```
class Solution {
    public int[] prisonAfterNDays(int[] cells, int N) {
        N = N % 14;
        if (N == 0) {
            N = 14;
        }
        for (int i = 0; i < N; i++) {
            cells = nextDay(cells);
        }
        return cells;
    }
    
    private int[] nextDay(int[] cells) {
        int[] res = new int[8];
        for (int i = 1; i <= 6; i++) {
            res[i] = 1 - (cells[i - 1] ^ cells[i + 1]);
        }
        return res;
    }
}
```
14 is the magic number!

### 456  132 Pattern
```
public class Solution {
    public boolean find132pattern(int[] nums) {
        if (nums.length < 3)
            return false;
        int[] min = new int[nums.length];
        min[0] = nums[0];
        for (int i = 1; i < nums.length; i++)
            min[i] = Math.min(min[i - 1], nums[i]);
        for (int j = nums.length - 1, k = nums.length; j >= 0; j--) {
            if (nums[j] > min[j]) {
                while (k < nums.length && nums[k] <= min[j])
                    k++;
                if (k < nums.length && nums[k] < nums[j])
                    return true;
                nums[--k] = nums[j];
            }
        }
        return false;
    }
}
```
using array as a stack.