---
title: Everyday Leetcode 15
date: 2019-05-18 17:57:20
tags: [Leetcode]
---
### 12	Integer to Roman
```
 public String intToRoman(int num) {
        int[] values = {1000,900,500,400,100,90,50,40,10,9,5,4,1};
    String[] strs = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
    
    StringBuilder sb = new StringBuilder();
    
    for(int i=0;i<values.length;i++) {
        while(num >= values[i]) {
            num -= values[i];
            sb.append(strs[i]);
        }
    }
    return sb.toString();
    }
```
从高到低判断是否符合罗马数字大小，符合则减去一该数字并加入字符到结果。

### 273	Integer to English Words
```
private final String[] belowTen = new String[] {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"};
    private final String[] belowTwenty = new String[] {"Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    private final String[] belowHundred = new String[] {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    
    public String numberToWords(int num) {
        if (num == 0) return "Zero";
        return helper(num); 
    }
    
    private String helper(int num) {
        String result = new String();
        if (num < 10) result = belowTen[num];
        else if (num < 20) result = belowTwenty[num -10];
        else if (num < 100) result = belowHundred[num/10] + " " + helper(num % 10);
        else if (num < 1000) result = helper(num/100) + " Hundred " +  helper(num % 100);
        else if (num < 1000000) result = helper(num/1000) + " Thousand " +  helper(num % 1000);
        else if (num < 1000000000) result = helper(num/1000000) + " Million " +  helper(num % 1000000);
        else result = helper(num/1000000000) + " Billion " + helper(num % 1000000000);
        return result.trim();
    }
```
构建单词表（记得开头有“”)，然后根据大小else if，记得可以递归调用自身。

### 246	Strobogrammatic Number
```
 bool isStrobogrammatic(string num) {
        unordered_map<char, char> m {{'0', '0'}, {'1', '1'}, {'8', '8'}, {'6', '9'}, {'9', '6'}};
        for (int i = 0; i <= num.size() / 2; ++i) {
            if (m[num[i]] != num[num.size() - i - 1]) return false;
        }
        return true;
    }
```
如果对应两个位置不满足对称要求，返回false。

### 247	Strobogrammatic Number II
```
  vector<string> findStrobogrammatic(int n) {
        return find(n, n);
    }
    vector<string> find(int m, int n) {
        if (m == 0) return {""};
        if (m == 1) return {"0", "1", "8"};
        vector<string> t = find(m - 2, n), res;
        for (auto a : t) {
            if (m != n) res.push_back("0" + a + "0");
            res.push_back("1" + a + "1");
            res.push_back("6" + a + "9");
            res.push_back("8" + a + "8");
            res.push_back("9" + a + "6");
        }
        return res;
    }
```
从m=0层开始，一层一层往上加的，需要注意的是当加到了n层的时候，左右两边不能加[0 0]。

### 68	Text Justification
```
  public List<String> fullJustify(String[] words, int maxWidth) {
        List<String> res = new ArrayList<>();
        int i=0;
        while (i<words.length){
            int width=0, I=i;
            while (I<words.length && width+words[I].length()+(I-i)<=maxWidth)
                width+=words[I++].length();
            int space=1, extra=0;
            if (I-i!=1 && I!=words.length){
                space=(maxWidth-width)/(I-i-1);
                extra=(maxWidth-width)%(I-i-1);
            }
            StringBuilder line= new StringBuilder(words[i++]);
            while (i<I){
                for (int s= space; s>0; s--) line.append(" ");
                if (extra-->0) line.append(" ");
                line.append(words[i++]);
            }
            for (int s= maxWidth-line.length(); s>0; s--) line.append(" ");
            res.add(line.toString());
        }
        return res;
    }
```
当width小于maxwidth时，加word到改行，然后再后面补空格如果空格数不是2的倍数，那么左边的空间里要比右边的空间里多加入一个空格，那么我们只需要用总的空格数除以空间个数。能除尽最好，说明能平均分配，除不尽的话就多加个空格放在左边的空间里。