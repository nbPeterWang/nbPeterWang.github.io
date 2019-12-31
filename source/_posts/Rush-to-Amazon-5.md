---
title: Rush to Amazon 5
date: 2019-12-30 18:59:14
tags: [Amazon]
---

### 295  Find Median from Data Stream
```
class MedianFinder {

    /** initialize your data structure here. */
   

    private Queue<Long> small = new PriorityQueue(),
                        large = new PriorityQueue();

    public void addNum(int num) {
        large.add((long) num);
        small.add(-large.poll());
        if (large.size() < small.size())
            large.add(-small.poll());
    }

    public double findMedian() {
        return large.size() > small.size()
               ? large.peek()
               : (large.peek() - small.peek()) / 2.0;
    }

}

class MedianFinder {
    class TreeNode{
        int val;
        TreeNode parent,left,right;
        TreeNode(int val, TreeNode p){
            this.val=val;
            this.parent=p;
            left=null;
            right=null;
        }
        void add(int num){
            if(num>=val){
                if(right==null)
                    right=new TreeNode(num,this);
                else
                    right.add(num);
            }else{
                if(left==null)
                    left=new TreeNode(num,this);
                else
                    left.add(num);
            }
        }
        TreeNode next(){
            TreeNode ret;
            if(right!=null){
                ret=right;
                while(ret.left!=null)
                    ret=ret.left;
            }else{
                ret=this;
                while(ret.parent.right==ret)
                    ret=ret.parent;
                ret=ret.parent;
            }
            return ret;
        }
        TreeNode prev(){
            TreeNode ret;
            if(left!=null){
                ret=left;
                while(ret.right!=null)
                    ret=ret.right;
            }else{
                ret=this;
                while(ret.parent.left==ret)
                    ret=ret.parent;
                ret=ret.parent;
            }
            return ret;
        }
    }
    int n;
    TreeNode root, curr;
    // Adds a number into the data structure.
    public void addNum(int num) {
        if(root==null){
            root = new TreeNode(num,null);
            curr=root;
            n=1;
        }else{
            root.add(num);
            n++;
            if(n%2==1){
                if(curr.val<=num)
                    curr=curr.next();
            }else
                if(curr.val>num)
                    curr=curr.prev();
        }
    }

    // Returns the median of current data stream
    public double findMedian() {
        if(n%2==0){
            return ((double)curr.next().val+curr.val)/2;
        }else
            return curr.val;
    }
};

//BST version
```
Max-heap small has the smaller half of the numbers.
Min-heap large has the larger half of the numbers. getting the median takes O(1) time. And adding a number takes O(log n) time.
<!-- more -->

### 572  Subtree of Another Tree
```
class Solution {
  public boolean isSubtree(TreeNode s, TreeNode t) {
    return dfsUtility(s, t, false);
  }
  
  public boolean dfsUtility(TreeNode s, TreeNode t, boolean matched) {
    if (s == null && t == null) {
      return true;
    } else if (s == null || t == null) {
      return false;
    } else {
      boolean hasMatch = false;
      
      if (s.val == t.val) {
        hasMatch = dfsUtility(s.left, t.left, true) && dfsUtility(s.right, t.right, true);
              
        if (!hasMatch) {
          hasMatch = dfsUtility(s.left, t, false) || dfsUtility(s.right, t, false);
        }
      } else if (!matched) {
        hasMatch = dfsUtility(s.left, t, matched) || dfsUtility(s.right, t, matched);
      }
      
      return hasMatch;
    }
  }
}
```
using DFS & memo. If

### 341  Flatten Nested List Iterator
```
public class NestedIterator implements Iterator<Integer> {
    Queue<Integer> q;
    public NestedIterator(List<NestedInteger> nestedList) {
        q = new LinkedList();
        generateQueue(nestedList);
    }
    
    private void generateQueue(List<NestedInteger> ns) {
        for (NestedInteger n : ns) {
            if (n.isInteger()) q.add(n.getInteger());
            else {
                generateQueue(n.getList());
            }
        }
    }

    @Override
    public Integer next() {
        if (!q.isEmpty()) return q.poll();
        
        return 0;
    }

    @Override
    public boolean hasNext() {
        return !q.isEmpty();
    }
}
```
using queue.

### 692  Top K Frequent Words
```
 public List<String> topKFrequent(String[] words, int k) {
        Map<String, Integer> count = new HashMap();
        for (String word: words) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }
        PriorityQueue<String> heap = new PriorityQueue<String>(
                (w1, w2) -> count.get(w1).equals(count.get(w2)) ?
                w2.compareTo(w1) : count.get(w1) - count.get(w2) );

        for (String word: count.keySet()) {
            heap.offer(word);
            if (heap.size() > k) heap.poll();
        }

        List<String> ans = new ArrayList();
        while (!heap.isEmpty()) ans.add(heap.poll());
        Collections.reverse(ans);
        return ans;
    }
```
using heap, puts the worst candidates at the top of the heap. At the end, we pop off the heap up to k times and reverse the result so that the best candidates are first.

### 460  LFU Cache
```
class LFUCache {
    private Map<Integer, Integer> keyToCount = new HashMap<>();
    private Map<Integer, Integer> keyToVal = new HashMap<>();
    private Map<Integer, LinkedHashSet<Integer>> countToSet = new HashMap<>();
    private int min = 0;
    private int cap;
    
    public LFUCache(int capacity) {
        cap = capacity;    
    }
    
    public int get(int key) {
        if (!keyToVal.containsKey(key)) {
            return -1;
        }
        
        //1. get actual value and calculate freq
        int val = keyToVal.get(key);
        int oldFreq = keyToCount.get(key);
        int newFreq = oldFreq + 1;
        
        //2. remove old freq
        LinkedHashSet<Integer> oldSet = countToSet.get(oldFreq);
        oldSet.remove(key);
        
        //3. update min
        if (min == oldFreq && oldSet.size() == 0) {
            min++;
        }
        
        //4. add new freq and update freq map
        keyToCount.put(key, newFreq);
        countToSet.putIfAbsent(newFreq, new LinkedHashSet<>());
        countToSet.get(newFreq).add(key);
        
        return val;
        
    }
    
    public void put(int key, int value) {
        if (cap <= 0) {
            return;
        }
        //if they key already exists
        if (keyToVal.containsKey(key)) {
            keyToVal.put(key, value);
            get(key);
            return;
        }
        //remove min freq if size alreay equal to capacity
        if (keyToVal.size() >= cap) {
            int keyToRemove = countToSet.get(min).iterator().next();
            countToSet.get(min).remove(keyToRemove);
            keyToCount.remove(keyToRemove);
            keyToVal.remove(keyToRemove);
        }
        
        //add the key and assign the min freq to 1
        keyToCount.put(key, 1);
        keyToVal.put(key, value);
        countToSet.putIfAbsent(1, new LinkedHashSet<>());
        countToSet.get(1).add(key);
        min = 1;
    }
}
```
