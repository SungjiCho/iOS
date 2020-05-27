import UIKit

var str = "Hello, playground"


/*Methods*/

// Parameters Names
// All Parameters to all function have an internal name and an external name.
// The internal name is the name of the local variable you use inside the method
// The external name is what callers use when they call the method
// You can put _ if you don't want callers to use an external name at all for a giaven parameter
// This is the defualt for the first parameter (except in initializers!)
// For other (not the first) parameters, the internal name is, by default, the external name
// Any parameter's external name can be changed (even forcing the first parameter to have one)
// It is generally "anti-Swift" to force a first parameter name or suppress other parameters names

func foo(externalFrist first: Int, externalSecond second: Double){
    var sum = 0.0
    for _ in 0..<first { sum += second }
}

func bar(){
    let result = foo(externalFrist: 123, externalSecond: 5.5)
}


/*Obviously you can override methods/properties in your superclass*/
// Precede your func or var with the keyword override
// A method can be marked final which will prevent subclasses from being able to override Classes can also be marked final
/*Both types and instances can have methods/properties*/
// For this example, lets consider using the struct Double (yes, Double is a struct)
var d: Double = 0.0

if d.isZero{
    d = Double.pi
}

// isZero is an instance property of a Double (you send it to a particular Double)
// pi is a type method of Double (you send it to the type itself, not to a particular Double)
// You declare a type method or property with a static prefix ...
func abs(d: Double) -> Double{ return -d  }


/*Properties*/
/*Property Observers*/
// You can observe changes to any property with willSet and didSet
// Will also be invoked if you mutate a struct (e.g. add something to a dictionary)

var someStoreProperty: Int = 42 {
    willSet { 0 } // newValue is the new Value
    didSet { 10 } // oldValue is the old value
}

//override var inheritedProperty{
//    willSet { 0 } // newValue is the new Value
//    didSet { 10 } // oldValue is the old value
//}

//var operations: Dictionary<String, Operation> = [ ... ] {
//    willSet { will be executed if an operation is added/removed }
//    didSet { will be executed if an operation is added/removed }
//}

/*Lazy Initialization*/
// A lazy property does not get initialized until someone accesses it
// You can allocate an object, execute a closure, or call a method if you want

// lazy var brain = CalculatorBrain() // nice if CalculatorBrain used lots of resources
//lazy var someproperty: Type = {
//   // constructed the value of someproperty
//   return <the consturcted value>
//}()

// lazy var myProperty = self.initializeMyProperty()

/*This still satisfies the "you must initialize all of your properties" rule
  Unfortunately, things initialized this way can't be constants (i.e. var ok, let not okay)
  This can be used to get around some initialization dependency conundrums
 */
