declare module "react-native-buglife" {
  const invocationOptionsNone = 'invocationOptionsNone';
  const invocationOptionsShake = 'invocationOptionsShake';
  const invocationOptionsScreenshot = 'invocationOptionsScreenshot';
  const invocationOptionsFloatingButton = 'invocationOptionsFloatingButton';


  function setInvocationOptions(options: string): void;
  function startWithAPIKey(key: string): void;
  function setUserIdentifier(id: string): void;
  function setUserEmail(email: string): void;
}