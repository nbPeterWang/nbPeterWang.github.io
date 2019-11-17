---
title: Everyday Leetcode 8
date: 2019-05-09 18:03:01
tags: [Leetcode]
---
### 238	Product of Array Except Self
```
 public int[] productExceptSelf(int[] nums) {
        if(nums==null||nums.length<=1) return null;
         int[] res = new int[nums.length];
        res[0] = 1;
        for (int i = 1; i < nums.length; i++) {
        res[i] = res[i - 1] * nums[i - 1];
        }
        int right = 1;
    for (int i = nums.length-1; i >= 0; i--) {
        res[i] *= right;
        right *= nums[i];
         }
    return res;
    }
```
自己做的时候算错了，以为这样不是O（n），不过确实也很巧妙。第一遍遍历算i左边的累积，第二遍算i右边的累积。得出结果。
<!-- more -->

### 152	Maximum Product Subarray
```
public int maxProduct(int[] nums) {
    int maxSum = nums[0];
    int currentMax = nums[0];
    int currentMin = nums[0];

    for (int i = 1; i < nums.length; i++) {
        if (nums[i] < 0){
        int tmp = currentMax;
        currentMax = currentMin;
        currentMin = tmp;
        }

        currentMax = Math.max(nums[i], currentMax * nums[i]);
        currentMin = Math.min(nums[i], currentMin * nums[i]);
        maxSum = Math.max(maxSum, currentMax);
    }
        return maxSum;
    }
```
如果小于0则交换currentMax和min，将到现在为止最大和最小的乘积都保存下来。注意比较的是nums[i]和nums[i]*currentMax/min，这样相当于可以从nums[i]重新开始算乘积。

### 228	Summary Ranges
```
public List<String> summaryRanges(int[] nums) {
        List<String> list=new ArrayList();
	if(nums.length==1){
		list.add(nums[0]+"");
		return list;
	}
    for(int i=0;i<nums.length;i++){
    	int a=nums[i];
    	while(i+1<nums.length&&(nums[i+1]-nums[i])==1){
    		i++;
    	}
    	if(a!=nums[i]){
    		list.add(a+"->"+nums[i]);
    	}else{
    		list.add(a+"");
    	}
    }
    return list;
    }
```
如果能构成连续的就一直走到底。如果走过了就输出->， 没走过就输出原有的a。太巧妙。

### 163	Missing Ranges
```
 vector<string> findMissingRanges(vector<int>& nums, int lower, int upper) {
        vector<string> res;
        int l = lower;
        for (int i = 0; i <= nums.size(); ++i) {
            int r = (i < nums.size() && nums[i] <= upper) ? nums[i] : upper + 1;
            if (l == r) ++l;
            else if (r > l) {
                res.push_back(r - l == 1 ? to_string(l) : to_string(l) + "->" + to_string(r - 1));
                l = r + 1;
            }
        }
        return res;
    }
```
我们首先将lower赋给l，然后开始遍历nums数组，如果i小于nums长度且当前数字小于等于upper，我们让r等于当前数字，否则如果当i等于nums的长度时或者当前数字大于upper时，将r赋为upper+1。然后判断l和r的值，若相同，l自增1，否则当r大于l时，说明缺失空间存在，我们看l和r是否差1，如果是，说明只缺失了一个数字，若不是，则说明缺失了一个区间，我们分别加上数字或者区间即可。

### 88	Merge Sorted Array
```
public void merge(int[] nums1, int m, int[] nums2, int n) {
   int i=m-1, j=n-1, k=m+n-1;
    while (i>-1 && j>-1) nums1[k--]= (nums1[i]>nums2[j]) ? nums1[i--] : nums2[j--];
    while (j>-1)         nums1[k--]=nums2[j--];
    }
```
精妙之处在于两个while的条件。首先肯定如果i先遍历完，j还没有遍历完的话，是可以在下个循环全部插入的。 如果j先遍历完，说明插入完成，剩下的i已经在nums1里了，这就是巧妙之处。