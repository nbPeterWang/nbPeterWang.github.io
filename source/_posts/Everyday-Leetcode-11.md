---
title: Everyday Leetcode 11
date: 2019-05-13 19:32:12
tags: [Leetcode]
---
### 344	Reverse String
```
 public void reverseString(char[] s) {
    for(int i=0,j=s.length-1;i<j;i++,j--){
      char temp=s[i];
      s[i]=s[j];
      s[j]=temp;
      }
    }
```
头尾遍历并交换。
<!-- more -->
### 151	Reverse Words in a String
```
public String reverseWords(String s) {
        StringBuilder sb = new StringBuilder();
        int n = s.length();
        int i = n - 1;
        while(i >= 0) {
            if (s.charAt(i) == ' ') {i--; continue; };
            int j = i - 1;
            while(j >= 0 && s.charAt(j) != ' ') j--;
            sb.append(" ");
            sb.append(s.substring(j + 1, i + 1));
            i = j - 1;
        }
        if (sb.length() > 0) sb.deleteCharAt(0);
        return sb.toString(); 
    }
```
同样两个指针，都从尾部开始，i遇到不是空格停下，j遇到空格停下，j+1到i+1为词。

### 186	Reverse Words in a String II
```
同上
```
同上。

### 345	Reverse Vowels of a String	
```
 public  boolean isVowel(char a){
	    switch(a){
	         case ('a') : return true;
	         case ('e') : return true;
	         case ('i') : return true;
	         case ('o') : return true;
	         case ('u') : return true;
	         case ('A') : return true;
	         case ('E') : return true;
	         case ('I') : return true;
	         case ('O') : return true;
	         case ('U') : return true;
	         default : return false;
	    }
    }

    public  String reverseVowels(String s) {
	     if (s.length()<2) return s;
	
	     char[] tab = s.toCharArray();
	     int j = tab.length - 1;
	     int i = 0;
	
	     while( i < j ) {

		if (!isVowel(tab[i]))
			i++;	
		else {
			while (j!=i && !isVowel(tab[j]))
				j--;
			
			char temp = tab[i];
			tab[i] = tab[j];
			tab[j] = temp;
			i++;
			j--;
		}
	}
	return new String(tab);
}
```
首先将string变为charArray，然后依然从头找元音，找到后再从未开始找。找到后交换。 最后返回new String。

### 205	Isomorphic Strings
```
public boolean isIsomorphic(String s, String t) {
        int[] m1 = new int[256];
        int[] m2 = new int[256];
        
        for (int i = 0; i < s.length(); i++) {
            if (m1[s.charAt(i)] != m2[t.charAt(i)]) return false;
            m1[s.charAt(i)] = m2[t.charAt(i)] = i+1;
        }
        
        return true;
    }
```
可以用两个hashmap，但是时间不划算。可以用int[]代替，如果不相等说明次序不等。char可以表示成256的int（ascii）。