//
//  CLGXmlChangeLogParser.swift
//  CLGChangeLogs
//
//  Created by Matteo Pillon on 22/12/2018.
//  Copyright © 2018 Matteo Pillon. All rights reserved.
//

import UIKit

enum ChangeLogXmlTags :String {
    case changelog = "changelog"
    case release = "release"
    case change = "change"
}


public class CLGXmlChangeLogParser:NSObject,XMLParserDelegate {
    private var changeLogUrl : URL?
    private var changeLog :CLGChangeLog?
    private var currentRelease: CLGRelease?
    private var currentChange: CLGChange?
    
   
    
    public init(changeLogUrl url:URL) {
        self.changeLogUrl = url;
    }
   
    public func parse() -> CLGChangeLog? {
        if let fileUrl = self.changeLogUrl
        {
            let parser = XMLParser(contentsOf: fileUrl);
            parser?.shouldProcessNamespaces = false
            parser?.delegate = self;
            parser?.parse()
            print(parser?.parserError.debugDescription ?? "")
            return self.changeLog
        }
        else
        {
            return nil
        }
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }
    
    // MARK: XMLParserDelegate
    public func parserDidStartDocument(_ parser: XMLParser) {
        self.changeLog = CLGChangeLog()
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName.lowercased() {
        case ChangeLogXmlTags.changelog.rawValue:
            changeLog?.title = attributeDict["title"] ?? ""
            break
        case ChangeLogXmlTags.release.rawValue:
            currentRelease = CLGRelease()
            currentRelease!.version = attributeDict["version"] ?? ""
            currentRelease!.versionCode = Int(attributeDict["versioncode"] ?? "") ?? 0
            changeLog!.releases.append(currentRelease!)
            break
        case ChangeLogXmlTags.change.rawValue:
            currentChange = CLGChange()
            currentRelease!.changes.append(currentChange!)
            break
        default:
            break
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName.lowercased() {
        case ChangeLogXmlTags.changelog.rawValue:
            //Nothing to do
            break
        case ChangeLogXmlTags.release.rawValue:
            currentRelease = nil
            break
        case ChangeLogXmlTags.change.rawValue:
            currentChange = nil
            break
        default:
            break
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let change = currentChange
        {
            change.text.append(string)
        }
    }

}
