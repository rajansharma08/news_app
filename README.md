# DTown News App

A Flutter Android application that displays news headlines and article details using the [NewsAPI](https://newsapi.org).

## Features

- 📰 Live news headlines from NewsAPI
- 📖 Full article detail screen
- 📵 Offline support — cached articles available without internet
- 🎨 Pixel-perfect UI matching design spec
- ✨ Hero animation and fade transitions between screens
- 🔄 Pull to refresh for latest news

## Screens

### Screen 1 — News Detail
- Full screen background image
- Article title, source, date and description
- Back navigation

### Screen 2 — Headlines List
- Scrollable list of news cards
- Article image, headline, source and date
- Shimmer loading effect

## Tech Stack

| Category | Library |
|---|---|
| Networking | Dio |
| Local Persistence | Hive |
| State Management | Provider |
| Image Loading | CachedNetworkImage |
| Fonts | Google Fonts (Roboto Slab) |
| Loading Effect | Shimmer |
| Connectivity | Connectivity Plus |

## Project Structure
```
lib/
├── main.dart
├── models/
│   └── article.dart
├── services/
│   ├── api_service.dart
│   └── db_service.dart
├── repositories/
│   └── news_repository.dart
├── providers/
│   └── news_provider.dart
├── screens/
│   ├── headlines_screen.dart
│   └── detail_screen.dart
└── widgets/
    ├── article_card.dart
    └── shimmer_card.dart
```

## Setup & Run

1. Clone the repository
2. Add your NewsAPI key in `lib/services/api_service.dart`
3. Run the app:
```bash
flutter pub get
flutter run
```

## Offline Support

Articles are cached locally using Hive on first load.
App serves cached articles automatically when internet is unavailable.