---
title: Rush to Amazon 1
date: 2019-12-23 21:11:25
tags: [Amazon]
---

### 2  Add Two Numbers
```
 public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        int temp = 0;
        ListNode resultNode = new ListNode(0);
        ListNode res = resultNode;
        
        while (l1 != null || l2 != null || temp != 0){
            if(l1 != null){
                temp += l1.val;
                l1 = l1.next;
            }
            
            if(l2 != null){
                temp += l2.val;
                l2 = l2.next;
            }
            
            resultNode.next = new ListNode(temp % 10);
            temp /= 10;
            resultNode = resultNode.next;
        }
        
        return res.next;
    }
```
using a Node res to link headNode, in every iteration, calculate the sum of  l1 and l2 and the value left to get every node's value. At last, return res.next.
<!-- more -->

### 5 Longest Palindromic Substring
```
    private int lo, maxLen;

public String longestPalindrome(String s) {
	int len = s.length();
	if (len < 2)
		return s;
	
    for (int i = 0; i < len-1; i++) {
     	extendPalindrome(s, i, i);  //assume odd length, try to extend Palindrome as possible
     	extendPalindrome(s, i, i+1); //assume even length.
    }
    return s.substring(lo, lo + maxLen);
}

private void extendPalindrome(String s, int j, int k) {
	while (j >= 0 && k < s.length() && s.charAt(j) == s.charAt(k)) {
		j--;
		k++;
	}
	if (maxLen < k - j - 1) {
		lo = j + 1;
		maxLen = k - j - 1;
	}
 }
```
try to record maxlength and location when we call the helper method. So it 's  O(n^2).

### 15 3Sum
```
public List<List<Integer>> threeSum(int[] nums) {
 	List<List<Integer>> res = new ArrayList<>();
    Arrays.sort(nums);
    for (int i = 0; i + 2 < nums.length; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) {              // skip same result
            continue;
        }
        int j = i + 1, k = nums.length - 1;  
        int target = -nums[i];
        while (j < k) {
            if (nums[j] + nums[k] == target) {
                res.add(Arrays.asList(nums[i], nums[j], nums[k]));
                j++;
                k--;
                while (j < k && nums[j] == nums[j - 1]) j++;  // skip same result
                while (j < k && nums[k] == nums[k + 1]) k--;  // skip same result
            } else if (nums[j] + nums[k] > target) {
                k--;
            } else {
                j++;
            }
        }
    }
    return res;
}
```
using two pointer at every iteration. O(N^2).

### 3  Longest Substring Without Repeating Characters
```
public int lengthOfLongestSubstring(String s) {
       if(s.length() == 0) return 0;
        Map<Character, Integer> map = new HashMap<>();
        int max = 0;
        for (int i=0,j=0;i < s.length(); ++i){
            if(map.containsKey(s.charAt(i))){
                j = Math.max(j,map.get(s.charAt(i))+1);
            }
            map.put(s.charAt(i), i);
            max = Math.max(max, i-j+1);
        }
        
        return max;
    }
```
find every substring and find the maximum of them.

### 21  Merge Two Sorted Lists
```
 public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
       if(l1 == null) return l2;
		if(l2 == null) return l1;
		if(l1.val < l2.val){
			l1.next = mergeTwoLists(l1.next, l2);
			return l1;
		} else{
			l2.next = mergeTwoLists(l1, l2.next);
			return l2;
		}
    }

 public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        ListNode resNode = new ListNode(0);
        ListNode res = resNode;
        while(l1 != null || l2 != null){
              if(l2 == null){
                resNode.next = new ListNode(l1.val);
                l1 = l1.next;
                resNode = resNode.next;
            }
            else if (l1 == null){
                resNode.next = new ListNode(l2.val);
                l2 = l2.next;
                resNode = resNode.next;
            }
            
            else if(l1.val > l2.val){
                resNode.next = new ListNode(l2.val);
                l2 = l2.next;
                resNode = resNode.next;
            }
            else {
                 resNode.next = new ListNode(l1.val);
                l1 = l1.next;
                resNode = resNode.next;
            }
          
            
        }
      return res.next;
    }
```
recursive version and iterative version.