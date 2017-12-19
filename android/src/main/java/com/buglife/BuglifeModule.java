
package com.buglife;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;

import com.buglife.sdk.Buglife;
import com.buglife.sdk.InvocationMethod;
import com.buglife.sdk.Attachment;

import org.json.JSONObject;

public class BuglifeModule extends ReactContextBaseJavaModule {

  public static final String INVOCATION_METHOD_NONE = "invocationOptionsNone";
  public static final String INVOCATION_METHOD_SHAKE = "invocationOptionsShake";
  public static final String INVOCATION_METHOD_SCREENSHOT = "invocationOptionsScreenshot"

  private final ReactApplicationContext reactContext;

  public BuglifeModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "Buglife";
  }

  @Override
  public Map<String, Object> getConstants() {
    final Map<String, Object> constants = new HashMap<>();
    constants.put(INVOCATION_METHOD_NONE, Integer(InvocationMethod.NONE));
    constants.put(INVOCATION_METHOD_SHAKE, Integer(InvocationMethod.SHAKE));
    constants.put(INVOCATION_METHOD_SCREENSHOT, Integer(InvocationMethod.SCREENSHOT));
    return constants;
  }


  @ReactMethod
  public void startWithAPIKey(String apiKey) {
    Buglife.initWithAPIKey(getCurrentActivity().getApplication(), apiKey);
  }

  @ReactMethod
  public void startWithEmail(String email) {
    Buglife.initWithEmail(getCurrentActivity().getApplication(), email);
  }

  @ReactMethod
  public void setInvocationOptions(Integer invocationMethod) {
    Buglife.setInvocationMethod(InvocationMethod.values()[int(invocationMethod)]);
  } 

  @ReactMethod
  public void presentReporter() {
    Buglife.showReporter();
  }

  @ReactMethod
  public void setUserIdentifier(String identifier) {
    Buglife.setUserIdentifier(identifier);
  }

  @ReactMethod
  public void setUserEmail(String userEmail) {
    Buglife.setUserEmail(userEmail);
  }

  @ReactMethod
  public void addAttachmentWithJSON(JSONObject data, String attachmentFileName, Promise promise) {
    try {
      Attachment attachment = Attachment.Builder(attachmentFileName, TYPE_JSON).build(data);
      Buglife.addAttachment(attachment); // The android version of the API does not return a boolean
      promise.resolve(null);
    }
    catch (Exception e) {
      e.printStackTrace();
      promise.reject("ATTACHMENT_ERR", e);
    }
  }

  @ReactMethod
  public void addAttachmentWithContents(String base64data, String attachmentFileName, Promise promise) {
    try {
      Attachment attachment = Attachment.Builder(attachmentFileName, TYPE_TEXT).build(base64data);
      Buglife.addAttachment(attachment); // The android version of the API does not return a boolean
      promise.resolve(null);
    }
    catch (Exception e) {
      e.printStackTrace();
      promise.reject("ATTACHMENT_ERR", e);
    }

  }

}