# Weather App 🌤️

This is a simple weather app built using Flutter and the OpenWeatherMap API. The app provides real-time weather information, allows users to search for weather in specific locations, and maintains a history of recent searches.

## Features
- **Search Screen**: Users can search for weather information by city name.
- **Weather Details Screen**: Displays detailed weather data for the selected city, including temperature, humidity, and a brief weather description.
- **Search History Screen**: Displays a list of recent searches, allowing users to quickly revisit previously searched locations.

---

## Development Process

### Choosing the API
I chose **OpenWeatherMap API**  for its comprehensive weather data and ease of integration. It provides current weather data, including temperature, humidity, wind speed, and more, making it an ideal choice for this project.

### Screens and Functionalities

1. **Search Screen**
   - Allows users to input a city name and search for weather details.
   - Handles user input validation (e.g., empty fields).
   - Initiates an API call to fetch weather data.

2. **Weather Details Screen**
   - Displays detailed weather information for the selected city.
   - Data includes:
     - Current temperature.
     - Humidity level.
     - Weather condition description.
     - A weather icon representing the current condition.
   - Provides navigation back to the search screen.

3. **Search History Screen**
   - Lists all recent searches made by the user.
   - Allows users to tap on a history item to view its weather details again.

### Challenges and Solutions

#### 1. **API Integration**
   - **Challenge**: Understanding the API response structure and implementing HTTP requests.
   - **Solution**: Carefully studied the OpenWeatherMap API documentation and used tools like Postman to test API responses before integrating them into the app.

#### 2. **State Management**
   - **Challenge**: Managing data across screens, such as maintaining the search history and ensuring the UI updates appropriately.
   - **Solution**: Used the **Provider** package for state management, which provided a clean and scalable way to share data between widgets.

#### 3. **Error Handling**
   - **Challenge**: Handling network errors and invalid user inputs.
   - **Solution**: Implemented error handling to display appropriate error messages for scenarios like:
     - No internet connection.
     - Invalid city names or no results found.
     - API rate limits being exceeded.

#### 4. **UI/UX Design**
   - **Challenge**: Designing a user-friendly interface that is both functional and visually appealing.
   - **Solution**: Kept the design minimal and clean with intuitive navigation between screens. Used Flutter's built-in widgets and custom styling for a responsive UI.

