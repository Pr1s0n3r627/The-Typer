/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
let numMap = {}; // To store numbers and their indices

for (let i = 0; i < nums.length; i++) {
let complement = target - nums[i]; // Calculate the complement

// If the complement is found in the map, return the indices
if (numMap.hasOwnProperty(complement)) {
return [numMap[complement], i];
}

// Store the current number with its index
numMap[nums[i]] = i;
}
};
