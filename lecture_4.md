##lecture 4

####View 

Views 都是分等级的。

UIWindow 没有external screen，否则就一直就只有一个UIView。


	addSubview(aView: UIView) // sent to aView's superview
	removeFromSuperView //sent to the view you want to remove
	
	func setup() { ... }	override init(frame: CGRect) { // a designed initializer
	super.init(frame: frame)	setup()	}
		requiredinit(coderaDecoder:NSCoder){ //arequiredinitializer
	super.init(coder: aDecoder)	setup()	}
	

#### CG
CGFloat draw的时候用，CG（core graphics）Float

CGPoint   x，y

CGSize    width, height

CGRect    

	struct CGRect {       var origin: CGPoint       var size: CGSize
       }
       
       let rect = CGRect(origin: aCGPoint, size: aCGSize) // there are other inits as well

#### Coordinate System 

Coordinate System : Units are points, not pixels

contentScaleFactor -> how many pixels per point

	var bounds: CGRect // a view’s internal drawing space’s origin and size
  
	var center: CGPoint // the center of a UIView in its superview’s coordinate system
		var frame: CGRect // the rect containing a UIView in its superview’s coordinate system
	
Use frame and/or center to position a UIView, then use bounds.

frame 和 bounds不同之处还有比如rotate 一个view具有的bounds和frame 就不一样


####Create View via code:

	let newView = UIView(frame: myViewFrame)
	let newView = UIView()
	
用代码的方法来创建一个UILabel

	let labelRect = CGRect(x:20, y:20, width: 100, height:  50)
	let label = UILabel(frame:labelRect)
	label.text = "Hello"
	view.addSubview(label)

#### Draw

	override func drawRect(regionThatNeedsToBeDrawn: CGRect)
	
never call drawRect！ 

call

	setNeedsDisplay()
	setNeedsDisplayInRect(regionThatNeedsToBeDrawn: CGRect)

画一个三角形的典型code

	let path = UIBezierPath()
	
	path.moveToPoint(CGPoint(x: 80,y: 50))
	path.addLineToPoint(CGPoint(x: 140,y: 150))
	path.addLineToPoint(CGPoint(x: 10,y: 150))
	
	path.closePath()
	
	UIColor.greenColor().setFill()
	UIColor.redColor().setStroke()
	path.lineWidth = 3.0
	path.fill()
	path.stroke()

别的方法

	let roundRect = UIBezierPath(roundedRect: aCGRect, cornerRadius: aCGFloat) 
	let oval = UIBezierPath(ovalInRect: aCGRect)
	
	addClip()
For example, you could clip to a rounded rect to enforce the edges of a playing card.

Hit detection
func containsPoint(CGPoint) -> Bool // returns whether the point is inside the path 
The path must be closed. The winding rule can be set with usesEvenOddFillRule property.
#### UIColor
You can also create them from RGB, HSB or even a pattern (using UIImage)greenColor() 是type method，用它来取得instance，所以colorWith...就是instance method.


#### Transparency
	let transparentYellow = UIColor.yellowColor().colorWithAlphaComponent(0.5) 	var opaque = false	//Alpha is between 0.0 (fully transparent) and 1.0 (fully opaque)
	整个view都可以是transparent的.
fade out/ fade in 用alpha
var hidden : Bool
#### Draw Text
	let text = NSAttributedString(“hello”)	text.drawAtPoint(aCGPoint)	let textSize: CGSize = text.sizeNSAttributedString
#### Font

user内容-> 选preferredFont 
	class func preferredFontForTextStyle(UIFontTextStyle) -> UIFont
	UIFontTextStyle.Headline  	UIFontTextStyle.Body 	UIFontTextStyle.Footnote
 	
#### Draw Image	let image: UIImage? = UIImage(named: “foo”) // note that its an Optional
		image.drawAtPoint(aCGPoint) // the upper left corner of the image put at 	aCGPoint image.drawInRect(aCGRect) // scales the image to fit aCGRect 	image.drawAsPatternInRect(aCGRect) // tiles the image into aCGRect

#### Redraw on bounds change

#### Demo