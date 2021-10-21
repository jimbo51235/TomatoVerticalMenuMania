//
//  BaseViewController.swift
//  TomatoVerticalMania
//
//  Created by Tomato on 2021/10/20.
//

import UIKit
import TomatoVerticalManiaFramework

class BaseViewController: TomatoVerticalManiaViewController {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
		super.init(nibName: nil, bundle: nil)
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	
	var menuHidden = false
	let hideBackButton = false
	let animationDur: TimeInterval = 0.5
	let hasAutoLayout = true
	let hasMenu = true
	func setup(index: Int) {
		if let _ = navigationController {
			self.navigationItem.hidesBackButton = hideBackButton
			if hasMenu {
				self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(hideMenu))
			}
		}
		
		let menu0 = TomatoVerticalMenuModel(menuName: "Play", menuIndex: 0, imageName: "PlayImage")
		let menu1 = TomatoVerticalMenuModel(menuName: "Weapons", menuIndex: 1, imageName: "ChestImage")
		let menu2 = TomatoVerticalMenuModel(menuName: "Clock", menuIndex: 2, imageName: "ClockImage")
		let menu3 = TomatoVerticalMenuModel(menuName: "Food", menuIndex: 3, imageName: "CookingImage")
		let menu4 = TomatoVerticalMenuModel(menuName: "Gifts", menuIndex: 4, imageName: "GiftImage")
		let menu5 = TomatoVerticalMenuModel(menuName: "Save", menuIndex: 5, imageName: "SavingImage")
		let menu6 = TomatoVerticalMenuModel(menuName: "Trash", menuIndex: 6, imageName: "TrashImage")
		let menu7 = TomatoVerticalMenuModel(menuName: "Security", menuIndex: 7, imageName: "SecurityImage")
		menuModels = [menu0, menu1, menu2, menu3, menu4, menu5, menu6, menu7]
		
		menuWidth = 70.0
		menuHeight = 70.0
		imageSide = 36.0
		hasInset = true
		insetColor = UIColor.orange
		insetSize = 14.0
		nameLabelFontSize = 14.0
		nameLabelHeight = 14.0
		nameLabelFromBottom = 6.0
		labelTextColor = UIColor.white
		labelBackColor = UIColor.clear
		showVerticalScroll = false
		tomatoVerticalSetup(index: index)
		
		if hasAutoLayout {
			vScrollView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				vScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				vScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
				vScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				vScrollView.widthAnchor.constraint(equalToConstant: menuWidth + insetSize)
			])
			backView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				backView.leftAnchor.constraint(equalTo: view.leftAnchor),
				backView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				backView.widthAnchor.constraint(equalToConstant: menuWidth)
			])
		}
	}
	
	override func menuTapped(_ sender: UITapGestureRecognizer) {
		if let index = sender.view?.tag {
			if index == 0 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else if index == 1 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeaponsViewController") as? WeaponsViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else if index == 2 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClockViewController") as? ClockViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else if index == 3 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodViewController") as? FoodViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else if index == 4 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GiftsViewController") as? GiftsViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else if index == 5 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SaveViewController") as? SaveViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else if index == 6 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrashViewController") as? TrashViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
			else {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecurityViewController") as? SecurityViewController {
					navigationController?.pushViewController(viewController, animated: false)
				}
			}
		}
	}
	
	@IBAction func hideMenu() {
		if menuHidden {
			vScrollView.isHidden = false
			backView.isHidden = false
			UIView.animate(withDuration: animationDur) {
				let scrollFrame = self.vScrollView.frame
				let backFrame = self.backView.frame
				self.vScrollView.frame = CGRect(x: 0, y: scrollFrame.origin.y, width: scrollFrame.size.width, height: scrollFrame.size.height)
				self.backView.frame = CGRect(x: 0, y: backFrame.origin.y, width: backFrame.size.width, height: backFrame.size.height)
			} completion: { (done) in
				self.menuHidden = false
			}
		} else {
			UIView.animate(withDuration: animationDur) {
				let scrollFrame = self.vScrollView.frame
				let backFrame = self.backView.frame
				self.vScrollView.frame = CGRect(x: scrollFrame.origin.x - (self.menuWidth + self.insetSize), y: scrollFrame.origin.y, width: scrollFrame.size.width, height: scrollFrame.size.height)
				self.backView.frame = CGRect(x: backFrame.origin.x - (self.menuWidth + self.insetSize), y: backFrame.origin.y, width: backFrame.size.width, height: backFrame.size.height)
			} completion: { (done) in
				if done {
					self.menuHidden = true
					self.vScrollView.isHidden = true
					self.backView.isHidden = true
				}
			}
		}
	}
}

