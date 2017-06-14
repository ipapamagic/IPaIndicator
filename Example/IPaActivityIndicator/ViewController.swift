//
//  ViewController.swift
//  IPaActivityIndicator
//
//  Created by IPa Chen on 12/28/2016.
//  Copyright (c) 2016 IPa Chen. All rights reserved.
//

import UIKit
import IPaActivityIndicator
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showLoadingText(_ sender: Any) {
        IPaActivityIndicator.show(self.view,text:"loading...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 , execute: {
            IPaActivityIndicator.hide(self.view)
        })
    }
    @IBAction func onShow(_ sender: Any) {
        IPaActivityIndicator.show(self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 , execute: {
            IPaActivityIndicator.hide(self.view)
        })
    }
}

