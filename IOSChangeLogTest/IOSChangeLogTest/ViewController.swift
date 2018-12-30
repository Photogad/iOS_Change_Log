//
//  ViewController.swift
//  IOSChangeLogTest
//
//  Created by Matteo Pillon on 30/12/2018.
//  Copyright © 2018 Dunbar. All rights reserved.
//

import UIKit
import CLGChangeLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let manager = CLGChangeLogManager(mainController: self, changeLogUri: Bundle.main.url(forResource: "changelog", withExtension: "xml")!)
        
        //Add +1 to first version code in changelog.xml to test the popup.
        //The first run it doesn't popup
        if manager.checkChangeLog()
        {
            print("New release found")
        }
        else
        {
            print("No release found")
        }
        
        
    }
}

