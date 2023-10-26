//
//  LoginSignupNavigationController.swift
//  TidepoolKitUI
//
//  Created by Darin Krauss on 4/17/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import UIKit
import SwiftUI
import TidepoolKit

class LoginSignupNavigationController: UINavigationController, TLoginSignup {
    public var loginSignupDelegate: TLoginSignupDelegate? {
        get { viewModel.loginSignupDelegate }
        set { viewModel.loginSignupDelegate = newValue }
    }
    public var environment: TEnvironment? {
        get { viewModel.environment }
        set { viewModel.environment = newValue }
    }

    private var viewModel: LoginSignupViewModel

    init(api: TAPI) {
        self.viewModel = LoginSignupViewModel(api: api)

        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)

//        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = .secondarySystemBackground
//        navigationBar.shadowImage = UIColor.clear.image()

        setViewControllers([UIHostingController(rootView: LoginSignupView(viewModel: viewModel))], animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
