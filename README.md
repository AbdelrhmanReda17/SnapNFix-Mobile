# SnapNFix Mobile 📱  
  
A Flutter-based mobile application that empowers citizens to report and track urban infrastructure issues in their communities. SnapNFix enables users to photograph problems like potholes, damaged manholes, garbage accumulation, and other urban concerns, submit reports with location data, and track resolution progress.    
  
## 🌟 Features  
  
### Core Capabilities  
- **Photo-based Issue Reporting**: Capture infrastructure problems with automatic location tagging  
- **Real-time Issue Tracking**: Monitor report status and resolution progress    
- **Interactive Map Visualization**: View nearby issues and their current status  
- **Area-based Subscriptions**: Receive updates for specific geographical areas  
- **Offline Support**: Submit reports without internet connection with automatic synchronization  
- **Multi-language Support**: Available in Arabic and English  
- **User Authentication**: Secure user profiles and report management  
  
### Advanced Features  
- **Intelligent Report Categorization**: Issues classified by category and severity levels  
- **Community Engagement**: Track community reports and area health statistics  
- **Push Notifications**: Real-time updates via Firebase Cloud Messaging  
- **Device Preview Support**: Development tools for testing across multiple screen sizes   
  
## 🛠️ Technology Stack  
  
### Core Framework  
- **Flutter** (^3.7.0) - Cross-platform mobile development  
- **Dart** (^3.7.0) - Programming language  
  
### State Management & Architecture    
- **flutter_bloc** (^9.1.0) - State management with BLoC pattern  
- **hydrated_bloc** (^10.0.0) - Persistent state management  
- **get_it** (^8.0.3) - Dependency injection  
- **injectable** (^2.5.0) - Code generation for dependency injection
  
### Backend & Services  
- **Firebase Core** (^3.12.1) - Backend infrastructure  
- **Firebase Messaging** (^15.2.7) - Push notifications    
- **Sentry Flutter** - Crash reporting and error monitoring 
  
### Development Tools  
- **build_runner** (^2.4.15) - Code generation  
- **injectable_generator** (^2.6.2) - Dependency injection generation  
- **retrofit** (^4.4.2) - HTTP client generation  
- **freezed** (^2.4.5) - Data class generation  
  
## 📋 Prerequisites  
  
- **Flutter SDK**: Version 3.7.0 or higher  
- **Dart SDK**: Version 3.7.0 or higher    
- **Firebase CLI**: Latest version for backend configuration  
- **Android SDK**: API level 34+ for Android development  
- **Java/Kotlin**: JDK 17, Kotlin 11 for Android compilation    
  
## 🚀 Installation & Setup  
  
### 1. Clone Repository  
```bash  
git clone https://github.com/AbdelrhmanReda17/SnapNFix-Mobile.git  
cd SnapNFix-Mobile  
```  
  
### 2. Install Dependencies  
```bash  
flutter pub get  
```  
  
### 3. Generate Code & Localizations  
```bash  
flutter gen-l10n  
flutter pub run build_runner build --delete-conflicting-outputs  
```  
  
### 4. Firebase Configuration  
The application uses Firebase for backend services. Configuration files are included:  
- `firebase.json` - Project configuration  
- `android/app/google-services.json` - Android Firebase settings    
- `lib/firebase_options.dart` - Platform-specific options  
  
## 🏗️ Project Structure  
  
```  
lib/  
├── core/                          # Core utilities and services  
│   ├── infrastructure/           # Location, messaging, networking services  
│   ├── dependency_injection/     # GetIt configuration  
│   └── config/                   # App configurations  
├── modules/                      # Feature modules  
│   ├── authentication/          # User authentication  
│   ├── reports/                 # Issue reporting system    
│   ├── issues/                  # Issue management  
│   └── area_updates/            # Area subscription system  
├── presentation/                # UI components and screens  
│   ├── screens/                 # Application screens  
│   └── navigation/              # Routing configuration  
├── l10n/                        # Localization files  
└── main_production.dart         # Production entry point  
```
[8](#0-7)   
  
## 🎯 Running the Application  
  
### Development Mode  
Includes DevicePreview for testing multiple screen sizes:  
```bash  
flutter run --flavor development --target lib/main_development.dart  
```  
  
### Production Mode    
Includes Sentry crash reporting:  
```bash  
flutter run --flavor production --target lib/main_production.dart  
```
  
## 📱 Key Features Implementation  
  
### Reports System  
The core reporting functionality supports both online and offline operations with automatic synchronization. Users can submit detailed reports with photos and location data, with fallback to local storage when offline.
  
### Location Services  
Automatic location capture and address resolution for precise issue reporting.
  
### Offline Support  
Intelligent offline/online detection with automatic synchronization of pending reports when connectivity is restored.
  
## 🔧 Build Configuration  
  
The application supports multiple build flavors:  
  
- **Development**: `applicationIdSuffix: ''`, includes debugging tools  
- **Production**: Standard build with crash reporting.
  
## 🚀 CI/CD Pipeline  
  
Automated build and distribution using:  
- **GitHub Actions**: Windows-based runners with Flutter 3.29.0  
- **Fastlane**: Automated dependency installation and Firebase App Distribution  
- **Firebase App Distribution**: Automatic deployment to testers.
  
## 🤝 Contributing  
  
1. Fork the repository  
2. Create a feature branch (`git checkout -b feature/xx-feature`)  
3. Commit your changes (`git commit -m 'Add some xx feature'`)  
4. Push to the branch (`git push origin feature/xx-feature`)  
5. Open a Pull Request  
  
### Development Workflow  
- Run code generation after modifying models: `flutter pub run build_runner build`  
- Update localizations: `flutter gen-l10n`  
- Follow clean architecture principles and maintain module separation  
  
## 📄 License  
  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  
