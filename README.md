# 021 Trade - Watchlist Flutter Assignment

A production-ready Flutter application demonstrating a dynamic stock watchlist. This project fulfills the assignment requirements by implementing drag-and-drop reordering functionality using the **BLoC (Business Logic Component)** state management pattern and **Feature-First Clean Architecture**.

## Features Highlights
* **Seamless Drag-and-Drop:** Utilizes `ReorderableListView` paired with BLoC to seamlessly swap stock positions with 60fps animations.
* **Pixel-Perfect UI:** Faithfully recreates the target UI, complete with swipeable tabs (`TabBarView`), a bottom navigation bar, and accurate Indian Rupee formatting (`intl`).
* **Live Market Ticker:** Features a background BLoC `Timer` stream that simulates live price fluctuations across the watchlist and top indices.
* **Enterprise Architecture:** Implements the Repository Pattern to decouple data fetching from state management, making the app scalable and API-ready.
* **Edge-Case Handling:** Includes custom "Empty State" and "Error State" UIs to gracefully handle network failures or empty lists.

## Project Structure 
The project is structured to ensure high code reusability, separation of concerns, and maintainability.

- **`core/`**: Centralized design system and app themes.
- **`data/`**: Strictly typed data models and simulated API repositories.
- **`presentation/`**: The UI layer, housing the BLoC logic, screens, and reusable widgets.

## Fulfillment of Assignment Requirements

1. **UI/UX Quality:** The app features a highly polished interface matching the provided video. It includes micro-interactions, swipeable navigation, and a comprehensive bottom navigation bar.
2. **Responsiveness:** Built utilizing Flutter's intrinsic layout builders to guarantee zero overflow errors across screen sizes.
3. **Code Quality & Reusability:** UI complexity is reduced by extracting components into standalone, reusable widgets. 
4. **Code Type Safety:** Relies on Dart's strict static typing. The `Stock` model extends the `equatable` package to guarantee accurate state comparisons.
5. **BLoC Implementation:** Strictly adheres to BLoC architecture. Data flows unidirectionally from Events to immutable States. The logic precisely handles list index offsets during swaps and manages asynchronous data streams for the live ticking prices.

## How to Run the Project

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/pooja99-verma/021-trade-watchlist.git](https://github.com/pooja99-verma/021-trade-watchlist.git)


2. **Navigate to the project directory:**

 Bash
cd 021-trade-watchlist

3. **Install dependencies:**

Bash
flutter pub get

4.**Run the app:**

Bash
flutter run

## Application Demonstration

Watch the live market ticker and drag-and-drop functionality in action:

https://github.com/user-attachments/assets/d3ce1eee-583b-4e1d-95fb-b2b2ae07a226

