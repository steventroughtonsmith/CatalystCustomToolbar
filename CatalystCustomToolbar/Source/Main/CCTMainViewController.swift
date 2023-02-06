//
//  CCTMainViewController.swift
//  CatalystCustomToolbar
//
//  Created by Steven Troughton-Smith on 06/02/2023.
//  
//

import UIKit
import AppleUniversalCore

final class CCTMainViewController: UIViewController {
	
	let toolbarController = CCTCustomToolbarViewController()
	let toolbarHeight = UIFloat(70)

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "CatalystCustomToolbar"
		
		view.backgroundColor = .systemBackground
		view.addSubview(toolbarController.view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	// MARK: -
	
	override func viewDidLayoutSubviews() {
		
		let additionalSafeDelta = UIDevice.current.userInterfaceIdiom == .mac ? 0 : view.safeAreaInsets.top
		let division = view.bounds.divided(atDistance: toolbarHeight + additionalSafeDelta, from: .minYEdge)
		toolbarController.view.frame = division.slice
	}
}
