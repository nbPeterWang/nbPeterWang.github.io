---
title: 'Everyday Leetcode 9 '
date: 2019-05-10 18:35:14
tags: [Leetcode]
---
### 75	Sort Colors
```
public void sortColors(int[] nums) {
    // 1-pass
    int p1 = 0, p2 = nums.length - 1, index = 0;
    while (index <= p2) {
        if (nums[index] == 0) {
            nums[index] = nums[p1];
            nums[p1] = 0;
            p1++;
        }
        if (nums[index] == 2) {
            nums[index] = nums[p2];
            nums[p2] = 2;
            p2--;
            index--;
        }
        index++;
    }
}

//2pass
public void sortColors(int[] nums) {
        int rc=0,wc=0,bc=0;
        for(int i=0;i<nums.length;i++){
            if(nums[i]==0) rc++;
            else if(nums[i]==1) wc++;
            else if(nums[i]==2) bc++;
        }
        for(int j=0;j<nums.length;j++){
        if(rc>0){nums[j]=0;rc--;}
        else  if(wc>0){nums[j]=1;wc--;}
        else   if(bc>0){nums[j]=2;bc--;}
        }
    }
```
1pass方法，在头部插入0，在尾部插入2，其他1不动。
2pass，统计数目然后重新写入。
<!-- more -->
### 283	Move Zeroes
```
 public void moveZeroes(int[] nums) {
         
    if (nums == null || nums.length == 0) return;        

    int insertPos = 0;
    for (int num: nums) {
        if (num != 0) nums[insertPos++] = num;
    }        

    while (insertPos < nums.length) {
        nums[insertPos++] = 0;
    }
} 
```
如果不等于0则在前面开始插入，然后补足0。

### 376	Wiggle Subsequence
```
public int wiggleMaxLength(int[] nums) {
        if (nums.length < 2) return nums.length;
        int up = 1;
        int down = 1;
        
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > nums[i - 1]) {
                up = down + 1;
            }
            else if (nums[i] < nums[i - 1]) {
                down = up + 1;
            }
        }
        
        return Math.max(up, down); 
    }
```
很巧妙的做法，设置up和down，只有符合wiggle的才会递增，不然停滞，最后输出max即可。

### 280	Wiggle Sort
```
 void wiggleSort(vector<int> &nums) {
        if (nums.size() <= 1) return;
        for (int i = 1; i < nums.size(); ++i) {
            if ((i % 2 == 1 && nums[i] < nums[i - 1]) || (i % 2 == 0 && nums[i] > nums[i - 1])) {
                swap(nums[i], nums[i - 1]);
            }
        }
    }
```
如果不符合条件就和前面的交换。

### 324	Wiggle Sort II
```
 public void wiggleSort(int[] nums) {
        int[] copy = new int[nums.length];
        Arrays.sort(nums);
        for(int i = 0; i < nums.length; i++) copy[i] = nums[i];
        int index = 1;
        for(int i = nums.length - 1; i > (nums.length - 1) / 2; i--){
            nums[index] = copy[i];
            index += 2;
        }
        index = 0;
        for(int i = (nums.length - 1) / 2; i >= 0; i--){
            nums[index] = copy[i];
            index += 2;
        }
    }
```
首先将数组排序，然后复制数组，将后半部分的数组每2个插入，前半部分的数组也每2个插入。


