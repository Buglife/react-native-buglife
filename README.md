react-native-buglife
====================

React Native wrapper for [Buglife iOS](https://github.com/Buglife/Buglife-iOS).

# Installation

1. Add `react-native-buglife` to `packages.json`
2. `npm install`
3. Install Buglife iOS via either CocoaPods or manually ([more info here](https://github.com/Buglife/Buglife-iOS))
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

For advanced usage & features (customization, user identification, etc), check out the official Buglife [documentation](http://buglife.com/docs).