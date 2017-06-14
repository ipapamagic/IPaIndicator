//
//  IPaActivityIndicator.swift
//  IPaActivityIndicator
//
//  Created by IPa Chen on 2015/7/4.
//  Copyright (c) 2015年 A Magic Studio. All rights reserved.
//

import Foundation
import UIKit

@objc public class IPaActivityIndicator: UIView {
    
    lazy var indicator = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
    lazy var indicatorBlackView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    lazy var textLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    convenience init(view:UIView) {
        self.init(frame: view.bounds)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }

    func initialSetting() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.clear
        indicatorBlackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        indicatorBlackView.layer.cornerRadius = 10
        indicatorBlackView.clipsToBounds = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorBlackView.addSubview(indicator)
        indicatorBlackView.addSubview(textLabel)
        let viewDict = ["indicator":indicator,"textLabel":textLabel] as [String : Any]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[indicator]-15-[textLabel]-15-|", options: [], metrics: nil, views:viewDict)
        indicatorBlackView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30@999-[indicator]-30@999-|", options: [], metrics: nil, views: viewDict)
        indicatorBlackView.addConstraints(constraints)
        var constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerX, relatedBy: .equal, toItem: textLabel, attribute: .centerX, multiplier: 1, constant: 0)
        indicatorBlackView.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: indicatorBlackView, attribute: .leading, multiplier: 1, constant: 8)
        indicatorBlackView.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: textLabel, attribute: .trailing, multiplier: 1, constant: 8)
        indicatorBlackView.addConstraint(constraint)
        textLabel.setContentCompressionResistancePriority(751, for: .horizontal)
        indicator.startAnimating()
        
        
        indicatorBlackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorBlackView)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: indicatorBlackView, attribute: .trailing, multiplier: 1, constant: 16)
        self.addConstraint(constraint)

        
    }
    
    static func getActualInView(_ view:UIView) -> UIView? {
        var actualInView = view
        while (actualInView is UITableView) {
            if let inSuperView = actualInView.superview {
                actualInView = inSuperView
            }
            else {
                return nil
            }
        }
        return actualInView
    }
// MARK:static public function
    static public func show(_ inView:UIView) {
        self.show(inView, text: nil)
    }
    static public func show(_ inView:UIView,text:String?) {
        guard let actualInView = getActualInView(inView) else {
            return
        }
        let indicator = IPaActivityIndicator(view:actualInView)
        if let text = text {
            indicator.textLabel.text = text
        }
        DispatchQueue.main.async(execute: {
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            actualInView.addSubview(indicator)

            
            let viewsDict:[String:UIView] = ["view": indicator]
            actualInView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",options:[.alignAllTop,.alignAllBottom],metrics:nil,views:viewsDict))
            actualInView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",options:[.alignAllLeading,.alignAllTrailing],metrics:nil,views:viewsDict))
            
            
        })
        
    }
    static public func hide(_ fromView:UIView) {
        guard let actualFromView = getActualInView(fromView) else {
            return
        }
        DispatchQueue.main.async(execute: {
            let views = actualFromView.subviews.filter({
                view in
                return view is IPaActivityIndicator
            })
            for view in views {
                view.removeFromSuperview()
            }
            
        })

    }
}
