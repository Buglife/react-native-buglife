
package com.buglife;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.ReactPackage;

import com.buglife.sdk.Buglife;
import com.buglife.sdk.InvocationMethod;
import com.buglife.sdk.Attachment;
import com.facebook.react.bridge.ReadableMap;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class BuglifeModule extends ReactContextBaseJavaModule {

  public static final String INVOCATION_METHOD_NONE = "invocationOptionsNone";
  public static final String INVOCATION_METHOD_SHAKE = "invocationOptionsShake";
  public static final String INVOCATION_METHOD_SCREENSHOT = "invocationOptionsScreenshot";

  private final ReactApplicationContext reactContext;

  public BuglifeModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  public static ReactPackage getPackage() {
    return new BuglifePackage();
  }

  @Override
  public String getName() {
    return "Buglife";
  }

  @Override
  public Map<String, Object> getConstants() {
    final Map<String, Object> constants = new HashMap<>();
    constants.put(INVOCATION_METHOD_NONE, InvocationMethod.NONE.getValue());
    constants.put(INVOCATION_METHOD_SHAKE, InvocationMethod.SHAKE.getValue());
    constants.put(INVOCATION_METHOD_SCREENSHOT, InvocationMethod.SCREENSHOT.getValue());
    return constants;
  }


  @ReactMethod
  public void startWithAPIKey(String apiKey) {
    Buglife.initWithApiKey(getCurrentActivity().getApplication(), apiKey);
  }

  @ReactMethod
  public void startWithEmail(String email) {
    Buglife.initWithEmail(getCurrentActivity().getApplication(), email);
  }

  @ReactMethod
  public void setInvocationOptions(Integer invocationMethod) {
    Buglife.setInvocationMethod(InvocationMethod.values()[invocationMethod]);
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
  public void addAttachmentWithJSON(ReadableMap jsonData, String attachmentFileName, Promise promise) {
    try {
      JSONObject jsonObject = (JSONObject)jsonData;
      Attachment attachment = new Attachment.Builder(attachmentFileName, Attachment.TYPE_JSON).build(jsonObject);

      Buglife.addAttachment(attachment); // The android version of the API does not return a boolean
      promise.resolve(null);
    }
    catch (Exception e) {
      e.printStackTrace();
      promise.reject("ATTACHMENT_ERR", e);
    }
  }

  @ReactMethod
  public void addAttachmentWithString(String textData, String attachmentFileName, Promise promise) {
    try {
      Attachment attachment = new Attachment.Builder(attachmentFileName, Attachment.TYPE_TEXT).build(textData);

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
      Attachment attachment = new Attachment.Builder(attachmentFileName, Attachment.TYPE_TEXT).build(base64data);
      Buglife.addAttachment(attachment); // The android version of the API does not return a boolean
      promise.resolve(null);
    }
    catch (Exception e) {
      e.printStackTrace();
      promise.reject("ATTACHMENT_ERR", e);
    }

  }

}