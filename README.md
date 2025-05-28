# CalorieApp

An example SwiftUI iOS application that demonstrates how to analyse food photos with OpenAI's Vision API.

## Requirements
- Xcode 15 or newer
- iOS 16 simulator or device
- Swift Package Manager

## Setup
1. Clone the repository.
2. Open `Package.swift` in Xcode or generate a project with `swift package generate-xcodeproj` (requires Xcode on macOS).
3. Replace `YOUR_OPENAI_API_KEY` in `Sources/CalorieApp/AnalysisViewModel.swift` with an OpenAI API key.
4. Build and run the `CalorieApp` target on a real device or simulator.

## Features
- Capture a photo using the device camera.
- Send the photo to OpenAI Vision API and receive structured JSON describing ingredients and calories.
- Edit the detected ingredients and calorie values.
- Save each food entry to local storage and review history in a separate tab.

## Notes
- The project uses a simple JSON file in the app's document directory to store history.
- API calls require network connectivity and a valid OpenAI key.
