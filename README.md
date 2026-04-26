# poc-ios

Experiments with build and upload to Apple's iOS App Store.

Requirements:
1. Valid Apple Developer account (i.e. access to create certificates,
   identities, etc).
2. Xcode. You can use it to manage certificates, etc but you can also do it
   manually.

Environment variables:
* `IOS_API_KEY` and `IOS_API_ISSUER` - you get this in "App Store Connect" >
  "Users and Access" > "Integrations" > "Team Keys". **Do not leak these**
* `IOS_TEAM` - You can get this in various places. The distribution certificate
  name usually contains that key (about 10 alphanumeric characters).
* `IOS_BUNDLE_ID` - application identifier. The same you setup in the Apple
  Developer page.
* `IOS_SIGN_ID` - Name of the signing certificate. Something like `Apple
  Distribution: <developer-name> (<team-id>)`
* `IOS_PROV_PROF` - Provisioning profile name (or UUID).

In order to get the "validation" step pass, you need the App ID created in the
"App Store Connect".
