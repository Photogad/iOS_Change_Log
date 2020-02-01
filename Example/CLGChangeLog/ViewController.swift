//
//  ViewController.swift
//  CLGChangeLog
//
//  Created by Matteo Pillon on 01/08/2019.
//  Copyright (c) 2019 Matteo Pillon. All rights reserved.
//

import UIKit
import CLGChangeLog

class ViewController: UIViewController {

    var changeLogManager : CLGChangeLogManager? = nil;
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeLogManager = CLGChangeLogManager(changeLogUri: Bundle.main.url(forResource: "changelog", withExtension: "xml")!)
        
        let newReleases = changeLogManager!.getNotPresentedReleases()
        openButton.isHidden = false
        switch newReleases.count {
        case 0:            
            textLabel.text = "No changes"
        case 1:
            textLabel.text = "Found one release in the changelog"
        default:
            textLabel.text = "Found \(newReleases.count) releases in the changelog"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openTapped(_ sender: Any) {
        if changeLogManager!.presentModalInViewController(self)
        {
            print("Popup presented")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Add +1 to first version code in changelog.xml to test the popup.
        //The first run it doesn't popup
        if changeLogManager!.checkChangeLog(parentViewController: self)
        {
            print("New release found")
        }
        else
        {
            print("No release found")
        }
        
        
    }

}

