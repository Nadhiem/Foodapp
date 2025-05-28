# Product Requirements Document

This project implements an iOS app similar to CalAI. The app allows users to capture a photo of food and uses OpenAI's Vision API to analyse ingredients and calories.

## Features
1. **Camera Capture** – Take a picture of a meal using the device camera.
2. **Vision Analysis** – Send the photo to OpenAI's Vision API and receive a JSON list of ingredients with calories.
3. **Editing View** – Allow users to edit ingredient names and calorie values. Total calories update in real time.
4. **History Log** – Save each entry with date and ingredients. Display past logs in a history tab.

## API
`POST https://api.openai.com/v1/chat/completions`
- Uses `gpt-4-turbo` model
- Request contains a prompt and an image encoded as base64.
- Response expected as JSON in the form:
```json
{
  "ingredients": [
    {"name": "Apple", "calories": 95},
    {"name": "Banana", "calories": 110}
  ]
}
```

## Data Models
- `Ingredient` – id, name, calories, quantity?
- `FoodEntry` – id, date, list of ingredients, computed totalCalories

## Storage
Entries are persisted as JSON in the app's `Documents` directory (`food_history.json`).
