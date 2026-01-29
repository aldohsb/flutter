# Kurikulum Flutter 500 Hari - Part 3 (Hari 101-150)
## Fase State Management & Data: Provider, BLoC, dan Networking

### Hari 101-102: Recipe App UI - Completion
**Lanjutan dari Hari 100**

Melanjutkan dan menyelesaikan Recipe App UI dengan polish final, bug fixes, dan optimizations.

---

### Hari 103: State Management - Introduction
* Apa itu state management
* Local vs app-wide state
* Lifting state up
* State management options overview

**Project:** State Management Demo
- Counter dengan local state
- Counter dengan lifted state
- Shared state between widgets
- Compare different approaches
- Understand state flow

---

### Hari 104: InheritedWidget
* InheritedWidget basics
* Accessing data dari descendant widgets
* When widget rebuilds
* Custom InheritedWidget

**Project:** Theme Provider dengan InheritedWidget
- Custom InheritedWidget untuk theme
- Access theme dari any widget
- Update theme globally
- Efficient rebuilds
- Dark/light mode switch

---

### Hari 105: Provider Package - Basics
* Provider package installation
* ChangeNotifier
* Consumer widget
* Provider.of()

**Project:** Counter dengan Provider
- ChangeNotifier class untuk counter
- Provide counter ke widget tree
- Multiple consumers
- Increment/decrement dari different screens
- State persistence across navigation

---

### Hari 106: Provider - ChangeNotifierProvider
* ChangeNotifierProvider
* MultiProvider
* notifyListeners()
* Best practices

**Project:** Shopping Cart (Provider)
- Product list
- Add to cart functionality
- Cart badge dengan item count
- Update UI saat cart changes
- Multiple providers

---

### Hari 107: Provider - Consumer vs Selector
* Consumer widget optimization
* Selector untuk granular updates
* When to use each
* Performance considerations

**Project:** Optimized Todo App
- Todo list dengan Provider
- Selector untuk individual todos
- Efficient rebuilds
- Filter todos (all, active, completed)
- Minimize unnecessary rebuilds

---

### Hari 108: Provider - ProxyProvider
* ProxyProvider
* Depending on other providers
* Complex dependency chains
* Use cases

**Project:** User Profile dengan Dependencies
- AuthProvider
- UserProvider depends on AuthProvider
- PreferencesProvider depends on UserProvider
- Chained provider dependencies
- Proper dependency management

---

### Hari 109: Provider - FutureProvider & StreamProvider
* FutureProvider untuk async data
* StreamProvider untuk streams
* Loading dan error handling
* Async state management

**Project:** Weather App dengan FutureProvider
- Fetch weather data
- FutureProvider untuk API call
- Loading state
- Error handling
- Refresh functionality

---

### Hari 110: State Management - setState Review
* When setState is enough
* setState best practices
* Performance implications
* setState vs Provider comparison

**Project:** Feature Comparison App
- Same feature dengan setState
- Same feature dengan Provider
- Performance comparison
- Code complexity comparison
- Decision guide

---

### Hari 111: BLoC Pattern - Introduction
* BLoC pattern concepts
* Streams dan sinks
* Separating business logic
* BLoC benefits

**Project:** Simple BLoC Implementation
- Manual BLoC untuk counter
- StreamController usage
- Sink untuk input
- Stream untuk output
- Dispose properly

---

### Hari 112: flutter_bloc Package - Basics
* flutter_bloc package
* Cubit basics
* BlocBuilder
* BlocProvider

**Project:** Counter dengan Cubit
- Create Counter Cubit
- Emit states
- BlocBuilder untuk UI updates
- Multiple actions (increment, decrement, reset)
- Clean architecture

---

### Hari 113: BLoC - States & Events
* Defining states
* Defining events
* State transitions
* Event handlers

**Project:** Authentication BLoC
- Login/logout events
- Authentication states (initial, loading, authenticated, error)
- State transitions
- Form validation dalam BLoC
- Error handling

---

### Hari 114: BLoC - BlocListener & BlocConsumer
* BlocListener untuk side effects
* BlocConsumer (builder + listener)
* When to use each
* Navigation dari BLoC

**Project:** Task Manager dengan BLoC
- Task list dengan BLoC
- BlocListener untuk show snackbars
- BlocConsumer untuk UI + side effects
- Navigate after task completion
- Success/error notifications

---

### Hari 115: BLoC - MultiBlocProvider
* Providing multiple BLoCs
* BLoC composition
* Dependency injection
* App-wide BLoC structure

**Project:** Multi-Feature App dengan BLoC
- Multiple feature BLoCs
- Shared BLoCs
- Feature isolation
- Clean DI setup
- Scalable structure

---

### Hari 116: BLoC Testing
* Testing BLoCs
* blocTest package
* Mocking
* Test coverage

**Project:** Tested BLoC Implementation
- Write comprehensive tests untuk BLoC
- Test all states
- Test all events
- Mock dependencies
- High test coverage

---

### Hari 117: GetX - Introduction
* GetX overview
* Reactive state management
* GetX controllers
* Obs variables

**Project:** Counter dengan GetX
- GetX controller
- Reactive variables
- Obx widget untuk rebuilds
- Simple state management
- Minimal boilerplate

---

### Hari 118: GetX - Dependency Injection
* Get.put, Get.lazyPut
* Get.find
* Dependency lifecycle
* Controller lifecycle

**Project:** Multi-Controller App dengan GetX
- Multiple controllers
- Dependency injection
- Controller communication
- Proper disposal
- Lazy loading

---

### Hari 119: GetX - Route Management
* GetX navigation
* Named routes dengan GetX
* Arguments passing
* Navigation without context

**Project:** GetX Navigation Demo
- Multiple screens dengan GetX routes
- Named routes
- Pass data between screens
- Dynamic routes
- Bottom sheets dan dialogs

---

### Hari 120: Riverpod - Introduction
* Riverpod basics
* Providers in Riverpod
* ConsumerWidget
* Compile-safe providers

**Project:** Counter dengan Riverpod
- StateProvider usage
- ConsumerWidget
- Reading providers
- Updating state
- Type-safe state management

---

### Hari 121: Riverpod - Different Provider Types
* Provider
* StateProvider
* FutureProvider
* StreamProvider
* StateNotifierProvider

**Project:** Data Fetching dengan Riverpod
- FutureProvider untuk API calls
- StateNotifierProvider untuk complex state
- Combination of providers
- Loading/error states
- Refresh functionality

---

### Hari 122: Comparing State Management Solutions
* Provider vs BLoC vs GetX vs Riverpod
* When to use each
* Performance comparison
* Learning curve
* Project suitability

**Project:** Same App dengan Different Solutions
- Implement identical feature dengan each
- Compare code complexity
- Compare performance
- Compare developer experience
- Decision matrix

---

### Hari 123: HTTP Package & REST APIs
* http package
* GET requests
* POST requests
* Headers dan authentication
* Error handling

**Project:** API Client Wrapper
- Create reusable API client class
- GET, POST, PUT, DELETE methods
- Error handling
- Response parsing
- Base URL configuration

---

### Hari 124: Dio Package
* Dio installation
* Interceptors
* Request/response transformation
* Advanced features

**Project:** Dio API Service
- Dio client setup
- Logging interceptor
- Auth token interceptor
- Error handling interceptor
- Timeout configuration

---

### Hari 125: JSON Serialization - Manual
* JSON parsing review
* fromJson/toJson methods
* Nested objects
* Lists dalam JSON

**Project:** Complex JSON Parsing
- Multi-level nested JSON
- Parse array of objects
- Optional fields handling
- Date parsing
- Type conversions

---

### Hari 126: json_serializable Package
* Code generation dengan json_serializable
* @JsonSerializable annotation
* build_runner
* Automatic serialization

**Project:** Generated Model Classes
- Models dengan json_serializable
- Run build_runner
- Use generated code
- Update models
- Regenerate code

---

### Hari 127: Freezed Package
* Freezed for immutable classes
* Union types
* copyWith
* Code generation

**Project:** Freezed Models & States
- Freezed models untuk data
- Union types untuk states (loading, success, error)
- copyWith for updates
- Immutable state management
- Type-safe state handling

---

### Hari 128: API Integration - CRUD Operations
* Complete CRUD dengan API
* Create, Read, Update, Delete
* State management dengan API
* Optimistic updates

**Project:** Notes App dengan API (Hari 128-130)
- **Hari 128**: Setup & Read
  - API client setup
  - Fetch notes dari API
  - Display dalam list
  - Loading states
  - Error handling

---

### Hari 129: Notes App - Create & Update
**Lanjutan Project Notes App**
- Create new note API call
- Edit existing note
- Form validation
- Optimistic UI updates
- Success feedback

---

### Hari 130: Notes App - Delete & Polish
**Lanjutan Project Notes App**
- Delete note functionality
- Confirmation dialog
- Undo delete
- Refresh data
- Final polish dan error handling

---

### Hari 131: Pagination
* Implementing pagination
* Load more on scroll
* Page-based vs cursor-based
* Loading indicators

**Project:** Paginated List
- Infinite scroll list
- Load more saat reach bottom
- Loading indicator at bottom
- Handle end of data
- Pull to refresh

---

### Hari 132: Search & Filtering
* Implementing search
* Debouncing search input
* Filter options
* Combining search dan filter

**Project:** Product Search & Filter
- Search bar dengan debouncing
- Multiple filter options (category, price range)
- Combine search dan filters
- Update results real-time
- Clear filters option

---

### Hari 133: Caching Strategies
* In-memory caching
* Disk caching
* Cache invalidation
* Stale-while-revalidate

**Project:** Cached Data App
- Implement simple cache layer
- Cache API responses
- Cache expiration
- Refresh stale data
- Offline-first approach

---

### Hari 134: SharedPreferences
* SharedPreferences package
* Saving primitive types
* Reading saved data
* Clearing preferences
* Use cases

**Project:** App Settings dengan Persistence
- Save user preferences
- Theme preference
- Language preference
- Remember login state
- Load preferences on startup

---

### Hari 135: Hive Database - Setup
* Hive introduction
* Hive setup
* Type adapters
* Boxes

**Project:** Hive Setup & Basic Operations
- Install dan setup Hive
- Create TypeAdapter untuk model
- Open box
- Basic CRUD operations
- Close box properly

---

### Hari 136: Hive - Advanced Usage
* Lazy boxes
* Encrypted boxes
* Watching boxes
* Complex queries

**Project:** Local Database App dengan Hive
- Store complex objects
- Watch for changes
- Query dengan filters
- Update UI on data changes
- Bulk operations

---

### Hari 137: sqflite Database
* sqflite introduction
* SQL queries dalam Flutter
* Database migrations
* Relationships

**Project:** SQLite Database Implementation
- Create database dan tables
- Insert, query, update, delete
- Joins untuk relationships
- Database versioning
- Migration handling

---

### Hari 138: Offline-First Architecture
* Offline-first concepts
* Sync strategies
* Conflict resolution
* Queue management

**Project:** Offline-First Todo App
- Work offline completely
- Queue operations
- Sync when online
- Handle conflicts
- Sync indicator

---

### Hari 139: Firebase Setup
* Firebase project setup
* FlutterFire installation
* Firebase initialization
* Platform configuration

**Project:** Firebase Integration
- Create Firebase project
- Add Firebase ke Flutter app
- Configure untuk Android/iOS
- Test connection
- Debug setup

---

### Hari 140: Firebase Authentication - Email/Password
* FirebaseAuth
* Sign up dengan email
* Sign in
* Sign out
* Password reset

**Project:** Email Authentication App
- Sign up screen
- Login screen
- Password reset
- Form validation
- Auth state management

---

### Hari 141: Firebase Authentication - Google Sign In
* Google Sign In setup
* OAuth flow
* Token handling
* User info

**Project:** Social Login
- Google Sign In button
- Handle auth flow
- Display user info
- Sign out
- Error handling

---

### Hari 142: Firestore - Basics
* Firestore introduction
* Collections dan documents
* Reading data
* Real-time updates

**Project:** Real-time Chat Messages
- Read messages dari Firestore
- Real-time updates dengan StreamBuilder
- Display messages dalam list
- Scroll to latest
- Message timestamps

---

### Hari 143: Firestore - Writing Data
* Adding documents
* Updating documents
* Deleting documents
* Batch writes

**Project:** Firestore CRUD Operations
- Add new documents
- Update existing documents
- Delete documents
- Batch operations
- Transaction usage

---

### Hari 144: Firestore - Queries
* Where queries
* OrderBy
* Limit
* Compound queries

**Project:** Advanced Queries App
- Filter data dengan multiple conditions
- Sort results
- Pagination dengan Firestore
- Complex queries
- Index requirements

---

### Hari 145: Firebase Storage
* Upload files
* Download URLs
* Delete files
* Storage security rules

**Project:** Image Upload App
- Pick image dari gallery
- Upload ke Firebase Storage
- Get download URL
- Display uploaded images
- Delete images

---

### Hari 146: Cloud Functions Integration (Client-Side)
* Calling Cloud Functions
* Passing parameters
* Handling responses
* Error handling

**Project:** Cloud Functions Client
- Setup callable functions
- Call function dari app
- Pass data ke function
- Handle response
- Loading states

---

### Hari 147: Push Notifications - Setup
* Firebase Cloud Messaging
* Permission handling
* Token management
* Notification handling

**Project:** Push Notifications Implementation
- Request notification permission
- Get FCM token
- Handle foreground notifications
- Handle background notifications
- Custom notification UI

---

### Hari 148: Push Notifications - Advanced
* Topic subscriptions
* Notification actions
* Custom notification sounds
* Notification scheduling (local)

**Project:** Advanced Notifications
- Subscribe to topics
- Handle notification taps
- Navigate based on notification
- Custom notification channels
- Schedule local notifications

---

### Hari 149-150: E-Commerce App - Part 1 (State & Data)
**Project Besar:** E-Commerce App Foundation (2 Hari)

**Hari 149**: Setup & Architecture
- Project structure
- State management setup (pilih: Provider/BLoC)
- API service layer
- Models (Product, User, Cart)
- Repository pattern

**Hari 150**: Core Features Implementation
- Product listing dengan API
- Product detail
- Add to cart functionality
- Cart management
- User authentication
- State management untuk semua features
- Offline caching

**Features**:
- Browse products
- Search products
- Product details
- Add to cart
- Cart management
- User login/logout
- Persistent cart
- Offline support

---

## Ringkasan Part 3 (Hari 101-150)

Dalam 50 hari ketiga, Anda telah mempelajari:
- **State Management**: Provider, BLoC, GetX, Riverpod
- **Networking**: HTTP requests, REST APIs, Dio
- **Data Serialization**: JSON parsing, code generation
- **Local Storage**: SharedPreferences, Hive, SQLite
- **Firebase**: Authentication, Firestore, Storage, Cloud Messaging
- **Offline-First**: Caching, sync strategies
- **Advanced Patterns**: Repository pattern, CRUD operations
- **Real-world Integration**: API integration, push notifications

Anda sekarang memiliki kemampuan untuk build apps dengan complex state dan data management. Part 4 akan fokus pada advanced UI dan animations!
