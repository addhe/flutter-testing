# Flutter Login App with Google Sign-In

A Flutter application demonstrating Google Sign-In integration with JWT token authentication.

## Features

- Google Sign-In Authentication
- JWT Token Management
- Persistent Authentication State
- Material Design UI
- Secure Token Storage

## Setup Instructions

1. **Flutter Setup**
   ```bash
   flutter pub get
   ```

2. **Google Sign-In Configuration**
   
   a. Go to the [Google Cloud Console](https://console.cloud.google.com/)
   
   b. Create a new project or select an existing one
   
   c. Enable the Google Sign-In API
   
   d. Create OAuth 2.0 credentials:
      - Create OAuth client ID
      - Select "Web application" as the application type
      - Add authorized redirect URIs
      - Download the client configuration file

3. **Backend Configuration**
   
   Update the `_apiUrl` in `lib/services/auth_service.dart` with your backend API URL:
   ```dart
   static const String _apiUrl = 'YOUR_API_URL';
   ```

4. **Running the App**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point and navigation setup
├── screens/
│   └── login_screen.dart  # Login page UI
└── services/
    └── auth_service.dart  # Authentication logic
```

## Authentication Flow

1. User clicks "Sign in with Google" button
2. Google Sign-In flow is initiated
3. After successful Google authentication:
   - Backend receives Google token
   - Backend validates token and creates JWT
   - App stores JWT for future requests
4. User is redirected to home screen
5. JWT is used for subsequent API requests

## Security Considerations

- JWT tokens are stored securely using SharedPreferences
- HTTPS is used for all API communications
- Google Sign-In implementation follows OAuth 2.0 best practices

## Dependencies

- google_sign_in: ^6.1.5
- http: ^1.1.0
- jwt_decoder: ^2.0.1
- shared_preferences: ^2.2.1

## Notes

- Make sure to configure your Google Cloud Console project properly
- Update the backend API URL before running the app
- Handle token expiration and refresh tokens as needed
- Implement proper error handling in production
