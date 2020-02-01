# CLGChangeLog
iOS change log is a library that automates the notification of the change log of new version of an app to the user. It shows the change log the first time the app runs after an update.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
-   iOS 8.0+ 
-   Xcode 10.1+
-   Swift 4.0+

## Integration

#### **Cocoapods**
Add to podfile

```ruby
  pod 'CLGChangeLog', :git => 'https://github.com/photogad/iOS_Change_Log.git', :branch => 'pod'
```

#### **Manually**
To use this library in your project manually you may:
1.  for Workspaces, include the whole CLGChangeLog.xcodeproj

#### **Local pod**
Download this repository in a local path. To install as local pod repository
it, simply add the following line to your Podfile

```ruby
pod 'CLGChangeLog', :path => '~/dunbar/ios_change_log'
```
>substitue path '~/dunbar/ios_change_log' with the repository download path

## Prepare change the log XML

The lib require an xml file with the history of the change log of the app in the app bundle.

#### **Xml structure**
```
changelog
release 1
change 1
'Description of change 1'
...           
change x
'Description of change n'
...
release m
change 1
...
change y
```
#### **Tags attributes:**
| Tag | Attribute  | Description  |
|--|--| -- |
| **changelog**| **title** | Title of the change log notification popup|
| **release**| **version** | Label of version for the user |
| **release**| **versioncode** | Number of the version. The library use this number to sort the release and present last version|

#### **Example**
```xml
<?xml version="1.0" encoding="utf-8"?>
<changelog title="Change Log">
<release version="2.0" versioncode="3" >
<change>Totally new and shiny version</change>
</release>
<release version="1.2" versioncode="2" >
<change>Fixed: A bug fix</change>
<change>New feature 1</change>
<change>New feature 2</change>
<change>
Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur.                         
</change>
</release>
<release version="1.0" versioncode="1">
<change>First release</change>
</release>
</changelog>
```

## Usage

This code usually runs in the main controller of the app or in the ViewController you want the popup to be displayed.
#### Import
```swift
import CLGChangeLog
```
#### Initialization
*CLGChangeLogManager* is the class that manage all of the logic, 
you must provide the url of the change log xml (usually in the main bundle). 
```swift
let manager =  CLGChangeLogManager(changeLogUri: Bundle.main.url(forResource: "changelog", withExtension: "xml")!)
```
#### Check for change log updates
In the viewDidAppear ovverride you can call checkChangeLog of the manager object and the lib display the change log popup if needed. You must provide the view controller that eventually present the modal popup
```swift
override func viewDidAppear(_ animated: Bool) {
super.viewDidAppear(animated)
if manager.checkChangeLog(parentViewController: self)
{
print("New release found")
}
else
{
print("No release found")
}
}
```

#### Get the list of new updates
Use the getNotPresentedReleases method to get the list of the new releases not yet presented to the user. It can be used to check manually if there are some new releases to notify
```swift
 let newReleases = changeLogManager.getNotPresentedReleases()
```

#### Open changelogs popup manually
Use the presentModalInViewController method to open the changelog popup manually. You must provide the view controller that present the modal popup
```swift
changeLogManager.presentModalInViewController(self)
```

## Credits

iOS change log is owned and maintained by the  **Dunbar Technology LLC**


## Author

Matteo Pillon, matteopillon@icode.it

## License

CLGChangeLog is available under the MIT license. See the LICENSE file for more info.
