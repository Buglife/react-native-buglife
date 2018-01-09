react-native-buglife
====================

React Native wrapper for [Buglife iOS](https://github.com/Buglife/Buglife-iOS) and [Buglife Android](https://github.com/Buglife/buglife-android).

[![npm version](https://img.shields.io/npm/v/react-native-buglife.svg)](https://www.npmjs.com/package/react-native-buglife)

# Installation

1. `npm install react-native-buglife --save`
2. `react-native link` to link the native libraries to the react wrappers.


# Usage

1. Require the module
	
    ```javascript
    var Buglife = require('react-native-buglife');
    ```
    
2. If you have already created a Buglife account, initialize the SDK using your organization's API key:
	
	```javascript
	Buglife.startWithAPIKey("YOUR-API-KEY-HERE");
	```
	If you haven't signed up & you wish to use Buglife without an account, initialize the SDK using your email address. (Bug reports will be sent to this email address.)
	
	```javascript
	Buglife.startWithEmail("you@yourdomain.com");
	```
	For React Native on Android, if you want to use the screenshot invocation, you'll need to put a call to one of these APIs in your Application subclass's `onCreate()` method. 
	
3. By default, the Buglife bug reporter is invoked using the shake gesture. However with React Native, shake is also used to present the [developer menu](https://facebook.github.io/react-native/docs/debugging.html).

	You can either disable React Native's developer menu, or use one of the other predefined Buglife invocation methods, such as device screenshots or a floating bug button.
	
	```javascript
	// Screenshot invocation - we recommend this method for invoking the bug reporter
	Buglife.setInvocationOptions(Buglife.invocationOptionsScreenshot);
	
	// Floating bug button
	Buglife.setInvocationOptions(Buglife.invocationOptionsFloatingButton);
	```
4. You may want to add the reporter's email address or other account identifier to your bug reports. You can do this with 
	```javascript
	// Set an email address
	Buglife.setUserEmail("name@example.com")
	// Set a user identifier
	Buglife.setUserIdentifier("account name")
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

For advanced usage & features (customization, user identification, etc), check out the official Buglife [documentation](http://buglife.com/docs).