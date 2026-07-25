# 🥇 Gold & Silver Live Prices

![Flutter](https://img.shields.io/badge/Flutter-3.9+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)

A sleek Flutter application that fetches **real-time gold and silver prices** from a live API and displays per-gram prices across multiple purity levels.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔴 **Live Gold Prices** | Real-time gold prices for 24K, 21K, and 18K per gram |
| ⚪ **Live Silver Prices** | Real-time silver prices for 999, 925, and 800 purity per gram |
| 🌐 **REST API Integration** | Powered by [Gold-API](https://www.gold-api.com/) for accurate market data |
| ⚡ **Reactive State Management** | Built with **Flutter BLoC / Cubit** for clean, reactive UI updates |
| 🏗️ **Clean Architecture** | Organized with a feature-based folder structure (Data → Repository → Cubit → UI) |
| 📱 **Cross-Platform** | Runs on Android, iOS, Web, Windows, macOS, and Linux |

---

## 📸 Screenshots

<!-- Add your screenshots here -->
<!-- ![Home Screen](screenshots/home.png) -->
<!-- ![Gold Price](screenshots/gold.png) -->
<!-- ![Silver Price](screenshots/silver.png) -->

---

## 🏗️ Architecture

The project follows a **feature-based clean architecture** pattern:

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── constants/
│   │   ├── app_colors.dart            # Theme colors
│   │   ├── app_images.dart            # Asset paths
│   │   └── app_strings.dart           # Static strings
│   ├── networking/
│   │   ├── api_constants.dart         # Base URL & endpoints
│   │   └── dio.helper.dart            # Dio HTTP client setup
│   ├── presentation/
│   │   └── home.dart                  # Home screen (Gold / Silver selection)
│   ├── routing/
│   │   ├── app_router.dart            # Route generator
│   │   └── routes.dart                # Route names
│   ├── services/                      # (Reserved for future services)
│   └── widgets/
│       └── custombutton.dart          # Reusable button widget
└── featuers/
    └── coin/
        ├── data/
        │   ├── models/
        │   │   └── coinmodel.dart     # CoinModel with purity getters
        │   └── repo/
        │       └── coinrepo.dart      # Repository (API → Model)
        └── presentation/
            ├── cubit/
            │   ├── coincubit.dart      # Cubit (business logic)
            │   └── coinstates.dart     # States (Initial / Loading / Success / Error)
            └── screens/
                ├── goldpage.dart       # Gold price display screen
                └── silverpage.dart     # Silver price display screen
```

---

## 🔗 API

This app uses the **[Gold-API](https://www.gold-api.com/)** to fetch live precious metal prices.

| Endpoint | Description |
|---|---|
| `GET /price/XAU` | Returns the current gold ounce price in USD |
| `GET /price/XAG` | Returns the current silver ounce price in USD |

**Price conversion formula:**

```
Price per gram = Price per troy ounce ÷ 31.1035
```

| Metal | Purity | Formula |
|---|---|---|
| Gold 24K | 99.9% | `gramPrice` |
| Gold 21K | 87.5% | `gramPrice × (21 / 24)` |
| Gold 18K | 75.0% | `gramPrice × (18 / 24)` |
| Silver 999 | 99.9% | `gramPrice` |
| Silver 925 | 92.5% | `gramPrice × 0.925` |
| Silver 800 | 80.0% | `gramPrice × 0.800` |

---

## 📦 Dependencies

| Package | Version | Purpose |
|---|---|---|
| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | ^9.1.1 | State management (Cubit) |
| [dio](https://pub.dev/packages/dio) | ^5.9.1 | HTTP client for API calls |
| [dartz](https://pub.dev/packages/dartz) | ^0.10.1 | Functional programming (`Either` for error handling) |

### Dev Dependencies

| Package | Version | Purpose |
|---|---|---|
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | ^0.13.1 | Custom app icon generation |
| [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) | ^2.3.1 | Native splash screen |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `>= 3.9.2`
- **Dart SDK** `>= 3.9.2`

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/silver_gold_price.git
   cd silver_gold_price
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate app icons** *(optional)*

   ```bash
   dart run flutter_launcher_icons
   ```

4. **Generate splash screen** *(optional)*

   ```bash
   dart run flutter_native_splash:create
   ```

5. **Run the app**

   ```bash
   flutter run
   ```

---

## 🛠️ Tech Stack

```
Flutter (UI Framework)
 └── flutter_bloc / Cubit (State Management)
      └── Repository Pattern (Data Layer)
           └── Dio (HTTP Client)
                └── Gold-API (REST API)
```

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---
