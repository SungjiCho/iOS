
/*AnyObject*/

/*AnyObject is a special type (actually it's a protocol)*/
// Used to be commonly used for compatibility with old Objective-C APIs
// But not so much anymore in iOS9 since those old Objective-C APIs have been updated
// A variable of type AnyObject can point to any class, but you don't know which
// A variable of type AnyObject cannot hold a struct or an enum
// There is another type, Any, which can hold anything (very rarely used)

/*Where will you see it?*/
// Sometimes it will be an argument to a function that can actually take any class ...
//func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject)
//func touchDigit(sender: AnyObject)
//Or when you want to return an object and tou don't want the caller to know its class ...
var cookie: AnyObject

/*How do we use a variable of type AnyObject?*/
// We can't usually use it directly (since we don't know what class it is)
// Instead, we must convert it to another, known class (or protocol)

// This conversion might not be possible, so the conversion generates an Optional
// Conversion is done with the as? keyword in Swift (or as! to force unwrap the Optional)
// You can also check to see if something can be converted with the is keyword (true/false)

// We usually use as? it with if let ...

//let ao: AnyObject
//if let foo = ao as? SomeClass{
    // We can use foo and know that it is of type SomeClass in here
//}

import UIKit

// @IBAction
func touchDigit(sender: AnyObject){
    if let sendingButton = sender as? UIButton{
        let digit = sendingButton.currentTitle!
    }else if let sendingSlider = sender as? UISlider{
        let digit = String(Int(sendingSlider.value))
    }
}

/*Property List*/
/*Another use of AnyObject*/
// Property List is really just the definition of a term
// It means an AnyObject which is known to be a collection of objects which are ONLY one of  String, Array, Dictionary, a number (Double, Int, etc.), NSDate, NSData
// e.g. a Dictionary whose keys were String and values were Array of NSDate is one

// But wait! String, Array, Dictionary, Double ... these are all structs, not classes!
// Yes, but they are automatically "bridged" to Objective-C counterparts which are classes
// Objective-C is almost invisibe now in the Swift API to iOS, so we'll skip talking about bridging
// But we will talk about Property List and even give an example of it

// Property List are used to pass generic data structures around "blindly"
// The semantics of the contents of a Property List are known only to its creator.
// Everyone else just passes it around as AnyObject and doesn't know what's inside.
// Let's look at an iOS API that does this: NSUserDefaults ...

/*NSUserDefaults*/
/*A Storage mechanism for Property List data*/
// NSUserDefaults is essentially a very tiny database that stores Property List data.
// It persists between lanchings of your application!
// Great for things like "settings" and such.
// Do not use it for anything big!

// It can store/retrieve entire Property Lists by name (keys) ...
//setObject(AnyObject, forKey: String)
//objectForKey(String) -> AnyObject?
//arrayForKey(String) -> Array<AnyObject>? //return nil if you setObject (not-an-array)

// It car also store/retrieve little pieces of data ...
//setDouble(Double, forKey: String)
//doubleForKey(String) -> Double

/*Using NSUserDefaults*/
// Get the defaults reader/writer ...
let defaults = UserDefaults.standard

// Then read and write ...
let plist = defaults.object(forKey: "foo")
defaults.set(plist, forKey: "foo")

// Your changes will be automatically saved.
// But you can be sure they are saved at any time by synchronizing ...
// if !defaults.synchronized() { // failed! but not clear what you can do about it }

/*Casting*/
/*By the way, casting is not just for AnyObject*/
// You can cast with as (or check with is) any object pointer that makes sense
// For example ...
//let vc = UIViewController = CalculatorViewController()
// The type of vc is UIViewController (because we explicitly typed it to be)
// And the assignment is legal because a CalculatorViewController is a UIViewController
// But we can't say, for example, vc.displayValue

// However, if we cast vc, then we can use it ...
//if let calcVC = vc as? CalculatorViewController{
//    let x = calcVC.displayValue
//}
