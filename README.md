## Yumly Meal Recommendation App

# Overview
Yumly is a Flutter-based mobile application that provides meal recommendations using TheMealDB API. With features like random meal suggestions, recipe exploration, and detailed instructions, Yumly inspires users to cook and enjoy delicious meals.

# Features
1. Home Screen:

Displays a welcome message and app logo.
Buttons to get a random recipe or explore more recipes.
Fetches random recipes dynamically from the API.

2. Explore Screen:

Search bar for finding specific recipes.
Scrollable categories like Breakfast, Dessert, Vegetarian, etc.
List of recipes under each category with thumbnails and names.

3. Recipe Screen:

Displays detailed information about the selected recipe.
Includes ingredients, cooking instructions, and an image of the dish.

# API Information
Name: TheMealDB API
Purpose: Provides data on meal recipes, ingredients, and cooking instructions.
Endpoints Used:
Random meal: /random.php
Meals by category: /filter.php?c={category}
Meal details: /lookup.php?i={id}

# Development Process
API Integration
Used the http package for API calls.
Implemented async/await for asynchronous operations.
Handled errors gracefully with try-catch blocks and fallback placeholders.
State Management
Managed app state using Riverpod for scalability and efficient data sharing across screens.
Navigation
Utilized Navigator and MaterialPageRoute for smooth screen transitions.

# Screens and Functionalities
1. Home Screen
Purpose: Entry point of the app with key actions.
Features:
Displays a random meal suggestion.
Button to navigate to the Explore screen.
2. Explore Screen
Purpose: Explore meal recipes by category.
Features:
Search bar and scrollable categories.
List of recipes filtered by selected categories.
3. Recipe Screen
Purpose: Display detailed recipe information.
Features:
Displays recipe name, image, ingredients, and instructions.

# Challenges and Solutions
1. API Error Handling
Issue: Missing or null data from the API caused crashes.
Solution: Added null checks and fallback placeholders to ensure smooth functionality.
2. State Management
Issue: Managing shared data across screens was challenging.
Solution: Used Riverpod for centralized and scalable state management.
3. Responsive UI
Issue: Ensuring UI adapts to different screen sizes and orientations.
Solution: Used MediaQuery for dynamic sizing and wrapped content in scrollable widgets.
4. Button Differentiation
Issue: Confusion between "Random Recipe" and "Explore More" buttons.
Solution: Styled the "Explore More" button with a distinct color and text.

# Links
The MealDb: [https://www.themealdb.com/](url)
