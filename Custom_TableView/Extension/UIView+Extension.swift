//
//  UIView+Extension.swift
//  Custom_TableView
//
//  Created by Govind Sen on 02/09/23.
//

import Foundation
import UIKit

// MARK: - HeightProvider
protocol HeightProvider {
    var height: CGFloat { get }
}

// MARK: - ReuseIdentifierProvider
protocol ReuseIdentifierProvider {
    var reuseIdentifier: String { get }
}

// MARK: - StaticReuseIdentifierProvider
protocol StaticReuseIdentifierProvider {
    static var reuseIdentifier: String { get }
}

// MARK: - NibNameProvider
protocol NibNameProvider {
    static var nibName: String { get }
}

// MARK: - SegueIdentifierProvider
protocol SegueIdentifierProvider {
    var segueIdentifier: String { get }
}

extension UIView: NibNameProvider {
    static var nibName: String { return String(describing: self).components(separatedBy: ".").last! }
}

extension UIView: StaticReuseIdentifierProvider {
    static var reuseIdentifier: String { return String(describing: self).components(separatedBy: ".").last! }
}

extension UICollectionView {
    func registerCell<T: NibNameProvider & StaticReuseIdentifierProvider>(_ cellType: T.Type) {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func registerHeader<T: NibNameProvider & StaticReuseIdentifierProvider>(_ headerType: T.Type) {
        self.register(
            UINib(nibName: headerType.nibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerType.reuseIdentifier)
    }
    
    func registerFooter<T: NibNameProvider & StaticReuseIdentifierProvider>(_ headerType: T.Type) {
        self.register(
            UINib(nibName: headerType.nibName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: headerType.reuseIdentifier)
    }
    
    func dequeueCell<T: NibNameProvider & StaticReuseIdentifierProvider>(_ headerType: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        let cell = self.dequeueReusableCell(withReuseIdentifier: headerType.reuseIdentifier, for: indexPath) as! T
        return cell
    }
}

extension UITableView {
    func registerCell<T: NibNameProvider & StaticReuseIdentifierProvider>(_ cellType: T.Type) {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func registerHeaderFooter<T: NibNameProvider & StaticReuseIdentifierProvider>(_ headerType: T.Type) {
        self.register(UINib(nibName: headerType.nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: headerType.reuseIdentifier)
    }
    
    func dequeueCell<T: NibNameProvider & StaticReuseIdentifierProvider>(_ headerType: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        let cell = self.dequeueReusableCell(withIdentifier: headerType.reuseIdentifier, for: indexPath) as! T
        return cell
    }
    
}

// MARK: - Load ViewController From Nib
extension UIViewController {
    static func loadfromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}

// MARK: - AutoLayout
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading:NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                centerYconstant: CGFloat = 0,
                centerX: NSLayoutXAxisAnchor? = nil,
                centerXconstant: CGFloat = 0,
                padding: UIEdgeInsets = .zero,
                height: CGFloat = 0,
                width: CGFloat = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY, constant: centerYconstant).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX, constant: centerXconstant).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func addAndFitSubview(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = self.bounds
        self.addSubview(view)
        let views = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: views))
    }
}
