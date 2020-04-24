//
//  UIViewController+Extension.swift
//  PhotoList
//
//  Created by Robert Moryson on 24/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoadingSpinner() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
}
