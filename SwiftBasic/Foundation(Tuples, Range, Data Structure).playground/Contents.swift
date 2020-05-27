/*What is a tuple?*/
/*It is nothing more than a grouping of values.
  You can use it anywhere you can use a type.*/

let x: (String, Int, Double) = ("Hello", 5, 0.85)
let (word, number, value) = x // tuple element named when accessing the tuple
print(word)
print(number)
print(value)

// ... or the tuple elements can be named when the tuple is declared ...

let x1: (w: String, i: Int, v: Double) = ("hello", 5, 0.85)
print(x1.w)
print(x1.i)
print(x1.v)

let(wrd, num, val) = x1 // this is also legal (renamed the tuple's elements on access

/*Returning multiple values from a function*/
func getSize() -> (weight: Double, height: Double) { return (250, 80) }

let x2 = getSize()
print("weight is \(x2.weight)")
print("height is \(getSize().height)")


/*Range*/
/*A Range in Swift is just two end points. Range is generic (e.g. Range<T>)
  This is sort of a pseudo-representation of Range: */
struct Range<T>{
    var startIndex: T
    var endIndex: T
}

// An Array's range would be a Range<Int> (since Arrays are indexed by Int)
// Warning: A String subrange is not Range<Int> (it is Range<String.Index>

// There is special syntax for specifying a Range: either ... (inclusive) or ..< (open-ended)

let array = ["a", "b", "c", "d"]
let subArray1 = array[2...3] // ["c", "d"]
let subArray2 = array[2..<3] // ["c"]
for i in 27...104 {  }  // Range is enumeratable, like Array, String, Dictionary

/*Data Structures in Swift*/
/*These are the 3 fundamental building blocks of data structures in Swift*/
// Similarities : Declaration Syntax, Properties and Functions, Initializers
// Differences : Inheritance (class only), Value type (struct, enum) vs. Reference type (class)

/*Value vs. Reference*/
/*Value (struct and enum)*/
// Copied when passed as an argument to a function
// Copied when assigned to a different variable
// Immutable if assigned to a variable with let
// Remember that function parameters are constants
// You must note any func that can mutate a struct/enum with the keyword mutating

/*Referencfe (class)*/
// Stored in the heap and reference counted (automatically)
// Constant pointers to a class (let) still can mutate by calling methods and changing properties

/*Choosing which to use?*/
// Usually you will choose class over struct.
// Struct tends to be more for fundamental types.
// Use of enum is situational (any time you have a type of data with discrete values).


