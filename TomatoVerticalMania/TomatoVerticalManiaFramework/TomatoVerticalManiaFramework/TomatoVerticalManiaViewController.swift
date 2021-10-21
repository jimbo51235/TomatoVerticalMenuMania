//
//  TomatoVerticalManiaViewController.swift
//  TomatoVerticalMania
//
//  Created by Tomato on 2021/10/20.
//

import UIKit

open class TomatoVerticalManiaViewController: UIViewController {
	public var menuModels = [TomatoVerticalMenuModel]()
	public var vScrollView = UIScrollView()
	public var backView = UIView()
	
	public var verticalBackColor = UIColor(red: 6/255.0, green: 40/255.0, blue: 160/255.0, alpha: 1)
	public var menuWidth: CGFloat = 80.0
	public var menuHeight: CGFloat = 80.0
	public var imageSide: CGFloat = 36.0
	public var hasInset = true
	public var insetColor = UIColor.orange
	public var insetSize: CGFloat = 10.0
	public var nameLabelFontSize: CGFloat = 14.0
	public var nameLabelHeight: CGFloat = 14.0
	public var nameLabelFromBottom: CGFloat = 6.0
	public var labelTextColor = UIColor.white
	public var labelBackColor = UIColor.clear
	public var showVerticalScroll = false
	
	public func tomatoVerticalSetup(index: Int) {
		/* validation */
		if !isHorizontalMenuModelsValid() {
			print("Your vertical model array does not contain unique index numbers.")
			return
		}
		
		/* checking the top position */
		var topHeight: CGFloat = 0.0
		let selfSize = view.bounds.size
		if let navigationController = navigationController, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let statusManager = window.windowScene?.statusBarManager {
			let statusFrame = statusManager.statusBarFrame
			let navigationFrame = navigationController.navigationBar.frame
			topHeight = statusFrame.height + navigationFrame.height
		}
		
		let menuRect = CGRect(x: 0, y: 0, width: menuWidth + insetSize, height: menuHeight * CGFloat(menuModels.count))
		let menuView = UIView(frame: menuRect)
		
		/* background */
		backView = UIView(frame: CGRect(x: 0.0, y: topHeight, width: menuWidth, height: selfSize.height - topHeight))
		backView.backgroundColor = verticalBackColor
		menuView.addSubview(backView)
		
		let markerRect = CGRect(x: 0, y: menuHeight * CGFloat(index), width: menuWidth + insetSize, height: menuHeight)
		let markerView = MarkerView(frame: markerRect, hasInset: hasInset, insetWidth: insetSize, backColor: insetColor)
		markerView.backgroundColor = UIColor.clear
		menuView.addSubview(markerView)
		
		for i in 0..<menuModels.count {
			let model = menuModels[i]
			let tabRect = CGRect(x: 0.0, y: menuHeight * CGFloat(i), width: menuWidth, height: menuHeight)
			let tabView = TopBotView(frame: tabRect)
			tabView.isUserInteractionEnabled = true
			if i != index {
				let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuTapped(_:)))
				tabView.addGestureRecognizer(tapGesture)
				tabView.tag = i
			}
			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(menuTapped(_:)))
			tabView.addGestureRecognizer(tapGesture)
			tabView.tag = i
			
			/* image */
			let image = UIImage(named: model.imageName)
			let imageViewRect = CGRect(x: (menuWidth - imageSide) / 2.0, y: (menuHeight - imageSide) / 2.0 - 12.0, width: imageSide, height: imageSide)
			let imageView = UIImageView(frame: imageViewRect)
			imageView.image = image
			
			/* label */
			let labelRect = CGRect(x: 0.0, y: menuHeight - nameLabelHeight - nameLabelFromBottom, width: menuWidth, height: nameLabelHeight)
			let label = UILabel(frame: labelRect)
			label.font = UIFont.systemFont(ofSize: nameLabelFontSize)
			label.textColor = labelTextColor
			label.text = model.menuName
			label.backgroundColor = labelBackColor
			label.textAlignment = .center
			
			tabView.addSubview(imageView)
			tabView.addSubview(label)
			menuView.addSubview(tabView)
		}
		
		/*
		if index == 0 {
			vScrollView = UIScrollView.init(frame: CGRect(x: 0, y: topHeight, width: menuWidth + insetSize, height: selfSize.height - topHeight))
		} else {
			vScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: menuWidth + insetSize, height: selfSize.height))
		}
		*/
		let scrollRect = CGRect(origin: CGPoint(x: 0.0, y: topHeight), size: CGSize(width: menuWidth + insetSize, height: selfSize.height - topHeight))
		vScrollView = UIScrollView(frame: scrollRect)
		vScrollView.showsVerticalScrollIndicator = showVerticalScroll
		vScrollView.contentSize = CGSize(width: menuWidth, height: menuHeight * CGFloat(menuModels.count))
		vScrollView.addSubview(menuView)
		view.addSubview(backView)
		view.addSubview(vScrollView)
	}
	
	@objc open func menuTapped(_ sender: UITapGestureRecognizer) {
		/*
		if let tag = sender.view?.tag {
			let contentHeight = vScrollView.contentSize.height
			let max = contentHeight - vScrollView.frame.height
			if max - menuHeight * CGFloat(tag) > 0.0 {
				vScrollView.contentOffset = CGPoint(x: 0.0, y: menuHeight * CGFloat(tag))
			} else {
				vScrollView.contentOffset = CGPoint(x: 0.0, y: max)
			}
		}
		*/
	}
	
	
	// MARK: - Validating models
	func isHorizontalMenuModelsValid() -> Bool {
		var array = [Int]()
		for i in 0..<menuModels.count {
			let model = menuModels[i]
			let index = model.menuIndex
			if index >= 0 && index < menuModels.count {
				if !array.contains(index) {
					array.append(index)
				}
			}
		}
		if array.count == menuModels.count {
			return true
		} else {
			return false
		}
	}
}

public struct TomatoVerticalMenuModel {
	public let menuName: String
	public let menuIndex: Int
	public let imageName: String
	
	public init(menuName: String, menuIndex: Int, imageName: String) {
		self.menuName = menuName
		self.menuIndex = menuIndex
		self.imageName = imageName
	}
}

