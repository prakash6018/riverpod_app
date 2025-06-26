# Riverpod User App

A sample Flutter app using Riverpod 2.0 (AsyncNotifier) and dio, demonstrating modular architecture, GET/POST API integration, and robust error/loading handling.

## Features

- **User List Screen**: Fetches and displays users from `https://reqres.in/api/users` with pull-to-refresh, loading, and error states.
- **Post Route Screen**: Simple form to POST a user (name, job) to `https://reqres.in/api/users`, with success/error feedback.
- **Architecture**: Modular, with clear separation:
  - `data/`: API calls and models
  - `repository/`: Business logic abstraction
  - `presentation/`: UI, screens, providers
- **State Management**: Riverpod 2.0 AsyncNotifier for both GET and POST flows.
- **Networking**: Uses dio for HTTP requests.

## Folder Structure

```
lib/
  data/
    user_data_model.dart
    user_remote_api.dart
  repository/
    user_data_repository.dart
  presentation/
    providers/
    screens/
  main.dart
```

## How to Run

### Prerequisites

1. Ensure you have **Flutter 3.10+** installed. [Flutter installation guide](https://docs.flutter.dev/get-started/install)
2. Run `flutter pub get` to install dependencies.
3. Create a `.env` file in the project root with the following content:
   
   ```
   API_KEY=reqres-free-v1
   ```

### Running on Android

1. Start an Android emulator or connect a physical Android device.
2. Run:

   flutter run -d android

### Running on iOS (macOS only)

1. Start an iOS simulator or connect a physical iOS device.
2. For simulators, run:

   flutter run -d ios

3. For physical devices, ensure you have Xcode set up and your device trusted. You may need to open the project in Xcode and set up signing:

   open ios/Runner.xcworkspace

   Then select your team and device, and build once from Xcode if needed.

### Running on Web

1. Run:

   flutter run -d chrome

   Or for other browsers, use `flutter devices` to list available browsers and run with the desired device ID.

## Architecture Decisions

- **Riverpod 2.0**: Chosen for robust, testable state management. AsyncNotifier is used for async flows (GET/POST).
- **dio**: Chosen for flexible, modern HTTP requests.
- **Separation of Concerns**: Data, repository, and presentation layers are strictly separated for maintainability.
- **Error/Loading Handling**: All async flows handle loading and error states, with retry and refresh options.

## Customization

- To test error handling, change the endpoint in `user_api.dart` to an invalid URL (e.g., `https://reqres.in/api/404`).

---

MIT License
