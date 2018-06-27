declare module "react-native-buglife" {
  type InvocationEventKey =
    | "invocationOptionsNone"
    | "invocationOptionsShake"
    | "invocationOptionsScreenshot"
    | "invocationOptionsFloatingButton"
    | "floatingButton";

  function setInvocationOptions(options: InvocationEventKey): void;
  function startWithAPIKey(key: string): void;
  function setUserIdentifier(id: string): void;
  function setUserEmail(email: string): void;
}