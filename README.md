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

Add the following lines to the end of the `onCreate()` method in your main `Application` subclass. (If your app doesn't have one already, create an Application subclass and declare it in `AndroidManifest.xml`.)

```java
Buglife.initWithEmail(this, "you@yourdomain.com");
Buglife.setInvocationOptions(Buglife.invocationOptionsScreenshot);
```

You may also need to set your app's `compileSdkVersion` to 26, and `minSdkVersion` to at least 16.

### iOS native configuration

Add the following to your app delegate's `application:didFinishLaunchingWithOptions:` method:

```objective-c
[[Buglife sharedBuglife] startWithEmail:@"you@yourdomain.com"];
[[Buglife sharedBuglife] setInvocationOptions:LIFEInvocationOptionsScreenshot];
```

> If you plan on shipping either to TestFlight or the iOS App Store, you'll need to add the `NSPhotoLibraryUsageDescription` key to your iOS app's Info.plist. See the Buglife [iOS App Store documentation](https://www.buglife.com/docs/ios/app-store-builds.html).

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