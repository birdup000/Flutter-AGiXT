# Flutter UI for AGiXT

This is a Flutter application that demonstrates the usage of the AGiXT SDK. The application provides a simple interface to interact with the AGiXT platform, allowing users to manage agents.

## Features

1. **Home Page**: The home page displays a welcome message and provides a navigation drawer with two options: "Home" and "Agent Management".

2. **Agent Management Page**: The agent management page fetches a list of providers from the AGiXT platform and displays them in a dropdown menu. When a provider is selected, the selected provider's name is displayed.

## Getting Started

To run this application, you'll need to have Flutter installed on your machine. Follow these steps:

1. Clone the repository:

   ```
   git clone https://github.com/Flutter-AGiXT.git
   ```

2. Navigate to the project directory:

   ```
   cd Flutter-AGiXT/flutter_agixt/
   ```

3. Install the dependencies:

   ```
   flutter pub get
   ```

4. Run the application:

   ```
   flutter run
   ```

## Configuration

The AGiXT SDK is configured using the `AGiXTSDK` class. You can customize the following parameters:

- `baseUri`: The base URI of the AGiXT platform. The default value is `"http://localhost:7437"`.
- `apiKey`: The API key for authentication. If provided, it will be included in the headers of the HTTP requests.

To use your own AGiXT platform, update the `baseUri` and `apiKey` values in the `AGiXTSDK` constructor.

## Dependencies

This project uses the following dependencies:

- `flutter/material.dart`: The core Flutter library for building UI.
- `http`: A library for making HTTP requests.

## Contribution

If you find any issues or have suggestions for improvements, feel free to create a new issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).