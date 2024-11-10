# NewsCloud

Overview:
The app provides users with up-to-date news articles based on different categories, such as Technology, Sports, Health, Science, and Business. It supports infinite scrolling, allowing users to load more articles as they scroll down. The app dynamically fetches the latest articles using the News API, and it enables users to change categories and view different sets of articles.

Key Features:
Dynamic News Categories:

Users can view news articles in various categories, including:
1.Technology
2.Sports
3.Health
4.Science
5.Business
Categories are visually represented with icons/images, and users can easily switch between them.
Infinite Scrolling:

The app supports unlimited scrolling. As the user scrolls down the list of articles, the app automatically fetches more articles based on the current page and category.
Pagination is handled behind the scenes, ensuring that the user always has new content to read without having to manually load more articles.
Article Display:

Each article is displayed with an image (if available), title, and a short description (sub-title).
Articles are visually organized, with a clean and user-friendly interface.
Category Selection:

At the top of the app, a horizontal scrollable list of categories allows the user to choose which type of news they want to read.
When a user taps on a category, the app refreshes the articles based on the selected category.
Loading Indicators:

A loading spinner appears when the app is fetching articles or loading more content, improving the user experience during data retrieval.
A "no more articles" notification is shown when all articles for the current page and category have been loaded.
User Experience:
Home Screen: The app's main screen displays a series of category buttons at the top (representing various news categories) and a list of news articles underneath. Each article shows an image, title, and short description.
Category Selection: When a category is selected, the app fetches the corresponding articles and displays them in a list. Users can easily switch between categories without needing to leave the page.
Scroll and Load: As the user scrolls, new articles are automatically loaded and appended to the list without requiring the user to tap a "load more" button. This is done using infinite scrolling and pagination.
Technical Stack:
Backend: News articles are fetched from a third-party API (News API) that provides real-time news updates across various categories.
Frontend: The app is built with Flutter, ensuring cross-platform compatibility across both iOS and Android devices.
State Management: The app uses stateful widgets to manage the current state of categories, articles, and pagination.
API Integration: Dio is used to handle HTTP requests to fetch news articles dynamically. The app handles paginated requests based on the selected category and current page.
