//: Playground - noun: a place where people can play

import UIKit

// Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.

let matrix = [[1,2,3,4],
              [5,6,7,8],
              [9,10,11,12]]

// matrix[row][column]\
// travel from 1st to last column
matrix[0][0]
matrix[0][1]
matrix[0][2]
matrix[0][3]

// travel from 1st to last row
matrix[0][0]
matrix[1][0]
matrix[2][0]


// use notion of count to avoid "range out of index"
let matrixColumnsCount = matrix[0].count
let matrixRowsCount = matrix.count

// Note, this assumes all arrays of ints have the same number of items
func columnsCount(for matrix: [[Int]]) -> Int {
   return matrix[0].count
}

func rowsCount(for matrix: [[Int]]) -> Int {
   return matrix.count
}

rowsCount(for: matrix)
columnsCount(for: matrix)

// Print first int in each column accending
for index in 0..<columnsCount(for: matrix) {
   //print(matrix[0][index])
}
// prints 1, 2, 3, 4

// Print first int in each row
for index in 0..<rowsCount(for: matrix) {
   //print(matrix[index][0])
}
// prints 1, 5, 9

// traverse rows
func traverseRowsAscending(inMatrix matrix: [[Int]], forColumnIndex columnIndex: Int) -> [Int] {
   var result: [Int] = []
   for rowIndex in 0..<rowsCount(for: matrix) {
      result.append(matrix[rowIndex][columnIndex])
   }
   return result
}

traverseRowsAscending(inMatrix: matrix, forColumnIndex: 0)
// Returns [1, 5, 9]

// test stride loop (ascending)
for index in stride(from: 0, through: 10, by: 1) {
   // print(index)
}

// test stride loop (descending)
for index in stride(from: 0, through: 2, by: -1) {
   //print(index)
}

// Enum to assign raw value to traversal direction
enum Direction: Int {
   case rightwards, downwards, leftwards, upwards
}

Direction.rightwards.rawValue
Direction.downwards.rawValue

// Traverse rows in decsending or acsending order given min and max range values
func traverseRows(in matrix: [[Int]], min: Int, max: Int, direction: Direction, column: Int) -> [Int] {
   var result: [Int] = []
   var from = 0
   var through = 0
   var by = 0
   switch direction {
   case .rightwards, .downwards:
      from = min
      through = max
      by = direction.rawValue
   case .leftwards, .upwards:
      from = max
      through = min
      by = direction.rawValue
   }
   for index in stride(from: from, through: through, by: by) {
      result.append(matrix[index][column])
   }
   return result
}

let testMatrixOne = [[1,2,3,4],
                     [5,6,7,8],
                     [9,10,11,12]]

// test traverse rows in acsending order
traverseRows(in: testMatrixOne, min: 0, max: rowsCount(for: testMatrixOne)-1, direction: .downwards, column: 0)
// returns [1, 5, 9]

// test traverse rows in decsending order
traverseRows(in: testMatrixOne, min: 0, max: rowsCount(for: testMatrixOne)-1, direction: .upwards, column: 0)
// returns [9, 5. 1]

// create method that can traverse columns or rows
enum MatrixItem {
   case rows
   case columns
}

// Traverse rows or columns of a matrix in acsending or decsending order in respect to min and max offsets
// returns an array of integer values form traversed rows or coluns respectively
// perpindicularMatrixItemIndex represents the index of the opposite matrix item that is being transversed...
// ...so if transversing rows this is the column index and visa versa
func traverse(_ matrixItem: MatrixItem, in matrix: [[Int]], min: Int, max: Int, direction: Direction, perpindicularMatrixItemIndex perpIndex: Int) -> [Int] {
   var result: [Int] = []

   // Calculate the range based on ascending or decsending including any offsets
   var from = 0
   var through = 0
   var by = 0
   switch direction {
   case .rightwards, .downwards:
      from = min
      through = max
      by = 1
   case .leftwards, .upwards:
      from = max
      through = min
      by = -1
   }

   // Iterate through values in each row or column and return array of values
   for index in stride(from: from, through: through, by: by) {
      switch matrixItem {
      case .rows:
         result.append(matrix[index][perpIndex])
      case .columns:
         result.append(matrix[perpIndex][index])
      }
   }
   return result
}

// Test min and max
traverse(.rows, in: testMatrixOne, min: 0, max: rowsCount(for: testMatrixOne)-1, direction: .downwards, perpindicularMatrixItemIndex: 0)
// returns [1, 5, 9]

traverse(.rows, in: testMatrixOne, min: 0, max: rowsCount(for: testMatrixOne)-1, direction: .upwards, perpindicularMatrixItemIndex: 0)
// returns [9, 5, 1]

traverse(.columns, in: testMatrixOne, min: 0, max: columnsCount(for: testMatrixOne)-1, direction: .rightwards, perpindicularMatrixItemIndex: 0)
// returns [1, 2, 3, 4]

traverse(.columns, in: testMatrixOne, min: 1, max: 1, direction: .leftwards, perpindicularMatrixItemIndex: 1)
// returns [4, 3, 2, 1]

// Test offsets
traverse(.rows, in: testMatrixOne, min: 1, max: rowsCount(for: testMatrixOne)-1, direction: .downwards, perpindicularMatrixItemIndex: 0)


// SPIRAL ORDER FUNCTION
func spiralOrder(_ matrix: [[Int]]) -> [Int] {
   var result: [Int] = []
   guard !matrix.isEmpty else { return result }

   // Variables to keep track of rows and columns that have been previously transversed
   var rowMin = 0
   var rowMax = rowsCount(for: matrix) - 1
   var columnMin = 0
   var columnMax = columnsCount(for: matrix) - 1

   // If the values for min and max have swaped, i.e. min>max for both, we've gone through all "layers" of the matrix
   while rowMin <= rowMax && columnMin <= columnMax {
      // Transverse in clockwise order rightwards across columns from (row: 0, column: 0)
      // Rightwards columns
      let rightwardsColumns = traverse(.columns, in: matrix, min: columnMin, max: columnMax, direction: .rightwards, perpindicularMatrixItemIndex: rowMin)
      result += rightwardsColumns
      rowMin += 1
      print("rightwardsRows: \(rightwardsColumns), colMin: \(columnMin), colMax: \(columnMax), rowMin: \(rowMin), rowMax: \(rowMax)")

      // Downwards rows
      let downwardsRows = traverse(.rows, in: matrix, min: rowMin, max: rowMax, direction: .downwards, perpindicularMatrixItemIndex: columnMax)
      result += downwardsRows
      columnMax -= 1
      print("downwardsRows: \(downwardsRows), colMin: \(columnMin), colMax: \(columnMax), rowMin: \(rowMin), rowMax: \(rowMax)")

      // leftwards columns
      let leftwardsColumns = traverse(.columns, in: matrix, min: columnMin, max: columnMax, direction: .leftwards, perpindicularMatrixItemIndex: rowMax)
      result += leftwardsColumns
      print("leftwardsColumns: \(leftwardsColumns), colMin: \(columnMin), colMax: \(columnMax), rowMin: \(rowMin), rowMax: \(rowMax)")
      rowMax -= 1

      // upwards rows
      let upwardsRows = traverse(.rows, in: matrix, min: rowMin, max: rowMax, direction: .upwards, perpindicularMatrixItemIndex: columnMin)
      print("upwardsRows: \(upwardsRows), colMin: \(columnMin), colMax: \(columnMax), rowMin: \(rowMin), rowMax: \(rowMax)")
      columnMin += 1
   }

   return result
}

/*
[[1,2,3,4],
 [5,6,7,8],
 [9,10,11,12]]
*/

// Should return: [1,2,3,4,8,12,11,10,9,5,6,7]
spiralOrder(testMatrixOne)


