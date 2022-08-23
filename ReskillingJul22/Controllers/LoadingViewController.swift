//
//  LoadingViewController.swift
//  ReskillingJul22
//
//  Created by Andres Carmona Ortiz on 23/08/22.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RCValues.sharedInstance.loadingDoneCallback = startAppForReal
    }

}


//MARK: Internal Methods
extension LoadingViewController {
    private func startAppForReal() {
        self.performSegue(withIdentifier: "loadingDoneSegue", sender: self)
    }
}
