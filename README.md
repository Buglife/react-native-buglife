react-native-buglife
====================

React Native wrapper for [Buglife iOS](https://github.com/Buglife/Buglife-iOS).

# Installation

1. `npm install react-native-buglife --save`
2. Install Buglife iOS via either CocoaPods or manually ([more info here](https://github.com/Buglife/Buglife-iOS))
3. In the Xcode project navigator, right-click the **Libraries** group and select **Add Files to [your project]**.
4. Go to `node_modules` ➡ `react-native-buglife`, and add `RNBuglife.xcodeproj`
5. Open your Xcode project's **Build Phases** tab, and expand the **Link Binary With Libraries** panel. Add `libRNBuglife.a`

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
	
3. By default, the Buglife bug reporter is invoked using the shake gesture. However with React Native, shake is also used to present the [developer menu](https://facebook.github.io/react-native/docs/debugging.html).

	You can either disable React Native's developer menu, or use one of the other predefined Buglife invocation methods, such as device screenshots or a floating bug button.
	
	```javascript
	// Screenshot invocation - we recommend this method for invoking the bug reporter
	Buglife.setInvocationOptions(Buglife.invocationOptionsScreenshot);
	
	// Floating bug button
	Buglife.setInvocationOptions(Buglife.invocationOptionsFloatingButton);
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