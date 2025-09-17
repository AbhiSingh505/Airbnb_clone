# 🏠 Airbnb Clone - SwiftUI iOS App

A comprehensive Airbnb clone built with SwiftUI, featuring modern UI/UX patterns, advanced animations, and a complete property booking experience.

## 📱 Features

### 🏡 Core Functionality
- **Property Listings**: Browse homes, experiences, and services
- **Detailed Property Views**: Comprehensive property details with image galleries, amenities, host information
- **Search & Discovery**: Advanced search with voice recognition, filters, and location-based suggestions
- **Interactive Maps**: Map-based exploration with clustering and location pins
- **User Profiles**: Complete user management system
- **Wishlist Management**: Save and manage favorite properties
- **Trip Planning**: View and manage upcoming trips
- **Messaging System**: Communication with hosts

### 🎨 UI/UX Features
- **Custom Tab Bar**: Animated bottom navigation with matched geometry effects
- **Dynamic Search**: Real-time search with voice input and smart suggestions
- **Parallax Scrolling**: Smooth parallax effects in property detail views
- **Shimmer Loading**: Elegant skeleton loading states throughout the app
- **Collapsible Headers**: Scroll-aware navigation bars that adapt to content
- **Smooth Animations**: Spring-based animations and transitions
- **Haptic Feedback**: Tactile feedback for enhanced user experience

### 🔍 Advanced Search
- **Voice Search**: Speech-to-text search functionality
- **Smart Filters**: Filter by property type, price, location, and amenities
- **Recent Searches**: Quick access to previous search queries
- **Location Suggestions**: Nearby properties and popular destinations
- **Real-time Results**: Instant search results with loading states

### 🗺️ Map Integration
- **Interactive Maps**: Full MapKit integration with custom annotations
- **Location Clustering**: Smart clustering of nearby properties
- **Zoom Controls**: Smooth zoom and pan interactions
- **Price Display**: Property prices shown directly on map pins

## 🏗️ Architecture

### 📁 Project Structure
```
syGroupTask/
├── Models/
│   └── MockData.swift          # Data models and mock data
├── Views/
│   ├── Components/             # Reusable UI components
│   │   ├── CardsView.swift
│   │   ├── CardsDetailView.swift
│   │   ├── CustomTabBar.swift
│   │   ├── SearchBarView.swift
│   │   ├── ShimmerSkeleton.swift
│   │   └── ...
│   ├── ExploreView.swift       # Main explore interface
│   ├── SearchView.swift        # Search functionality
│   ├── MapExploreView.swift    # Map-based exploration
│   └── ...
├── ViewModels/
│   ├── SearchViewModel.swift
│   ├── ExploreViewModel.swift
│   └── ...
├── core/
│   ├── Theme.swift            # App theming and colors
│   ├── SpeechRecognizer.swift # Voice search functionality
│   └── color_hex.swift        # Color utilities
└── Assets.xcassets/           # App assets and images
```

### 🎯 Key Components

#### **ContentView.swift**
- Main app container with tab navigation
- Custom tab bar with animated selection
- Navigation stack management
- Tab bar visibility control

#### **ExploreView.swift**
- Property discovery interface
- Filter tabs (Homes, Experience, Services)
- Horizontal scrolling sections
- Dynamic top bar with scroll awareness

#### **CardsDetailView.swift**
- Comprehensive property detail view
- Image carousel with parallax effects
- Host information and ratings
- Amenities grid and property description
- Interactive booking interface

#### **SearchView.swift**
- Advanced search interface
- Voice search integration
- Recent searches and suggestions
- Real-time search results
- Smart filtering options

#### **MapExploreView.swift**
- Interactive map with property locations
- Custom annotation clustering
- Zoom and filter controls
- Location-based property discovery

## 🛠️ Technical Implementation

### **SwiftUI Features Used**
- **NavigationStack**: Modern navigation system
- **@StateObject & @ObservedObject**: Reactive data binding
- **@Namespace**: Matched geometry effects
- **GeometryReader**: Custom layout calculations
- **LazyVGrid**: Efficient grid layouts
- **TabView**: Image carousels and page views
- **Map**: Native map integration

### **Advanced Animations**
- **Matched Geometry Effects**: Smooth transitions between views
- **Spring Animations**: Natural feeling interactions
- **Parallax Scrolling**: Depth and visual interest
- **Custom Transitions**: Branded animation patterns

### **Data Management**
- **MVVM Architecture**: Clean separation of concerns
- **ObservableObject**: Reactive state management
- **Mock Data System**: Comprehensive test data
- **Image Caching**: Efficient image loading and caching

### **Accessibility & Performance**
- **Voice Search**: Speech recognition integration
- **Haptic Feedback**: Enhanced user interaction
- **Lazy Loading**: Optimized list performance
- **Image Optimization**: Efficient image handling

## 🎨 Design System

### **Color Palette**
- **Primary**: Custom Airbnb-inspired colors
- **Secondary**: Supporting accent colors
- **Text**: Hierarchical text colors
- **Background**: Layered background system

### **Typography**
- **System Fonts**: Native iOS typography
- **Weight Hierarchy**: Clear visual hierarchy
- **Size Scale**: Consistent sizing system

### **Components**
- **Cards**: Consistent property cards
- **Buttons**: Interactive elements
- **Input Fields**: Search and form elements
- **Navigation**: Tab and navigation components

## 🚀 Getting Started

### **Requirements**
- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

### **Installation**
1. Clone the repository
2. Open `syGroupTask.xcodeproj` in Xcode
3. Build and run on iOS Simulator or device

### **Dependencies**
- **SwiftUI**: Native UI framework
- **MapKit**: Map functionality
- **Speech**: Voice recognition
- **AVFoundation**: Audio processing

## 📱 Screenshots

The app includes the following main screens:
- **Explore**: Property discovery with filters
- **Search**: Advanced search with voice input
- **Property Details**: Comprehensive property information
- **Map View**: Interactive property map
- **Profile**: User account management
- **Wishlist**: Saved properties
- **Trips**: Booking management
- **Messages**: Host communication

## 🔧 Customization

### **Theming**
- Modify `Theme.swift` for color changes
- Update `Assets.xcassets` for new images
- Customize component styles in individual view files

### **Data**
- Update `MockData.swift` for new properties
- Modify data models for different property types
- Add new search categories and filters

### **Features**
- Extend search functionality
- Add new property types
- Implement booking system
- Add user authentication

## 🎯 Key Improvements Made

### **Enhanced User Experience**
- ✅ Custom animated tab bar with smooth transitions
- ✅ Collapsible navigation bars with scroll awareness
- ✅ Shimmer loading states for better perceived performance
- ✅ Haptic feedback for tactile interactions
- ✅ Voice search for hands-free operation

### **Advanced UI Components**
- ✅ Parallax image headers in property details
- ✅ Matched geometry transitions between views
- ✅ Custom map annotations with clustering
- ✅ Dynamic search suggestions and filters
- ✅ Comprehensive property detail views

### **Performance Optimizations**
- ✅ Lazy loading for large lists
- ✅ Image caching and optimization
- ✅ Efficient state management
- ✅ Smooth animations and transitions

### **Modern iOS Features**
- ✅ iOS 17+ native components
- ✅ SwiftUI best practices
- ✅ Accessibility support
- ✅ Dark mode compatibility

## 🛣️ Future Enhancements

- [ ] **Real-time Booking**: Complete booking flow
- [ ] **User Authentication**: Login and registration
- [ ] **Payment Integration**: Secure payment processing
- [ ] **Push Notifications**: Real-time updates
- [ ] **Offline Support**: Cached data and offline mode
- [ ] **Social Features**: Reviews and ratings
- [ ] **Advanced Filters**: More search options
- [ ] **Calendar Integration**: Trip planning
- [ ] **Multi-language Support**: Internationalization
- [ ] **Analytics**: User behavior tracking

## 📱 Screenshots

| Explore View | Search Interface | Property Details |
|--------------|------------------|------------------|
| ![Explore](screenshots/01_Explore_View.png) | ![Search](screenshots/02_Search_View.png) | ![Details](screenshots/03_Property_Detail.png) |

| Map View | Tab Bar Animation | Voice Search |
|----------|-------------------|--------------|
| ![Map](screenshots/04_Map_View.png) | ![Tab Bar](screenshots/09_Tab_Bar_Animation.png) | ![Voice](screenshots/10_Voice_Search.png) |

*Note: Screenshots will be added once the app is running. See `screenshots/README.md` for instructions on taking screenshots.*

## 🚀 Quick Start

### Prerequisites
- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/airbnb-clone-swiftui.git
   ```
2. Open `syGroupTask.xcodeproj` in Xcode
3. Build and run on iOS Simulator or device

## 📊 Project Statistics

![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 📁 Repository Structure

```
airbnb-clone-swiftui/
├── 📱 syGroupTask/              # Main iOS project
│   ├── 🎨 Views/               # SwiftUI views and components
│   ├── 🧠 ViewModels/          # MVVM view models
│   ├── 📊 Models/              # Data models and mock data
│   ├── ⚙️ core/                # Core utilities and themes
│   └── 🖼️ Assets.xcassets/     # App assets and images
├── 📸 screenshots/             # App screenshots
├── 📚 Documentation/           # Project documentation
└── 📄 Configuration files     # Git, GitHub, and project configs
```

## 🎯 Key Features Implemented

### ✅ Core Functionality
- [x] Property discovery and browsing
- [x] Advanced search with voice recognition
- [x] Interactive maps with clustering
- [x] Comprehensive property details
- [x] User profiles and wishlists
- [x] Trip management system
- [x] Messaging interface

### ✅ UI/UX Excellence
- [x] Custom animated tab bar
- [x] Parallax scrolling effects
- [x] Shimmer loading states
- [x] Smooth spring animations
- [x] Haptic feedback integration
- [x] Collapsible navigation bars
- [x] Matched geometry transitions

### ✅ Technical Implementation
- [x] MVVM architecture pattern
- [x] SwiftUI best practices
- [x] Reactive state management
- [x] Image caching and optimization
- [x] Voice search integration
- [x] MapKit implementation
- [x] Performance optimization

## 📈 Development Progress

- **Phase 1**: ✅ Core app structure and navigation
- **Phase 2**: ✅ Property discovery and search
- **Phase 3**: ✅ Property details and interactions
- **Phase 4**: ✅ Map integration and clustering
- **Phase 5**: ✅ Advanced features and animations
- **Phase 6**: ✅ Performance optimization and polish

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### How to Contribute
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Areas for Contribution
- 🐛 Bug fixes
- ✨ New features
- 📚 Documentation improvements
- 🧪 Testing and quality assurance
- 🎨 UI/UX enhancements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Apple** for SwiftUI and iOS frameworks
- **Airbnb** for design inspiration
- **Unsplash** for beautiful property images
- **Open source community** for tools and libraries

## 📞 Contact

- **GitHub**: [Your GitHub Profile]
- **LinkedIn**: [Your LinkedIn Profile]
- **Email**: [Your Email]

## 📚 Additional Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [MapKit Documentation](https://developer.apple.com/documentation/mapkit/)
- [Speech Framework](https://developer.apple.com/documentation/speech/)

---

**Built with ❤️ using SwiftUI and modern iOS development practices**

⭐ **Star this repository if you found it helpful!**