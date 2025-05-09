# Product List App

A Flutter mobile application that fetches and displays a list of products from a public API. Each product is shown in a card format with essential details, including name, category, brand, and price. The app supports multi-language, multi-theme, pagination, pull-to-refresh, and handles loading and error states gracefully.

## 🚀 Features

* ✅ Fetch products from [LaravelPoint ProductList API](https://laravelpoint.com/api/ProductList)
* ✅ Display products in a card layout:

  * Product Name
  * Category
  * Brand
  * Price
  * Product Image (with placeholder if missing)
* ✅ Pull-to-refresh functionality
* ✅ Infinite scrolling with pagination
* ✅ Search functionality using debouncing
* ✅ Loading indicator while fetching data
* ✅ Error state UI when API request fails
* ✅ Multi-language support (using `flutter_localizations` and `intl`)
* ✅ Multi-theme support
* ✅ Clean Architecture
* ✅ SOLID principle

## 🛠️ Getting Started

### Prerequisites

* Flutter SDK (version 3.29.2 recommended)
* Android Studio / Xcode / VS Code
* A connected device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/Pritom-Shajed/zatiq.git
   cd zatiq
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate Code**

    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4. **Run the app**

   ```bash
   flutter run
   ```

## 📦 API Reference

* **Endpoint**: `https://laravelpoint.com/api/ProductList`
* **Method**: `GET`
* **Pagination**: Add `?page=1`, `?page=2`, etc.
* **Search**: Use query param `?search=keyword` to filter results

  **Examples:**

  * `https://laravelpoint.com/api/ProductList?page=1&search=canon`

## 📁 Folder Structure (Clean Architecture)

```plaintext
lib/
└── src/
    ├── core/                     # Core utilities, theme, config, etc.
    ├── features/
    │   └── home/                 # Feature: Home/Product List
    │       ├── data/             # Data layer (models, sources, repositories)
    │       │   ├── models/
    │       │   ├── repository/
    │       │   └── source/
    │       ├── domain/           # Domain layer (entities, repositories, usecases)
    │       │   ├── entities/
    │       │   ├── repository/
    │       │   └── usecase/
    │       └── presentation/     # UI layer (blocs, components, screens)
    │           ├── bloc/
    │           ├── components/
    │           └── home_page.dart
    ├── settings/                 # App settings & configs
    ├── localization/             # i18n and localization files
    ├── app.dart
    ├── injector.dart
    ├── hive_registrar.g.dart
    └── main.dart
```

## 📦 Packages Used

Below is a list of the major packages used in this project:

| Package                                           | Purpose                                                             |
| ------------------------------------------------- | ------------------------------------------------------------------- |
| `flutter_bloc`                                    | State management                                                    |
| `get_it`                                          | Dependency injection                                                |
| `dartz`                                           | Functional programming utilities                                    |
| `logger`                                          | Logging                                                             |
| `go_router`                                       | Declarative routing                                                 |
| `go_transitions`                                  | Transition animations for Go Router                                 |
| `flutter_dotenv`                                  | Load environment variables                                          |
| `hive_ce`, `hive_ce_flutter`, `hive_ce_generator` | Local storage with code generation                                  |
| `intl`                                            | Internationalization and formatting                                 |
| `flutter_easyloading`                             | Customizable loading indicators                                     |
| `flutter_spinkit`                                 | Animated loading spinners                                           |
| `flutter_svg`                                     | SVG image rendering                                                 |
| `url_launcher`                                    | Launch URLs in the device browser or apps                           |
| `dio`                                             | Advanced HTTP client                                                |
| `freezed`, `freezed_annotation`                   | Immutable data classes and union types                              |
| `form_builder_validators`                         | Form validation                                                     |
| `fluttertoast`                                    | Toast messages                                                      |
| `cached_network_image`                            | Network image caching                                               |
| `solar_icon_pack`                                 | Icon pack                                                           |
| `build_runner`                                    | Code generation tool                                                |
| `flutter_lints`                                   | Flutter recommended lints                                           |
| `rename_app`, `change_app_package_name`           | Utility packages for renaming the app and changing the package name |

## ⚠️ Known Issues

* The API occasionally returns a **309 error** due to too many requests being sent in a short time. It is recommended to implement rate-limiting or caching to minimize excessive calls.