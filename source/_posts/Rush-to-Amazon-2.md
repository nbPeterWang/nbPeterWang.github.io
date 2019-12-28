---
title: Rush to Amazon 2
date: 2019-12-27 20:07:51
tags: [Amazon]
---
### 23  Merge k Sorted Lists
```
method-1:
   public ListNode mergeKLists(ListNode[] lists) {
        if (lists == null || lists.length == 0) return null;
        PriorityQueue<ListNode> queue = new PriorityQueue<ListNode>(lists.length, (a,b)-> a.val - b.val);
        
        ListNode head = new ListNode(0);
        ListNode tail = head;
        
        for (ListNode node:lists)
            if (node != null)
                queue.add(node);
        
        while (!queue.isEmpty()){
            tail.next = queue.poll();
            tail = tail.next;
            
            if (tail.next != null)
                queue.add(tail.next);
        }
        return head.next;
    }

method-2:
 public static ListNode mergeKLists(ListNode[] lists){
    return partion(lists,0,lists.length-1);
}

public static ListNode partion(ListNode[] lists,int head,int tail){
    if(head==tail)  return lists[head];
    if(head < tail){
        int mid=head+(tail-head)/2;
        ListNode l1=partion(lists,head,mid);
        ListNode l2=partion(lists,mid+1,tail);
        return merge(l1,l2);
    }else
        return null;
}

//This function is from Merge Two Sorted Lists.
public static ListNode merge(ListNode l1,ListNode l2){
    if(l1==null) return l2;
    if(l2==null) return l1;
    if(l1.val<l2.val){
        l1.next=merge(l1.next,l2);
        return l1;
    }else{
        l2.next=merge(l1,l2.next);
        return l2;
    }
}
```
<!-- more -->
method1: Using priority queue and Java 8 lambda. Really concise.
method2: Using recursion merge. O(Nlogk).

### 937  Reorder Data in Log Files
```
public String[] reorderLogFiles(String[] logs) {
        Arrays.sort(logs, (s1, s2) -> {
            int idx1 = s1.indexOf(' ');
            int idx2 = s2.indexOf(' ');
            String l1 = s1.substring(idx1 + 1);
            String l2 = s2.substring(idx2 + 1);
            
            if (l1.charAt(0) <= '9'){
                if (l2.charAt(0) <= '9') return 0;
                else return 1;
            } else {
                if (l2.charAt(0) <= '9') return -1;
                else{
                    int cmpContent = l1.compareTo(l2);
                    if (cmpContent != 0) return cmpContent;
                    return s1.substring(0, idx1).compareTo(s2.substring(0, idx2));
                }
            }
        });
        return logs;
    }
```
second argument is comparator. 

### 138 Copy List with Random Pointer
```

```

### 273  Integer to English Words
```
private final String[] LESS_THAN_20 = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
private final String[] TENS = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
private final String[] THOUSANDS = {"", "Thousand", "Million", "Billion"};

public String numberToWords(int num) {
    if (num == 0) return "Zero";

    int i = 0;
    String words = "";
    
    while (num > 0) {
        if (num % 1000 != 0)
    	    words = helper(num % 1000) +THOUSANDS[i] + " " + words;
    	num /= 1000;
    	i++;
    }
    
    return words.trim();
}

private String helper(int num) {
    if (num == 0)
        return "";
    else if (num < 20)
        return LESS_THAN_20[num] + " ";
    else if (num < 100)
        return TENS[num / 10] + " " + helper(num % 10);
    else
        return LESS_THAN_20[num / 100] + " Hundred " + helper(num % 100);
}
```
store all the word in three string []. Then do recursion.

### 297 Serialize and Deserialize Binary Tree
```
public String serialize(TreeNode root) {
        return serial(new StringBuilder(), root).toString();
    }
    
    // Generate preorder string
    private StringBuilder serial(StringBuilder str, TreeNode root) {
        if (root == null) return str.append("#");
        str.append(root.val).append(",");
        serial(str, root.left).append(",");
        serial(str, root.right);
        return str;
    }

    public TreeNode deserialize(String data) {
        return deserial(new LinkedList<>(Arrays.asList(data.split(","))));
    }
    
    // Use queue to simplify position move
    private TreeNode deserial(Queue<String> q) {
        String val = q.poll();
        if ("#".equals(val)) return null;
        TreeNode root = new TreeNode(Integer.valueOf(val));
        root.left = deserial(q);
        root.right = deserial(q);
        return root;
    }
```
using StringBuilder and recursion.