# 🍔 Foodgo - Food Delivery App

A Flutter-based food delivery application with user authentication, food browsing, and profile management features.

## 📱 Features

- **Authentication System**
  - Login with email/password
  - Secure token storage using SharedPreferences
  - Auto-login on app restart
  - Logout with confirmation dialog

- **Splash Screen**
  - Beautiful background with Foodgo branding
  - Auto-navigation based on login status
  - "Start Now" button for manual navigation

- **Home Screen**
  - Browse food items with grid layout
  - Category filters (All, Combos, Sliders, Classifieds)
  - Search functionality
  - Settings shortcut
  - Food items with ratings and favorites
  - Animated bottom navigation bar

- **Profile Screen**
  - User information display (email, username)
  - Logout option
  - Edit profile (coming soon)
  - Settings (coming soon)
  - Help & Support (coming soon)

## 🛠️ Tech Stack

- **Flutter SDK 3.7.0+**
- **State Management:** Provider
- **Networking:** Dio
- **Local Storage:** SharedPreferences
- **Responsive Design:** flutter_screenutil
- **Navigation:** animated_bottom_navigation_bar
- **Custom Fonts:** Inter, Lobster

## 📦 Installation

### Prerequisites
- Flutter SDK 3.7.0 or higher
- Android Studio / VS Code
- Android Emulator or Physical Device

### Step-by-Step Setup

#### 1. Clone the repository
```bash
git clone https://github.com/yourusername/foodgo.git
cd foodgo
