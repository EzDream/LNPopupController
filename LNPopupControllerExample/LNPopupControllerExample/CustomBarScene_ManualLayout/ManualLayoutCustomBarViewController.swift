//
//  ManualLayoutCustomBarViewController.swift
//  LNPopupControllerExample
//
//  Created by Leo Natan on 9/1/20.
//  Copyright © 2015-2021 Leo Natan. All rights reserved.
//

#if LNPOPUP
@objc public class ManualLayoutCustomBarViewController: LNPopupCustomBarViewController {
	let centeredButton = UIButton(type: .system)
	let leftButton = UIButton(type: .system)
	let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		view.autoresizingMask = []
		
		backgroundView.layer.masksToBounds = true
		backgroundView.layer.cornerCurve = .continuous
		backgroundView.layer.cornerRadius = 15
		view.addSubview(backgroundView)
		
		centeredButton.setTitle("Centered", for: .normal)
		centeredButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		centeredButton.sizeToFit()
		view.addSubview(centeredButton)
		
		leftButton.setTitle("<- Left", for: .normal)
		leftButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		leftButton.sizeToFit()
		view.addSubview(leftButton)
		
		preferredContentSize = CGSize(width: 0, height: 50)
	}
	
	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		let insetLeft = CGFloat.maximum(view.safeAreaInsets.left, 20)
		let insetRight = CGFloat.maximum(view.safeAreaInsets.right, 20)
		
		backgroundView.frame = CGRect(x: insetLeft, y: 2, width: view.bounds.width - insetLeft - insetRight, height: view.bounds.height - 4)
		centeredButton.center = backgroundView.center
		leftButton.frame = CGRect(x: insetLeft + 20, y: backgroundView.center.y - leftButton.bounds.size.height / 2, width: leftButton.bounds.size.width, height: leftButton.bounds.size.height)
		
		print("\(self) margins: \(view.layoutMargins) safe: \(view.safeAreaInsets)")
	}
	
	public override var wantsDefaultTapGestureRecognizer: Bool {
		return false
	}
	
	public override var wantsDefaultPanGestureRecognizer: Bool {
		return false
	}
	
	public override var wantsDefaultHighlightGestureRecognizer: Bool {
		return false
	}
}
#endif
