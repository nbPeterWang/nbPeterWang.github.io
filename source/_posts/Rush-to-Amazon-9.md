---
title: Rush to Amazon 9
date: 2020-01-06 16:00:01
tags: [Amazon]
---

### 759. Employee Free Time
```
lass Solution {
    public List<Interval> employeeFreeTime(List<List<Interval>> schedule) {
        int totalMeetings = 0;
        for(List<Interval> x : schedule) {
            totalMeetings += x.size();
        }
        int[] start = new int[totalMeetings];
        int[] end = new int[totalMeetings];  
        int i=0;
        for(List<Interval> a : schedule) {
            for(Interval b : a) {
                start[i] = b.start;
                end[i] = b.end;
                i++;
            } 
        }
        Arrays.sort(start);
        Arrays.sort(end);
        List<Interval> temp = new ArrayList<Interval>();
        for(int k=1; k<totalMeetings; k++) {
            if(start[k] > end[k-1]) {
                temp.add(new Interval(end[k-1], start[k]));
            }
        }
        
        int size = temp.size();
        
        List<Interval> result = new ArrayList<Interval>();
        for(int d=0; d<size; d++) {
            result.add(temp.get(d));
        }
        return result;
    }
}
```
<!-- more -->
Using arrayList to store the temporary free time.
It's O(nlogn).

### 140. Word Break II
```
class Solution {
    int maxLen = Integer.MIN_VALUE;//Used to record the longest length of word in the dict
    public List<String> wordBreak(String s, List<String> wordDict) {
        // Corner case
        if(wordDict.size() == 0) {
            return new ArrayList<>();
        }
        //Used to prune recursion tree!!!
        for (String str: wordDict) {
            maxLen = Math.max(maxLen, str.length());
        }
        
        Map<Integer, List<String>> memo = new HashMap<>();
        return dfs(s, new HashSet<>(wordDict), 0, memo);
    }

 //   s = "catsanddog"
//wordDict = ["cat", "cats", "and", "sand", "dog"]
    
    private List<String> dfs(String s, Set<String> wordDictSet, int start, Map<Integer, List<String>> memo) {
        List<String> res = new ArrayList<>();
        // Base case:
        if(start == s.length()) {
            res.add("");
            return res;
        }

        
        if(memo.get(start) != null) {
            return memo.get(start);
        }
      
        for(int end = start + 1; end <= s.length(); end++) {
            //If the prefix's length is more than maxLen, we could directly break!!!!!
            if (end - start > maxLen) {
                break;
            }
            String prefix = s.substring(start, end);
            if(wordDictSet.contains(prefix)) {
               List<String> list = dfs(s, wordDictSet, end, memo);

               if(list.size() == 0) {
                   continue;
               } else if(list.get(0) == "") {
                   res.add(prefix);
               } else {
                  for(String word: list) {
                      res.add(prefix + " " + word);
                  } 
               }
            }           
        }    
        memo.put(start, res);
        return res;
    }  
}

```
using memorized dfs.

### 866. Prime Palindrome
```
class Solution {
    public int primePalindrome(int N) {
        if (N == 1 || N == 2) return 2;
        if (N % 2 == 0) N++;
        while (true) {
            if (isPalindrome(N) && isPrime(N)) return N;
            N += 2;
            if (10_000_000 < N && N < 100_000_000)
                N = 100_000_001;
        }
    }
    
    private boolean isPalindrome(int n) {
        if (n % 10 == 0 && n != 0) return false;
        int n1 = 0;
        while (n > n1) {
            n1 = n1 * 10 + (n % 10);
            n /= 10;
        }
        return n1 == n || n == n1 / 10;
    }
    
    private boolean isPrime(int n) {
        int end = (int)Math.sqrt(n);
        for (int i = 3; i <= end; i += 2) {
            if (n % i == 0) return false;
        }
        return true;
    }
} 
```

### 1268. Search Suggestions System
```
class Solution {
    public List<List<String>> suggestedProducts(String[] products, String searchWord) {
        List<List<String>> res=new ArrayList<>();
        List<String> curRes=Arrays.asList(products);
        Collections.sort(curRes);
        int l=0;
        int r=products.length-1;
        for(int i=0;i<searchWord.length();i++){
            
            <!-- //Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
Output: [
["mobile","moneypot","monitor"],
["mobile","moneypot","monitor"],
["mouse","mousepad"],
["mouse","mousepad"],
["mouse","mousepad"]
] -->
            char c=searchWord.charAt(i);
            while(l<=r){
                
                if(curRes.get(r).length()<=i||curRes.get(r).charAt(i)!=c) r--;
                if(curRes.get(l).length()<=i||curRes.get(l).charAt(i)!=c) l++;
                if(l<=r&&curRes.get(r).charAt(i)==c&&curRes.get(l).charAt(i)==c){
                    break;
                }
            }
            List<String> temp=new ArrayList<>();
            if(r<l){
                res.add(temp);
            }
            else if(r-l<3){
                temp=curRes.subList(l,r+1);
                res.add(temp);
            }
            else{
                temp=curRes.subList(l,l+3);
                res.add(temp);
            }
        }
        
        
        return res;
    }
    
}
```
First we sort, then just using temp list to store every sublist.

### 1102. Path With Maximum Minimum Value
```
class Solution {
    public int maximumMinimumPath(int[][] A) {
        int row = A.length;
        int col = A[0].length;
        int l = 1;
        int h = Math.min(A[0][0], A[row - 1][col - 1]) + 1;
        int[] dir = {0, 1, 0, -1, 0};

        while (l < h) {
            int mid = l+(h-l)/2;
            boolean[][] visited = new boolean[row][col];
            if (isValid(A, visited, mid, 0, 0, row, col, dir)) {
                l = mid + 1;
            } else {
                h = mid;
            }
        }
        return l - 1;
    }

    private boolean isValid(int[][] A, boolean[][] visited, int mid, int i, int j, int row, int col, int[] dir) {
        visited[i][j] = true;
        if (i == row - 1 && j == col - 1) {
            return true;
        }

        for (int k = 0; k < 4; k++) {
            int ni = i + dir[k];
            int nj = j + dir[k + 1];
            if (ni >= 0 && ni < row && nj >= 0 && nj < col && !visited[ni][nj] && A[ni][nj] >= mid) {
                if (isValid(A, visited, mid, ni, nj, row, col, dir)) {
                    return true;
                }
            }
        }
        return false;
    }
}
```
using binary search and dfs.

### 1152. Analyze User Website Visit Pattern
```
class Solution {
    public List<String> mostVisitedPattern(String[] username, int[] timestamp, String[] website) {
        Map<String,TreeMap<Integer,String>> map = new HashMap<>();
        for(int i=0;i<username.length;++i){
            if(!map.containsKey(username[i])){
                TreeMap<Integer,String> tree = new TreeMap<>();
                tree.put(timestamp[i],website[i]);
                map.put(username[i],tree);
            }else{
               TreeMap<Integer,String> tree = map.get(username[i]);
                tree.put(timestamp[i],website[i]);
                map.put(username[i],tree);
            }
        }
        int max = Integer.MIN_VALUE;
        String ans = "";
        HashMap<String,Integer> seq = new HashMap<>();
        for(String x:map.keySet()){
            TreeMap<Integer,String> tree = map.get(x);
            HashSet<String> set = new HashSet<String>();
            List<String> temp = new ArrayList<>();
            for(Integer y:tree.keySet())  temp.add(tree.get(y));
            for(int i=0;i<temp.size()-2;++i){
                String app1 = temp.get(i) + " ";
                for(int j=i+1;j<temp.size()-1;++j){
                    String app2 = temp.get(j) + " ";
                    for(int k=j+1;k<temp.size();++k){
                        String app3 = temp.get(k);
                        String app = app1 + app2 + app3;
                        if(set.contains(app)) continue;
                        set.add(app);
                        seq.put(app,seq.getOrDefault(app,0)+1);
                        if(seq.get(app)>max){
                            max = seq.get(app);
                            ans = app;
                        }else if(seq.get(app)==max && ans.compareTo(app)>0){
                            ans = app;
                        }
                        
                    }
                }
                
            }
        }
        
        return Arrays.asList(ans.split(" "));
    }
}
```