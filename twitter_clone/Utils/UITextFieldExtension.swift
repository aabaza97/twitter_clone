//
//  UITextFieldExtension.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 04/02/2021.
//

import UIKit

extension UITextField {
    func setLeftIcon(_ icon: UIImage, padding: CGFloat, size: CGFloat) {

        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)

        leftView = outerView
        leftViewMode = .always
    }
}
