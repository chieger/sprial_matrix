# sprial_matrix

Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.

### Example 1:

**Input:**

[
 [ 1, 2, 3 ],<br>
 [ 4, 5, 6 ],<br>
 [ 7, 8, 9 ]
]

**Output:** [1,2,3,6,9,8,7,4,5]

### Example 2:

**Input:**

[
  [1, 2, 3, 4],<br>
  [5, 6, 7, 8],<br>
  [9,10,11,12]
]

**Output:** [1,2,3,4,8,12,11,10,9,5,6,7]

---

### Notes

1. The index of an array represents the given "row" of the matrix
   - Example:
    ```
    [
       [1, 2, 3, 4],<br>
       [5, 6, 7, 8],<br>
       [9,10,11,12]
    ]
    ```
   - `1`, `2`, `3` & `4` are all in row 0 because they are all contained within the array at index `0`
   - Similarly, `5`, `6`, `7`, & `8` are all in row 1 for the same reason ☝️
1. The index of an integer within it's array represents it's given "column"
   - Example:
    ```
    [
       [1, 2, 3, 4],<br>
       [5, 6, 7, 8],<br>
       [9,10,11,12]
    ]
    ```
   - `1`, `5` & `9` are all in column `0` becasue they exist at index `0` of their respective arrays
1. (>) A spriral "clockwise" spiral starting from the upper left, would travel from the first integer in each column (**accending** collumns), 1st to last column.
2. (v) Then **assend** each row (first+1 -> last) (remaining in the current column)
3. (<) Remaining in the last row, then **decend** columns, last-1 to first
2. (^) Remaining in the first column, **decend** rows, last-1 to first+1

### Thoughts
1. General Pattern
   1. Accend column
   1. Accend row
   1. Decend column
   1. Decend row
   1. repeat
   
