---
title: Everyday Leetcode 20
date: 2019-07-22 16:23:33
tags: [Leetcode]
---
### 32	Longest Valid Parentheses	
```
public int longestValidParentheses(String s) {
    char[] S = s.toCharArray();
    int[] V = new int[S.length];
    int open = 0;
    int max = 0;
    for (int i=0; i<S.length; i++) {
        if (S[i] == '(') open++;
        if (S[i] == ')' && open > 0) {
            // matches found
            V[i] = 2+ V[i-1];
            // add matches from previous
            if(i-V[i]>0)
                V[i] += V[i-V[i]];
            open--;
        }
        if (V[i] > max) max = V[i];
    }
    return max;
}
```
<!-- more -->
dp,状态方程式为V[i] = 2+ V[i-1]+ previous matches V[i- (V[i-1] + 2) ] if S[i] = ')' and '(' count > 0。

### 241	Different Ways to Add Parentheses	
```
 private Map<String,List<Integer>> memo = new HashMap<>();
    public List<Integer> diffWaysToCompute(String input) {
        int len = input.length();
        List<Integer> result = memo.get(input);
        if (result != null) { return result; }
        result = new ArrayList<>();
        if (isDigit(input)) {
            result.add(Integer.parseInt(input));
            memo.put(input,result);
            return result;
        }
        for (int i = 0; i < len; i++) {
            char c = input.charAt(i);
            if (c == '+' || c == '-' || c == '*') {
                List<Integer> left = diffWaysToCompute(input.substring(0,i));
                List<Integer> right = diffWaysToCompute(input.substring(i+1,len));
                for (Integer il : left) {
                    for (Integer ir : right) {
                        switch (c) {
                            case '+': result.add(il + ir); break;
                            case '-': result.add(il - ir); break;
                            case '*': result.add(il * ir); break;
                        }
                    }
                }
            }
        }
        memo.put(input,result);
        return result;
    }
    private boolean isDigit(String s) {
        for (Character c : s.toCharArray()) {
            if (!Character.isDigit(c)) { return false; }
        }
        return true;
    }
```
首先维护一个private的hashmap用来储存。如果已经有结果直接返回，如果是数字，直接加入到memo并返回。遍历字符，将左边的和右边的都递归调用自身返回结果，然后根据当前符号计算，最后保存结果到hashmap。

### 301	Remove Invalid Parentheses		
```
public List<String> removeInvalidParentheses(String s) {
    List<String> ans = new ArrayList<>();
    remove(s, ans, 0, 0, new char[]{'(', ')'});
    return ans;
}

public void remove(String s, List<String> ans, int last_i, int last_j,  char[] par) {
    for (int stack = 0, i = last_i; i < s.length(); ++i) {
        if (s.charAt(i) == par[0]) stack++;
        if (s.charAt(i) == par[1]) stack--;
        if (stack >= 0) continue;
        for (int j = last_j; j <= i; ++j)
            if (s.charAt(j) == par[1] && (j == last_j || s.charAt(j - 1) != par[1]))
                remove(s.substring(0, j) + s.substring(j + 1, s.length()), ans, i, j, par);
        return;
    }
    String reversed = new StringBuilder(s).reverse().toString();
    if (par[0] == '(') // finished left to right
        remove(reversed, ans, 0, 0, new char[]{')', '('});
    else // finished right to left
        ans.add(reversed);
}
```
stack遇到左括号自增1，遇到右括号自减1。当stack<0时，从上一个删除的位置开始遍历。当当前字符为右括号而且是第一个右括号，删除当前右括号并递归。后面将字符串反转，如果par是左括号，则调用递归函数传入反向括号来删除多的左括号。否则说明已经反转，可以直接加入结果了。
### 392	Is Subsequence	
```
  public boolean isSubsequence(String s, String t) 
    {
        if(t.length() < s.length()) return false;
        int prev = 0;
        for(int i = 0; i < s.length();i++)
        {
            char tempChar = s.charAt(i);
            prev = t.indexOf(tempChar,prev);
            if(prev == -1) return false;
            prev++;
        }
        
        return true;
    }
```
使用string的indexOf，每次都检索是否从当前位置开始，是否有s的字符在t中。

### 115	Distinct Subsequences
```
 public int numDistinct(String S, String T) {
    int[][] mem = new int[T.length()+1][S.length()+1];
    for(int j=0; j<=S.length(); j++) {
        mem[0][j] = 1;
    }
    
    
    for(int i=0; i<T.length(); i++) {
        for(int j=0; j<S.length(); j++) {
            if(T.charAt(i) == S.charAt(j)) {
                mem[i+1][j+1] = mem[i][j] + mem[i+1][j];
            } else {
                mem[i+1][j+1] = mem[i+1][j];
            }
        }
    }
    
    return mem[T.length()][S.length()];
 }
```
dp 。dp[i][j] = dp[i-1][j] + dp[i-1][j-1]
