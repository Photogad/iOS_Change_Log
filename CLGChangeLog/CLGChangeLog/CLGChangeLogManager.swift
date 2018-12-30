//
//  CLGChangeLogManager.swift
//  CLGChangeLog
//
//  Created by Matteo Pillon on 26/12/2018.
//  Copyright © 2018 Matteo Pillon. All rights reserved.
//

import Foundation

public class CLGChangeLogManager:NSObject
{
    var mainController : UIViewController
    var changeLogUri: URL
    let kDefaultsLastVersionKey = "CLGChangeLogManager.lastVersionCode"
    var lastVersionCode : Int?
    {
        get
        {
            return UserDefaults.standard.integer(forKey: kDefaultsLastVersionKey)
        }
        set
        {
            UserDefaults.standard.set(newValue, forKey: kDefaultsLastVersionKey)
            UserDefaults.standard.synchronize()
        }
        
    }
    
    public init(mainController controller:UIViewController, changeLogUri: URL)
    {
        self.mainController = controller
        self.changeLogUri = changeLogUri
        
        super.init()
    }
    
    public func checkChangeLog() -> Bool {
        let changelogParser = CLGXmlChangeLogParser(changeLogUrl:changeLogUri)
        var hasNewChangeLog = false
        if let changelog = changelogParser.parse()
        {
            dump(changelog)
            
            
            if changelog.releases.count > 0
            {
                //Sort releases in descending order
                changelog.releases = changelog.releases.sorted { (r1
                    , r2) -> Bool in
                    return r1.versionCode > r2.versionCode
                }
                //Get latest version code stored in user defaults
                if let lv = lastVersionCode
                {
                    if changelog.releases.first!.versionCode > lv && lv > 0
                    {
                        //If last version code is greater than the stored one then show change log popup
                        let changeLogController = CLGChangeLogViewController(changelog: changelog)
                        changeLogController.modalPresentationStyle = .overCurrentContext
                
                        mainController.present(changeLogController, animated: true, completion:  { //changeLogController.showBackgroundMask()
                            
                        });
                        hasNewChangeLog = true
                    }
                }
                //Save last version found
                lastVersionCode = changelog.releases.first!.versionCode
            }
            
        }
        else
        {
            print("Change log file can't be parsed")
        }
        
        return hasNewChangeLog
    }
    
}
