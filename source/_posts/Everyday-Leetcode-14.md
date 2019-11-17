---
title: Everyday Leetcode 14
date: 2019-05-17 19:05:59
tags: [Leetcode]
---
### 316	Remove Duplicate Letters	
```
 public String removeDuplicateLetters(String sr) {   
         int[] res = new int[26]; 
    boolean[] visited = new boolean[26]; 
    char[] ch = sr.toCharArray();
    for(char c: ch){  
        res[c-'a']++;
    }
    Stack<Character> st = new Stack<>();
    int index;
    for(char s:ch){ 
        index= s-'a';
        res[index]--;   
        if(visited[index]) 
            continue;
        while(!st.isEmpty() && s<st.peek() && res[st.peek()-'a']!=0){ 
            visited[st.pop()-'a']=false;
        }

        st.push(s); 
        visited[index]=true;
    }
    StringBuilder sb = new StringBuilder();
    while(!st.isEmpty()){
        sb.insert(0,st.pop());
    }
    return sb.toString();
    }
```
<!-- more -->
首先用char数组记录字符出现次数，然后遍历，如果该数字已经出现在序列中，continue不管它，如果比当前栈顶小，而且栈顶字符次数不为0，还会在后面出现，就弹出并置为false未出现，将当前字符压入栈中。最后按照栈的次序pop输出。

### 271	Encode and Decode Strings	
```
// Encodes a list of strings to a single string.
    string encode(vector<string>& strs) {
        string res = "";
        for (string str : strs) res += str + '\0';
        return res;
    }
    // Decodes a single string to a list of strings.
    vector<string> decode(string s) {
        vector<string> res;
        stringstream ss(s);
        string t;
        while (getline(ss, t, '\0')) {
            res.push_back(t);
        }
        return res;
    }
}
```
在每个字符串的后面加上换行字符'\0'，其还属于一个字符串，这样我们在解码的时候，只要去查找这个换行字符就可以了。

### 168	Excel Sheet Column Title	
```
public String convertToTitle(int n) {
      StringBuilder sb= new StringBuilder();
      

        while(n>0){
            n--;
            sb.insert(0, (char)('A' + n % 26));
            n /= 26;
        }

        return sb.toString();
    }
```
相当于转换成26进制。

### 171	Excel Sheet Column Number	
```
 public int titleToNumber(String s) {
        
      char[] ch = s.toCharArray();
        int res=0;
       for(int i=s.length()-1;i>=0;i--){
           int sq=s.length()-1-i;
           int q=1;
           while(sq>0){
               q*=26;
               sq--;
           }
        res+=(int)(ch[i]-'A'+1)*q;
         }
        return res;
    
    }
```
同上，反过来做。

### 13	Roman to Integer
```
public int romanToInt(String s) {
       
        int[] map = new int[256];
        map['I'] = 1; map['V'] = 5; map['X'] = 10; map['L'] = 50; map['C'] = 100; map['D'] = 500; map['M'] = 1000;
        
        int ret = 0, pre = 1;
        for (int i = s.length()-1; i >= 0; --i) {
            int cur = map[s.charAt(i)];
            if (cur < pre) ret -= cur;
            else {
                pre = cur;
                ret += cur;
            }
        }
        return ret;
    
    }
```
罗马数字的规则，如果小得放前面说明要减去前面这个。否则直接累加。