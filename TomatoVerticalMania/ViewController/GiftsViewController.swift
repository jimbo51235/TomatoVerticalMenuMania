//
//  GiftsViewController.swift
//  TomatoVerticalMania
//
//  Created by Tomato on 2021/10/20.
//

import UIKit

class GiftsViewController: BaseViewController {
	// MARK: - Variables
	
	
	// MARK: - IBOutlet
	
	
	// MARK: - IBAction
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIView.setAnimationsEnabled(false)
		setup(index: 4)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	deinit {
		print("deinit is called by GiftsViewController")
	}
}

