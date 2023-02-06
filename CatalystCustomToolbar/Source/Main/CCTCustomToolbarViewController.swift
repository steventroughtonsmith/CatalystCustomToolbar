//
//  CCTCustomToolbarViewController.swift
//  CatalystCustomToolbar
//
//  Created by Steven Troughton-Smith on 06/02/2023.
//

import UIKit
import AppleUniversalCore

class CCTCustomToolbarViewController: UIViewController {
	let stackView = UIStackView()
	let padding = UIFloat(13)
	let windowControlsPadding = UIDevice.current.userInterfaceIdiom == .mac ? UIFloat(100) : .zero
	
	// MARK: - Dummy toolbar for demo purposes — you can ignore this
	
	init() {
		super.init(nibName: nil, bundle: nil)
		
		view.backgroundColor = .secondarySystemFill
		
		func _dummyButton(title:String) -> UIButton {
			let button = UIButton(type: .custom)
			button.setTitle(title, for: .normal)
			button.preferredBehavioralStyle = .pad
			button.configuration = .borderedProminent()
			
			return button
		}
		
		stackView.addArrangedSubview(_dummyButton(title: "Play"))
		stackView.addArrangedSubview(_dummyButton(title: "Pause"))
		
		let titleView = UILabel()
		titleView.text = "Testificate"
		titleView.textAlignment = .center
		stackView.addArrangedSubview(titleView)
		
		stackView.addArrangedSubview({
			let slider = UISlider()
			slider.value = 0.7
			return slider
		}())
		stackView.addArrangedSubview(_dummyButton(title: "AirPlay"))
		
		
		stackView.insetsLayoutMarginsFromSafeArea = false
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: windowControlsPadding+padding, bottom: padding, trailing: padding)
		stackView.spacing = padding
		stackView.distribution = .fillEqually
		
		view.addSubview(stackView)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout — Including macOS Fullscreen check
	
	override func viewDidLayoutSubviews() {
		stackView.frame = UIDevice.current.userInterfaceIdiom == .mac ? view.bounds : view.bounds.inset(by: view.safeAreaInsets)
		
		if UIDevice.current.userInterfaceIdiom == .mac {
		
			var isFullscreen = false
			if #available(iOS 16.0, *) {
				if view.window?.windowScene?.isFullScreen == true {
					isFullscreen = true
				}
			}
			
			/*
			 We're in macOS fullscreen mode — window controls are hidden.
			 NOTE: You should also be thinking about RTL layouts here if not relying on leading/trailing constraints
			 */
			if isFullscreen || view.window?.safeAreaInsets.top == 0 {
				stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
			}
			else {
				stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: windowControlsPadding+padding, bottom: padding, trailing: padding)
			}
		}
	}
}
