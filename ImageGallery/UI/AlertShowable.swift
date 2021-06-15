//
//  AlertShowable.swift
//  ImageGallery
//
//  Created by Dmitry Smetankin on 15.06.2021.
//

import UIKit

protocol AlertShowable {
    func showAlert(title: String, message: String)
}

extension AlertShowable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertViewController, animated: true)
    }
}

