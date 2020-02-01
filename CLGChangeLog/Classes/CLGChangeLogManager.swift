//
//  CLGChangeLogManager.swift
//  CLGChangeLog
//
//  Created by Matteo Pillon on 26/12/2018.
//  Copyright © 2018 Matteo Pillon. All rights reserved.
//

import Foundation
import UIKit

public class CLGChangeLogManager:NSObject
{
    var changeLog: CLGChangeLog?
    
    let kDefaultsLastVersionKey = "CLGChangeLogManager.lastVersionCodePresented"
    var lastVersionCodePresented : Int?
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
    
    public init(changeLogUri: URL)
    {
        super.init()
        if let cl = parseChangeLogFromURL(changeLogUri)
        {
            dump(cl)

            //Sort releases in descending order
            cl.releases = cl.releases.sorted { (r1
            , r2) -> Bool in
                return r1.versionCode > r2.versionCode
            }
            self.changeLog = cl;
        }
        else
        {
            print("Change log file can't be parsed")
            self.changeLog = nil
        }
    }
    
    private func parseChangeLogFromURL(_ url: URL) -> CLGChangeLog?
    {
        let changelogParser = CLGXmlChangeLogParser(changeLogUrl:url)
        return  changelogParser.parse()
    }
    
    public func presentModalInViewController(_ parentViewController: UIViewController) -> Bool
    {
        if let cl = changeLog
        {
            let changeLogController = CLGChangeLogViewController(changelog: cl)
            changeLogController.modalPresentationStyle = .overCurrentContext
            changeLogController.modalTransitionStyle = .crossDissolve
            parentViewController.present(changeLogController, animated: true, completion:  { //changeLogController.showBackgroundMask()
            });
            if cl.releases.count > 0 {
                //Save last version presented
                lastVersionCodePresented = cl.releases.first!.versionCode
            }
            return true
        }
        else
        {
            return false
        }
    }
    
    public func getNotPresentedReleases() -> [CLGRelease]
    {
        var lastReleases = [CLGRelease]()
        if let cl = changeLog {
            if let lv = lastVersionCodePresented {
                //if is the first run ignore updates
                if lv > 0
                {
                    for rel in cl.releases {
                        //If last version code is greater than the stored one then show change log popup
                        if rel.versionCode > lv
                        {
                            lastReleases.append(rel)
                        }
                    }
                }
            }
            //If is the first run set only the last update
            if lastReleases.count == 0
            {
                lastVersionCodePresented = cl.releases.first?.versionCode ?? 0
            }
        }
       
        return lastReleases
    }
    
    public func IsChangeLogUpdated()
    {
        
    }
    
    
    public func checkChangeLog(parentViewController: UIViewController) -> Bool {
        let lastReleases = getNotPresentedReleases()
        if lastReleases.count > 0
        {
            return self.presentModalInViewController(parentViewController)
        }
        
        return false
    }
    
}
