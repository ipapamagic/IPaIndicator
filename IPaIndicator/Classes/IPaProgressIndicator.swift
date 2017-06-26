//
//  IPaProgressIndicator.swift
//  Pods
//
//  Created by IPa Chen on 2017/6/24.
//
//

import UIKit

public class IPaProgressIndicator: IPaIndicator {
    public lazy var progressView:IPaRoundProgressView = {
        let pView = IPaRoundProgressView(frame: .zero)
        pView.progress = 0
        return pView
    }()
    public var progress:CGFloat {
        set {
            progressView.progress = newValue
        }
        get {
            return progressView.progress
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func initialSetting() {
        super.initialSetting()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = UIColor.clear
        indicatorBlackView.addSubview(progressView)
        let viewDict = ["progressView":progressView] as [String : Any]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[progressView(100)]-30-|", options: [], metrics: nil, views:viewDict)
        indicatorBlackView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[progressView(100)]-30-|", options: [], metrics: nil, views: viewDict)
        indicatorBlackView.addConstraints(constraints)
   
    }
}
