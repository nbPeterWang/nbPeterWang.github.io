---
title: Everyday Leetcode 19
date: 2019-07-21 18:35:50
tags: [Leetcode]
---
### 131	Palindrome Partitioning	
```
public List<List<String>> partition(String s) {
	List<List<String>> lists=new ArrayList<>();
	int len=s.length();
	if(len==0) return lists;
	backtrack(lists, new ArrayList<>(), s,0,len);
	return lists;
}
private void backtrack(List<List<String>> lists,List<String> list,String s, int l, int r) {
	if(l==r) {
		lists.add(new ArrayList<>(list));
		return;
	}
	for(int i=l+1;i<=r;i++) {
		if(isPalindrome(s, l, i)) {
			list.add(s.substring(l, i));
			backtrack(lists, list, s,i,r);
			list.remove(list.size()-1);
		}
	}
}
private boolean isPalindrome(String s, int l, int r){
    if(l==r-1) return true;
    while(l<r-1){
        if(s.charAt(l)!=s.charAt(r-1)) return false;
        l++;r--;
    }
    return true;
}
```
<!-- more-->
isPalindrome判断回文串，backtrack函数，遍历过程中如果l=r说明已经遍历完成，返回。否则遍历如果当前l到i为字符串为回文串，加到list中并递归调用backtrack(i后面的字符串)最后remove掉最后new的空字符串数组。
### 132	Palindrome Partitioning II	
```
public int minCut(String s) {
        int n = s.length();
        boolean dp[][] = new boolean[n+1][n+1];
        int min[] = new int[n];
        for(int i=0; i<n; ++i) {
            min[i] = i;
            for(int j=0; j<=i; ++j) {
                if(s.charAt(i) == s.charAt(j) && (j+1 > i-1 || dp[j+1][i-1])) {
                    dp[j][i] = true;
                    min[i] = j == 0 ? 0 : Math.min(min[i], min[j-1] + 1);
                }
            }
        }
        return min[n-1];
    }
```
当[j][i]为回文时，dp[j+1][i-1]==true，且s.charAt(i) == s.charAt(j)。所以利用这个写出dp。第一个for循环遍历的是i，此时我们现将 min[i] 初始化为 i，因为对于区间 [0, i]，就算我们每个字母割一刀，最多能只用分割 i 次，不需要再多于这个数字。但是可能会变小，所以第二个for循环用 j 遍历区间 [0, j]，根据上面的解释，我们需要验证的是区间 [j, i] 内的子串是否为回文串，那么只要 s[j] == s[i]，并且 j+1>i-1 或者 p[j+1][i-1] 为true的话，先更新 dp[j][i] 为true，然后在更新 dp[i]，这里需要注意一下corner case，当 j=0 时，我们直接给 dp[i] 赋值为0，因为此时能运行到这，说明 [j, i] 区间是回文串，而 j=0， 则说明 [0, i] 区间内是回文串，这样根本不用分割啊。若 j 大于0，则用 min[j-1] + 1 来更新,min[ i]，最终返回 min[n-1] 即可。
### 267	Palindrome Permutation II
```
public:
    vector<string> generatePalindromes(string s) {
        vector<string> res;
        unordered_map<char, int> m;
        string t = "", mid = "";
        for (auto a : s) ++m[a];
        for (auto &it : m) {
            if (it.second % 2 == 1) mid += it.first;
            it.second /= 2;
            t += string(it.second, it.first);
            if (mid.size() > 1) return {};
        }
        permute(t, m, mid, "", res);
        return res;
    }
    void permute(string &t, unordered_map<char, int> &m, string mid, string out, vector<string> &res) {
        if (out.size() >= t.size()) {
            res.push_back(out + mid + string(out.rbegin(), out.rend()));
            return;
        } 
        for (auto &it : m) {
            if (it.second > 0) {
                --it.second;
                permute(t, m, mid, out + it.first, res);
                ++it.second;
            }
        }
    }
```
用哈希表来记录所有字符的出现个数，然后我们找出出现奇数次数的字符加入mid中，如果有两个或两个以上的奇数个数的字符，那么返回空集，我们对于每个字符，不管其奇偶，都将其个数除以2的个数的字符加入t中，这样做的原因是如果是偶数个，那么将其一般加入t中，如果是奇数，如果有1个，那么除以2是0，不会有字符加入t，如果是3个，那么除以2是1，取一个加入t。等我们获得了t之后，t是就是前半段字符，我们对其做全排列，每得到一个全排列，我们加上mid和该全排列的逆序列就是一种所求的回文字符串，这样我们就可以得到所有的回文全排列了。同时用hashset防重复。
### 20	Valid Parentheses	
```
public boolean isValid(String s) {
        Stack<Character> stack = new Stack<Character>();
	for (char c : s.toCharArray()) {
		if (c == '(')
			stack.push(')');
		else if (c == '{')
			stack.push('}');
		else if (c == '[')
			stack.push(']');
		else if (stack.isEmpty() || stack.pop() != c)
			return false;
	}
	return stack.isEmpty();
    }
```
利用栈，如果是左边的（{[，就把右边的压入栈中，否则就判断是否能消去，或者栈为空。最后栈为空的情况下就是true。
### 22	Generate Parentheses
```
 public List<String> generateParenthesis(int n) {
        List<String> list = new ArrayList<String>();
        backtrack(list, "", 0, 0, n);
        return list;
    }
    
    public void backtrack(List<String> list, String str, int open, int close, int max){
        
        if(str.length() == max*2){
            list.add(str);
            return;
        }
        
        if(open < max)
            backtrack(list, str+"(", open+1, close, max);
        if(close < open)
            backtrack(list, str+")", open, close+1, max);
    }
```
递归调用资深，如果str长度等于n*2则直接返回res。如果open<n就加（，close<open就加），最后返回res。
