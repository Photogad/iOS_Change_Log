# iOS Change Log

iOS change log is a library that automates the notification of the change log of new version of an app to the user. It shows the change log first time the app runsy after an update.

## Requirements
-   iOS 8.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
-   Xcode 10.1+
-   Swift 4.2+
## Integration
#### **Manually**
To use this library in your project manually you may:
1.  for Workspaces, include the whole CLGChangeLog.xcodeproj

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
*CLGChangeLogManager* is the class that manage all of the logic, you must provide the view controller where you want the eventually show the popup
and the url of the change log xml (usually in the main bundle). 
```swift
let manager =  CLGChangeLogManager(mainController: self, changeLogUri: Bundle.main.url(forResource: "changelog", withExtension: "xml")!))
```
#### Check for update
In the viewDidAppear ovverride you can call checkChangeLog of the manager object and the lib display the change log popup if needed.
```swift
override func viewDidAppear(_ animated: Bool) {
	super.viewDidAppear(animated)
	if manager.checkChangeLog()
	{
		print("New release found")
	}
	else
	{
		print("No release found")
	}
}
``
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIxNDEzOTY1MDIsLTYxNjIzODI3NiwtMj
AxMDYzNDMxNl19
-->