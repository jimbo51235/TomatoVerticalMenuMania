//
//  PentagonView.swift
//  TestWhateverX8
//
//  Created by Tom Bluewater on 12/18/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import UIKit

class MarkerView: UIView {
	let hasInset: Bool
	let insetWidth: CGFloat
	let backColor: UIColor
	
	init(frame: CGRect, hasInset: Bool, insetWidth: CGFloat, backColor: UIColor) {
		self.hasInset = hasInset
		self.insetWidth = insetWidth
		self.backColor = backColor
		super.init(frame: frame)
    }
    
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
	override func draw(_ rect: CGRect) {
		let size = self.bounds.size
		
		if hasInset {
			let p1 = self.bounds.origin // top-left
			let p2 = CGPoint(x: p1.x + size.width, y: p1.y) // top-right
			let p3 = CGPoint(x: size.width - insetWidth, y: size.height / 2.0) // inset
			let p4 = CGPoint(x: p1.x + size.width, y: size.height) // bottom-right
			let p5 = CGPoint(x: p1.x, y: size.height) // bottom-left
			
			// create the path
			let path = UIBezierPath()
			path.move(to: p1)
			path.addLine(to: p2)
			path.addLine(to: p3)
			path.addLine(to: p4)
			path.addLine(to: p5)
			path.close()
			
			// fill the path
			backColor.set()
			path.fill()
		} else {
			let p1 = self.bounds.origin // top-left
			let p2 = CGPoint(x: p1.x + size.width - insetWidth, y: p1.y) // top-right
			let p3 = CGPoint(x: p1.x + size.width - insetWidth, y: size.height) // bottom-right
			let p4 = CGPoint(x: p1.x, y: size.height) // bottom-left
			
			// create the path
			let path = UIBezierPath()
			path.move(to: p1)
			path.addLine(to: p2)
			path.addLine(to: p3)
			path.addLine(to: p4)
			path.close()
			
			// fill the path
			backColor.set()
			path.fill()
		}
	}
}

// http-//stackoverflow.com/questions/34777992/how-to-create-unique-shapes-or-uiviews-in-swift
