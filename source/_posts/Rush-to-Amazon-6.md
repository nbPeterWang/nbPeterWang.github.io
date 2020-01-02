---
title: Rush to Amazon 6
date: 2020-01-01 17:59:09
tags: [Amazon]
---

### 348   Design Tic-Tac-Toe
```
public class TicTacToe {
private int[] rows;
private int[] cols;
private int diagonal;
private int antiDiagonal;

/** Initialize your data structure here. */
public TicTacToe(int n) {
    rows = new int[n];
    cols = new int[n];
}

/** Player {player} makes a move at ({row}, {col}).
    @param row The row of the board.
    @param col The column of the board.
    @param player The player, can be either 1 or 2.
    @return The current winning condition, can be either:
            0: No one wins.
            1: Player 1 wins.
            2: Player 2 wins. */
public int move(int row, int col, int player) {
    int toAdd = player == 1 ? 1 : -1;
    
    rows[row] += toAdd;
    cols[col] += toAdd;
    if (row == col)
    {
        diagonal += toAdd;
    }
    
    if (col == (cols.length - row - 1))
    {
        antiDiagonal += toAdd;
    }
    
    int size = rows.length;
    if (Math.abs(rows[row]) == size ||
        Math.abs(cols[col]) == size ||
        Math.abs(diagonal) == size  ||
        Math.abs(antiDiagonal) == size)
    {
        return player;
    }
    
    return 0;
}
}
```
<!-- more -->
To keep track of which player, I add one for Player1 and -1 for Player2. There are two additional variables to keep track of the count of the diagonals. Each time a player places a piece we just need to check the count of that row, column, diagonal and anti-diagonal.

### 772  Basic Calculator III
```
 public int calculate(String s) {
        if(s == null || s.length() == 0) return 0;
        return usingRecur(s, new int[]{0});
    }
    
    private int usingRecur(String s, int[] i) {
        int num = 0, res = 0, prev = 0;
        char sign = '+';
        while(i[0] < s.length()) {
            char c = s.charAt(i[0]++);
            if     (c == ' ') continue;
            else if(c == '(') num = usingRecur(s, i);
            else if(c == ')') break;
            else if(Character.isDigit(c)) num = num*10+(c-'0');
            else {
                if(sign == '+' || sign == '-') res += prev;
                prev = eval(sign, num, prev);
                sign = c;
                num  = 0;
            }
        }
        if(sign == '+' || sign == '-') res += prev;
        prev = eval(sign, num, prev);
        return res+prev;
    }

    private int eval(char sign, int num, int prev) {
        if     (sign == '+') prev = num;
        else if(sign == '-') prev = -num;
        else if(sign == '*') prev *= num;
        else if(sign == '/') prev /= num;
        return prev;
    }
```
usings stack or recursion.

### 819  Most Common Word
```
public String mostCommonWord(String paragraph, String[] banned) {

        // for cases that end with a letter only. e.g. "Bob"
        paragraph += ".";

        Set<String> bannedSet = new HashSet<>();
        for (String word : banned) bannedSet.add(word);
        
        Map<String, Integer> count = new HashMap<>();
        StringBuilder word = new StringBuilder();
        String ans = "";
        int freq = 0;

        for (char c : paragraph.toCharArray()) {
            if (Character.isLetter(c)) {
                word.append(Character.toLowerCase(c));
            } else if (word.length() > 0) {
                String finalWord = word.toString();
                if (!bannedSet.contains(finalWord)) {
                    count.put(finalWord, count.getOrDefault(finalWord, 0) + 1);
                    if (count.get(finalWord) > freq) {
                        ans = finalWord;
                        freq = count.get(finalWord);
                    }
                }
                word = new StringBuilder();
            }
            
        }
        return ans;
    }
```

### 994   Rotting Oranges
```
public int orangesRotting(int[][] grid) {
      int d = 0, fresh = 0;
      for (int i = 0; i < grid.length; ++i) {
          for (int j = 0; j < grid[i].length; ++j) {
          if (grid[i][j] == 1) fresh += 1;
          }
      }
    
      for (int old_fresh = fresh; fresh > 0; ++d, old_fresh = fresh) {
          for (int i = 0; i < grid.length; ++i) {
              for (int j = 0; j < grid[i].length; ++j) {
                if (grid[i][j] == d + 2) {
                  fresh -= rot(grid, i - 1, j, d) + rot(grid, i + 1, j, d) + rot(grid, i, j - 1, d) + rot(grid, i, j + 1, d);
                }
              }
            }
            if (old_fresh == fresh) return -1;
          }
      return d;
  }
  
  private int rot(int[][] grid, int i, int j, int d) {
      if (i < 0 || j < 0 || i >= grid.length || j >= grid[0].length || grid[i][j] != 1) return 0;
      grid[i][j] = d + 3;
      return 1;
  }
```
using BFS, rot every 

### 347  Top K Frequent Elements
```
 public List<Integer> topKFrequent(int[] nums, int k) {

	List<Integer>[] bucket = new List[nums.length + 1];
	Map<Integer, Integer> frequencyMap = new HashMap<Integer, Integer>();

	for (int n : nums) {
		frequencyMap.put(n, frequencyMap.getOrDefault(n, 0) + 1);
	}

	for (int key : frequencyMap.keySet()) {
		int frequency = frequencyMap.get(key);
		if (bucket[frequency] == null) {
			bucket[frequency] = new ArrayList<>();
		}
		bucket[frequency].add(key);
	}

	List<Integer> res = new ArrayList<>();

	for (int pos = bucket.length - 1; pos >= 0 && res.size() < k; pos--) {
		if (bucket[pos] != null) {
			res.addAll(bucket[pos]);
		}
	}
	return res.subList(0,k);
 }
```
using bucket sort.