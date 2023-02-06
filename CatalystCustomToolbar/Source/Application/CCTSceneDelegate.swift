//
//  CCTSceneDelegate.swift
//  CatalystCustomToolbar
//
//  Created by Steven Troughton-Smith on 06/02/2023.
//  
//

import UIKit

class CCTSceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else {
			fatalError("Expected scene of type UIWindowScene but got an unexpected type")
		}
		window = UIWindow(windowScene: windowScene)
		
		if let window = window {
			window.rootViewController = CCTMainViewController()
			
#if targetEnvironment(macCatalyst)
			
			/*
			 We still set up an empty NSToolbar here to gain the centered window controls and draggability
			 */
			
			let toolbar = NSToolbar(identifier: NSToolbar.Identifier("CCTSceneDelegate.Toolbar"))
			toolbar.delegate = self
			toolbar.displayMode = .iconOnly
			toolbar.allowsUserCustomization = false
			
			windowScene.titlebar?.toolbar = toolbar
			windowScene.titlebar?.toolbarStyle = .unified
			windowScene.titlebar?.autoHidesToolbarInFullScreen = true
			
			/*
			 This is a private enum value and may break in the future, but is essential for custom toolbars.
			 Please file a radar if you need this in your app to let Apple know they should document it (FB9109207).
			 */
			windowScene.titlebar?.titleVisibility = .init(rawValue: 10) ?? .hidden // UITitlebarTitleVisibilityTransparent

#endif
			
			window.makeKeyAndVisible()
		}
	}
}
