Here's the English translation of your markdown while maintaining all formatting and structure:

# 📦 AppAmbit - Swift Package for API Consumption

![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)
![iOS](https://img.shields.io/badge/iOS-13+-blue.svg)

## 📌 Description
Swift package for interacting with the AppAmbit API. Provides methods for:
- Registering consumers (`storeConsumer`)
- Starting sessions (`startSession`)

## 🚀 Installation

### Method 1: Local Package (Recommended for development)
1. Open your project in Xcode
2. Go to `File > Add package dependencies...`
3. Click **`Add Local...`**
4. Navigate to the root folder of `AppAmbit` (where `Package.swift` is located)
5. Click `Add Package`

## 🛠 Basic Usage

### 1. Import the package
```swift
import AppAmbit
```

### 2. Create a Test instance
```swift
let ambitService = Test()
```

### 3. Register a consumer (Get token)
```swift
ambitService.storeConsumer { token in
    if let token = token {
        print("Token received: \(token)")
        // Save the token for future requests
    } else {
        print("Error getting token")
    }
}
```

### 4. Start a session (Use the token)
```swift
let myToken = "previously_received_token"

ambitService.startSession(token: myToken) { success in
    if success {
        print("✅ Session started successfully")
    } else {
        print("❌ Error starting session")
    }
}
```

## 📋 Complete Example (SwiftUI)

```swift
import SwiftUI
import AppAmbit

struct ContentView: View {
    @State private var token: String?
    private let ambitService = Test()
    
    var body: some View {
        VStack {
            Button("Get Token") {
                ambitService.storeConsumer { receivedToken in
                    token = receivedToken
                }
            }
            
            if let token = token {
                Text("Token: \(token.prefix(10))...")
                Button("Start Session") {
                    ambitService.startSession(token: token) { success in
                        print(success ? "Session started" : "Error")
                    }
                }
            }
        }
    }
}
```

## ⚠️ Requirements
- iOS 13+
- Xcode 16+

## 🔍 Troubleshooting
If you receive errors:
1. Check your internet connection
2. Confirm the API URL is accessible
3. Review console logs for detailed error messages

---

> ✨ **Tip**: To update the local package, simply clean the project and rebuild.