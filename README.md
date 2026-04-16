# Cine Stream

[![Flutter](https://camo.githubusercontent.com/727029ffb2e4ee9c9110bd27f97160af71bdb934a07dc98b0a8a640e3aa41bc9/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f466c75747465722d2532333032353639422e7376673f7374796c653d666f722d7468652d6261646765266c6f676f3d466c7574746572266c6f676f436f6c6f723d7768697465)](https://flutter.dev)
[![Dart](https://camo.githubusercontent.com/1a4ea15d472e6b0214711a83346c566f2ed4efecf62c4c29efb92a2f89c11256/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f646172742d2532333031373543322e7376673f7374796c653d666f722d7468652d6261646765266c6f676f3d64617274266c6f676f436f6c6f723d7768697465)](https://dart.dev)
![Dio](https://img.shields.io/badge/Dio-2196F3?style=for-the-badge&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-8A2BE2?style=for-the-badge&logo=flutter&logoColor=white)
![Flutter Form Builder](https://img.shields.io/badge/Flutter%20Form%20Builder-FF9800?style=for-the-badge&logo=flutter&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![MIT License](https://img.shields.io/badge/License-MIT-000000?style=for-the-badge)

**Cine Stream** is a Flutter movie-discovery app that helps users browse trending and categorized films, inspect details and recommendations, keep a personal favourites list, and sign in with a demo-friendly auth flow. Movie metadata, images, search, and genre discovery are powered by **[The Movie Database (TMDB)](https://www.themoviedb.org/)**; authentication uses **[DummyJSON](https://dummyjson.com/)** for login and user profile data.

---

## Screenshots / Demo

![App Overview](assets/App_Overview.gif)

---

## Key Features

- **Splash & session check** — Branded splash; after a short delay, routes to login or home based on `SharedPreferences`.
- **User login** — Username/password form with validation; successful login persists user JSON and a login flag, then opens the main experience.
- **Home discovery** — Gradient UI with search field, **now playing** carousel (`carousel_slider`), editorial **“Our choice”** spotlight, **genre grid** (TMDB genre IDs with local styling), and **popular** horizontal list.
- **Search** — Text search against TMDB; results in a **two-column grid** with posters via `cached_network_image`; optional **clear search** with toast feedback.
- **Browse by genre** — From the home genre list, loads movies for a selected TMDB genre ID (`discover/movie`).
- **Movie detail** — Backdrop hero, rating, year, genre chips, overview, **related recommendations** from TMDB, favourite toggle, and shortcut to the favourites tab.
- **Favourites (watchlist)** — Add/remove movies; list persisted in `SharedPreferences` as JSON strings.
- **Profile** — Shows user avatar, name, and email from the stored `UserModel` after DummyJSON login.
- **Navigation** — Four tabs (Home, Search, Favourites, Profile) via **`crystal_navigation_bar`** and `NavProvider`.
- **Typography** — App-wide **IBM Plex Sans Arabic** font family (see `pubspec.yaml`).
- **Developer tooling** — `pretty_dio_logger` on Dio clients in **debug** mode for request/response inspection.

---

## Tech Stack & Libraries

| Category               | Packages / tech                                                                                                                               |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **Framework**          | Flutter (Material), Dart SDK `^3.11.3`                                                                                                        |
| **State management**   | `provider` (`ChangeNotifier` + `MultiProvider`)                                                                                               |
| **Networking**         | `dio`, `pretty_dio_logger`                                                                                                                    |
| **Forms & validation** | `flutter_form_builder`, `form_builder_validators`                                                                                             |
| **Local persistence**  | `shared_preferences` (login flag, user JSON, favourites)                                                                                      |
| **Images**             | `cached_network_image`                                                                                                                        |
| **UI / navigation**    | `carousel_slider`, `crystal_navigation_bar`, `motion_tab_bar_v2` (wired in `CustomBottomBar`; main shell uses crystal bar), `cupertino_icons` |
| **Feedback**           | `fluttertoast`, `delightful_toast`                                                                                                            |
| **Quality**            | `flutter_lints`                                                                                                                               |

**External APIs**

| API       | Base URL (in code)             | Purpose                                                                 |
| --------- | ------------------------------ | ----------------------------------------------------------------------- |
| TMDB      | `https://api.themoviedb.org/3` | Movies, search, discover, recommendations; images from `image.tmdb.org` |
| DummyJSON | `https://dummyjson.com`        | `POST /auth/login` for demo authentication                              |

---

## Project Architecture & Structure

The app follows a **layered, Provider-based** structure: **screens** compose **widgets**, **providers** hold UI state and call **services**, and **services** use **API clients** to talk to TMDB or DummyJSON. **Models** deserialize JSON; TMDB genre metadata for the UI is partly centralized in `genere_model.dart`, with additional category styling in `constants.dart` (when present).

### `lib/` directory tree

```text
lib/
├── main.dart                 # App entry, MultiProvider, theme, SplashScreen
├── data/
│   ├── api/
│   │   ├── api_client.dart       # Dio client for TMDB + api_key interceptor
│   │   ├── api_endpoints.dart    # Paths & image base URL helpers
│   │   ├── auth_client.dart      # Dio client for DummyJSON
│   │   └── constants.dart        # API_KEY + categories (gitignored — see Setup)
│   ├── models/
│   │   ├── genere_model.dart     # Genre definitions (TMDB ids, colors, icons)
│   │   ├── movie_model.dart
│   │   └── user_model.dart       # DummyJSON user shape
│   └── services/
│       ├── auth_services.dart    # Login + SharedPreferences + navigation
│       └── movies_services.dart  # TMDB fetch helpers
├── providers/
│   ├── favourite_provider.dart
│   ├── movies_provider.dart
│   ├── navBar_provider.dart
│   ├── search_provider.dart
│   ├── selectedMovie_provider.dart
│   └── user_provider.dart
├── screens/
│   ├── SplashScreen.dart
│   ├── LoginScreen.dart
│   ├── RegisterScreen.dart
│   ├── HomeScreen.dart           # Tab shell + crystal bottom bar
│   ├── MainScreen.dart           # Home tab content
│   ├── SearchScreen.dart
│   ├── MovieScreen.dart
│   ├── FavouriteScreen.dart
│   └── ProfileScreen.dart
└── widgets/
    ├── AllGenresList.dart
    ├── BottomNavigationBar.dart  # Motion tab bar (alternate bar widget)
    ├── CineStreamAppBar.dart
    ├── CrystalBar.dart           # Active bottom bar in HomeScreen
    ├── DelightedToastBar.dart
    ├── OurChoiceMovie.dart
    ├── RelatedMoviesBuilder.dart
    ├── SearchBox.dart
    ├── TopRatedList.dart
    └── UpComingMoviesCarousel.dart
```

---

## Getting Started (Installation & Setup)

### Prerequisites

- **Flutter SDK** (stable channel recommended; align with your team’s installed version).
- **Dart** compatible with `environment.sdk: ^3.11.3` in `pubspec.yaml`.
- **Android Studio** / **Android SDK** for Android builds (Gradle Kotlin DSL is used under `android/`).
- For **web**: Chrome (or another supported browser) for `flutter run -d chrome`.

### Steps

1. **Clone** the repository and open the project root (`cinestream`).

2. **Create `lib/data/api/constants.dart`**  
   This file is listed in `.gitignore`, so it is **not** committed. Without it, the project will not analyze or build. Create the file with at least:

   ```dart
   import 'package:flutter/material.dart';

   /// TMDB v3 API key from https://www.themoviedb.org/settings/api
   const API_KEY = 'YOUR_TMDB_API_KEY';

   /// Optional palette used by some layouts; safe to leave empty if unused.
   final List<Map<String, dynamic>> categories = [];
   ```

   Obtain a key from [TMDB API settings](https://www.themoviedb.org/settings/api).

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

   Or target a device explicitly, e.g.:

   ```bash
   flutter run -d android
   flutter run -d chrome
   ```

### Environment variables & API keys

| Secret / config  | Where it lives in this project            | Notes                                                                                    |
| ---------------- | ----------------------------------------- | ---------------------------------------------------------------------------------------- |
| **TMDB API key** | `lib/data/api/constants.dart` → `API_KEY` | Injected on every TMDB request as `api_key` query parameter via `ApiClient` interceptor. |
| **DummyJSON**    | No API key in code                        | Login uses public DummyJSON `POST /auth/login` with username/password in the body.       |

This codebase does **not** use a `.env` file or `flutter_dotenv`. If you prefer environment-based config, you would add a package and refactor `constants.dart` accordingly.

### Trying login

Use credentials that exist on **DummyJSON** (e.g. their documented test users such as `emilys` / `emilyspass` — verify on [dummyjson.com](https://dummyjson.com/) docs as they may change).

---

## Known Issues / To-Do

- **`RegisterScreen`** — Form validates and logs values; there is **no registration API** call or post-sign-up navigation yet.
- **`lib/data/api/constants.dart`** — Ignored by Git; document and share a safe template with teammates (never commit real keys).
- **`CustomBottomBar`** (`motion_tab_bar_v2`) — Present under `widgets/` but **`HomeScreen` uses `CrystalBottomBar`**; consider removing or switching if unused.
- **Android `INTERNET` permission** — Declared in **debug/profile** manifests; confirm your **release** merge / manifest if network fails on release builds.
- **Error handling** — Some Dio failures return synthetic responses or empty lists; user-visible error states could be expanded.
- **SearchBox** — Local `TextEditingController` is not disposed in `dispose()` (minor leak risk on long sessions).

---

## Contact & License

**Author**

- **GitHub:** [3mrNour](https://github.com/3mrNour)
- **LinkedIn:** [Amr Nour](https://www.linkedin.com/in/amrnour1/)
- **Email:** amrnour1010@gmail.com

_Movie data and images courtesy of [The Movie Database (TMDB)](https://www.themoviedb.org/). This app is not endorsed or certified by TMDB._
