# topics

browse code online: https://github1s.com/AhmedKhattab95/userposts

link to apk to install: https://github.com/AhmedKhattab95/userposts/releases/download/1.0.0/app-release.apk

this task is to show list of users and group there posts and when click on a user show his full image with list of posts for him

Used plugins:

#core layer plugins
  connectivity_plus: 
  get_it: 
  dio: 
  equatable: 
  shared_preferences: 

#app layer plugins
  dartz: 
  pretty_dio_logger: 
  flutter_riverpod: 
  fluttertoast: 
  

used archeticture:
<a href='https://www.codeguru.com/csharp/understanding-onion-architecture'/>onion architecture<a> and MVVM applied with <a href='https://riverpod.dev/'>riverpod </a> library

feature folder contain design as views and view models and bussiness logic applied in managers then services then models as:
![Capture](https://user-images.githubusercontent.com/17656876/181864595-68a017b8-7538-48a7-b0fb-81cfc56269d7.PNG)


- add core layer contains core services for generic purpose and can be extended and used in another project as library
- add feature of user and topics with MVVM using riverpod and onion archeticture
- using dependancy injection using get_it library
- supports arabic and english localizations

- features added on task:
- save user prefered language in cache
- handle theme on the fly
- handle interent not connected with all App through centralized layer


screenshots:
![WhatsApp Image 2022-07-30 at 3 16 50 AM](https://user-images.githubusercontent.com/17656876/181864771-12219ee0-8ae9-4417-a0f7-8bdf7a7f84af.jpeg)
![WhatsApp Image 2022-07-30 at 3 16 49 AM (1)](https://user-images.githubusercontent.com/17656876/181864773-0069ab48-a4a7-4e9a-b8f2-65429dcf8f69.jpeg)
![WhatsApp Image 2022-07-30 at 3 16 49 AM](https://user-images.githubusercontent.com/17656876/181864774-ba643d8f-7d2f-4249-af9a-db5870ec4217.jpeg)
![WhatsApp Image 2022-07-30 at 3 16 48 AM](https://user-images.githubusercontent.com/17656876/181864775-0f19e849-bb32-4be8-8631-a437ea00482f.jpeg)


## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
