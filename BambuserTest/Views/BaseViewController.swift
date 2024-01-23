//
//  BaseViewController.swift
//  BambuserTest
//
//  Created by test on 23/01/2024.
//

import UIKit

class BaseViewController: UIViewController {

    static let STYLE_CHANGED: Notification.Name = Notification.Name("STYLE_CHANGED")
    
    static var applicationUserInterfaceStyle: UIUserInterfaceStyle = UIUserInterfaceStyle.light
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.styleChanged), name: Self.STYLE_CHANGED, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.overrideUserInterfaceStyle = Self.applicationUserInterfaceStyle
    }
    
    @IBAction func styleChanged() {
        self.overrideUserInterfaceStyle = Self.applicationUserInterfaceStyle
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
