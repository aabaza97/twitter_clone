//
//  UIElements.swift
//  twitter_clone
//
//  Created by Ahmed Abaza on 04/02/2021.
//

import UIKit

class UIComponents {
    static let shared = UIComponents()
    
    func createContainerViewForInput(with image: UIImage? = nil, and input: UITextField? = nil) -> UIView {
        let view = UIView()
        let imgView = UIImageView()
        let separator = UIView()
        
        
        imgView.image = image
        separator.backgroundColor = .white
        
        view.addSubview(imgView)
        
        view.setHeight( 50)
        imgView.setDimensions(width: 24, height: 24)
        imgView.anchor(left: view.leftAnchor,
                       bottom: view.bottomAnchor,
                       marginBottom: 12
        )
        
        guard let input = input else {
            return view
        }
        
        view.addSubview(input)
        input.anchor(left: imgView.rightAnchor,
                     bottom: view.bottomAnchor,
                     right: view.rightAnchor,
                     marginLeft: 12,
                     marginBottom: 12
        )
        
        
        view.addSubview(separator)
        separator.setHeight( 0.75)
        separator.anchor(left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
        
        return view
    }
    
    func createTextField(with placeholder: String = "",
                         placeholderColor: UIColor = .white,
                         textColor: UIColor = .white,
                         textSize: CGFloat = 17) -> UITextField {
        
        let txt = UITextField()
        txt.textColor = textColor
        txt.font = UIFont.systemFont(ofSize: textSize)
        txt.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return txt
        
    }
    
    func createAttrStrButton(thin firstPart: String, bold secondPart: String) -> UIButton {
        let btn = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart,
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondPart,
                                                  attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                               NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        btn.setAttributedTitle(attributedTitle, for: .normal)
        return btn
    }
    
    ///Sets up a UINavigationController for a UIViewController with a TabbarItem image.
    func setupNavControllerForTabbarItem(with controller: UIViewController, and image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}
