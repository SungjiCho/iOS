
/*An Optional is just an enum!*/
enum Optional<T>{  // the <T> is a generic like as in Array<T>
    case None
    case Some(T)
}

let x11: String? = nil
// ... is ...
let x12 = Optional<String>.None

let x21: String? = "Hello Swift"
// ... is ...
let x22 = Optional<String>.Some("Hello Swift")

let x31: Int? = 0
// ... is ...
let x32 = Optional<Int>.Some(0)


var y = x32
print(y)
// ... is ...
switch x32 {
case .Some(let value):
    let y = value
    print(y)
case .None:
    fatalError("Raise an Exception")
}


/*Optional can be "chained"!*/
/*For example, hashValue is a var in String which is an Int.
  What if we wanted to get the hashValue from something which was an Optional String?
  And what if that Optional String was, itself, contained in an Optional UILabel display?
 */
import UIKit

var display: UILabel? // imagine this is an @IBOutlet without the implicit unwrap !
if let label = display{
    if let text = label.text{
//        let x = text.hashValue{
//            // ...
//        }
    }
}
// ... or ...
if let x = display?.text?.hashValue { // ...
}


/*There is also an Optional "defaulting" operator ??*/
/*What if we want to put a String into a UILabel, but if it's nil, put " " (space) in the UILabel?*/

let s: String? = nil  // might be nil
if s != nil{
    display!.text = s
}else{
    display!.text = " "
}

// ... can be expressed much more simply this way ...
display?.text = s ?? " "
