react-native-buglife
====================

React Native wrapper for [Buglife iOS](https://github.com/Buglife/Buglife-iOS) and [Buglife Android](https://github.com/Buglife/buglife-android).

[![npm version](https://img.shields.io/npm/v/react-native-buglife.svg)](https://www.npmjs.com/package/react-native-buglife)

# Installation

1. `npm install react-native-buglife --save`
2. `react-native link` to link the native libraries to the react wrappers.

> If you intend to ship with Buglife to TestFlight or the iOS App Store, you'll need to add `NSPhotoLibraryUsageDescription` to your Info.plist. See [this article](https://www.buglife.com/docs/ios/app-store-builds.html).

# Configuration

### Android native configuration

1. Open your app's `build.gradle`, and make sure the `compileSdkVersion` is at least 26, and `minSdkVersion` is at least 16.

2. If you are not prompted to do so by Android Studio, add the following maven repository to your _project's_ build.gradle `buildscript` section:
	
    ```
    maven {
        url 'https://maven.google.com/'
        name 'Google'
    }
    ```
    
    eg. 
    ```groovy
    buildscript {
        repositories {
            jcenter()
            maven {
                url 'https://maven.google.com/'
                name 'Google'
            }
        }
        ...
    }
    ```

3. Add the following lines to the end of the `onCreate()` method in your main `Application` subclass. (If your app doesn't have one already, create an Application subclass and declare it in `AndroidManifest.xml`.)
	
    ```java
    Buglife.initWithEmail(this, "you@yourdomain.com");
    Buglife.setInvocationMethod(InvocationMethod.SCREENSHOT);
    ```
    
	Be sure to replace `you@yourdomain.com` with your own email address, as bug reports will be sent to this address.

### iOS native configuration

1. Open `AppDelegate.m` and add the following import statement below the others:
	
	```objective-c
	#import "Buglife.h"
	```

2. Add the following to the end of the `application:didFinishLaunchingWithOptions:` method in `AppDelegate.m`:
    
    ```objective-c
    [[Buglife sharedBuglife] startWithEmail:@"you@yourdomain.com"];
    [[Buglife sharedBuglife] setInvocationOptions:LIFEInvocationOptionsScreenshot];
    ```

3. Add the `NSPhotoLibraryUsageDescription` key to your iOS app's Info.plist if it doesn't have it already. See the Buglife [iOS App Store documentation](https://www.buglife.com/docs/ios/app-store-builds.html).

### Javascript configuration

Import & initialize Buglife within `App.js`:

```javascript
var Buglife = require('react-native-buglife');
```

### Build & run

Build & run on a device, then take a screenshot to invoke the bug reporter! Submit your first bug report, and it'll show up in your email.

# Customization

### User identification

You may want to add the reporter's email address or other account identifier to your bug reports. You can do this with 

```javascript
// Set an email address
Buglife.setUserEmail("name@example.com");

// Set a user identifier
Buglife.setUserIdentifier("account name");
```
	

### Attachments

Your application can include custom JSON attachments with each bug report. For example, to add an attachment solely to the next invocation of the bug reporter:

```javascript
var myData = { }; // This should be a JSON object with your data
Buglife.addAttachmentWithJSON(myData, "MyData.json");
```

It’s also possible to add a String attachment:

```javascript
var myText = "great detailed log"; // This should be a String object with your data
Buglife.addAttachmentWithString(myText, "MyText.text");
```

In some cases, you may wish to add an attachment on every invocation of the bug reporter; You can do so by subscribing to the `BuglifeAttachmentRequest` event:

```javascript
import { NativeModules, NativeEventEmitter } from 'react-native';

const eventEmitter = new NativeEventEmitter(NativeModules.RNBuglife);

eventEmitter.addListener(Buglife.BuglifeAttachmentRequest, () => {
  var appState = {"awesomeness": "Insanely awesome", "volume": 11};
  Buglife.addAttachmentWithJSON(appState, "AppState.json");
});
```

For advanced usage & features (customization, user identification, etc), check out the official Buglife [documentation](https://www.buglife.com/docs/react-native).
