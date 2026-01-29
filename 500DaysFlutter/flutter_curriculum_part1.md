# Kurikulum Flutter 500 Hari - Part 1 (Hari 1-50)
## Fase Fondasi: Dasar Programming & Dart

### Hari 1: Pengenalan Programming & Setup Environment
* Konsep dasar programming (algoritma, logika)
* Instalasi Dart SDK dan IDE (VS Code/Android Studio)
* Menulis program "Hello World" pertama
* Memahami struktur program Dart

**Project:** Hello Dart
- Buat program sederhana yang menampilkan biodata diri (nama, umur, hobi)
- Gunakan print() untuk output
- Eksplorasi string interpolation untuk menggabungkan teks

---

### Hari 2: Variabel dan Tipe Data
* Deklarasi variabel (var, final, const)
* Tipe data primitif (int, double, String, bool)
* Type inference dan explicit typing
* Konversi antar tipe data

**Project:** Kalkulator Sederhana
- Buat program kalkulator untuk operasi dasar (+, -, *, /)
- Input dua angka dan pilihan operasi
- Tampilkan hasil perhitungan dengan format yang rapi

---

### Hari 3: Operator dan Ekspresi
* Operator aritmatika (+, -, *, /, %, ~/)
* Operator perbandingan (==, !=, >, <, >=, <=)
* Operator logika (&&, ||, !)
* Operator assignment dan increment/decrement

**Project:** Pengecekan Bilangan
- Program untuk mengecek apakah bilangan genap/ganjil
- Cek apakah bilangan positif/negatif
- Cek apakah bilangan prima sederhana
- Implementasi berbagai operator logika

---

### Hari 4: Control Flow - Conditional Statements
* If, else if, else
* Nested if statements
* Ternary operator (? :)
* Switch case statements

**Project:** Sistem Grading Nilai
- Input nilai ujian (0-100)
- Tentukan grade (A, B, C, D, E) berdasarkan range nilai
- Tampilkan predikat (Sangat Baik, Baik, Cukup, Kurang)
- Tambahkan validasi input

---

### Hari 5: Control Flow - Loops (Part 1)
* For loop dan variasinya
* While loop
* Do-while loop
* Break dan continue statements

**Project:** Pattern Printer
- Buat berbagai pola bintang (segitiga, pyramid, diamond)
- Gunakan nested loops
- Tambahkan input untuk ukuran pola
- Implementasi pola angka dan huruf

---

### Hari 6: Control Flow - Loops (Part 2)
* For-in loop untuk collections
* forEach method
* Loop optimization
* Infinite loops dan cara menghindarinya

**Project:** Tabel Perkalian Interaktif
- Generate tabel perkalian 1-10
- Format output dalam bentuk tabel yang rapi
- Tambahkan fitur custom range (misal: tabel 5-15)
- Hitung total semua hasil perkalian

---

### Hari 7: Functions - Basics
* Deklarasi dan pemanggilan function
* Parameter dan arguments
* Return values
* Void functions

**Project:** Math Utility Library
- Buat collection functions matematika (luas, volume, dll)
- Function untuk konversi suhu (Celsius, Fahrenheit, Kelvin)
- Function untuk menghitung rata-rata, median
- Implementasi validasi input dalam function

---

### Hari 8: Functions - Advanced
* Optional parameters (positional & named)
* Default parameter values
* Arrow functions (=>)
* Anonymous functions

**Project:** String Manipulator
- Function untuk reverse string
- Function untuk cek palindrome
- Function untuk count vowels/consonants
- Function untuk capitalize, uppercase, lowercase dengan options

---

### Hari 9: Collections - Lists
* List creation dan initialization
* List methods (add, remove, insert, clear)
* List properties (length, isEmpty, isNotEmpty)
* Accessing dan modifying list elements

**Project:** Todo List Console
- Buat aplikasi todo list sederhana di console
- Fitur: tambah task, hapus task, lihat semua task
- Tampilkan task dengan numbering
- Validasi input dan error handling

---

### Hari 10: Collections - List Operations
* List iteration techniques
* List sorting dan searching
* List filtering dan mapping
* Spread operator (...)

**Project:** Number Analyzer
- Input list angka dari user
- Hitung statistik: min, max, sum, average
- Filter angka genap/ganjil
- Sort ascending/descending
- Tampilkan hasil dalam format yang informatif

---

### Hari 11: Collections - Sets
* Set creation dan properties
* Set operations (union, intersection, difference)
* Perbedaan Set dan List
* Converting antara Set dan List

**Project:** Unique Word Counter
- Input beberapa kalimat
- Extract semua kata unik
- Hitung frekuensi kemunculan setiap kata
- Tampilkan kata-kata yang muncul lebih dari sekali
- Case-insensitive comparison

---

### Hari 12: Collections - Maps
* Map creation dan initialization
* Accessing dan modifying map values
* Map methods (keys, values, entries)
* Iterating maps

**Project:** Contact Book
- Buat aplikasi buku kontak sederhana
- Simpan nama dan nomor telepon dalam Map
- Fitur: tambah, cari, update, hapus kontak
- Tampilkan semua kontak terurut berdasarkan nama

---

### Hari 13: Null Safety Basics
* Nullable vs non-nullable types
* Null safety operators (?, ??, !)
* Late variables
* Null-aware operators

**Project:** Safe Data Processor
- Buat program yang handle null values dengan aman
- Implementasi default values untuk null
- User input validation dengan null safety
- Praktik best practices null safety

---

### Hari 14: String Manipulation Advanced
* String methods (substring, split, trim, etc.)
* Regular expressions basics
* String formatting
* Multi-line strings

**Project:** Text Formatter
- Program untuk format dan clean text
- Remove extra spaces
- Capitalize sentences properly
- Count words, characters, sentences
- Basic text statistics

---

### Hari 15: Exception Handling
* Try-catch blocks
* Multiple catch blocks
* Finally clause
* Throwing exceptions

**Project:** Calculator dengan Error Handling
- Kalkulator dengan comprehensive error handling
- Handle division by zero
- Handle invalid input
- Custom error messages
- Graceful program continuation setelah error

---

### Hari 16: Object-Oriented Programming - Classes Basics
* Class definition dan instantiation
* Constructors
* Instance variables dan methods
* The 'this' keyword

**Project:** Student Management System (Basic)
- Buat class Student dengan properties (name, id, grades)
- Methods untuk add grade, calculate average
- Create multiple student objects
- Display student information

---

### Hari 17: OOP - Constructors Advanced
* Default constructors
* Named constructors
* Factory constructors
* Constructor initialization lists

**Project:** Shape Calculator
- Buat class hierarchy untuk shapes (Circle, Rectangle, Triangle)
- Multiple constructors untuk berbagai cara input
- Calculate area dan perimeter
- Factory constructor untuk create shape dari type string

---

### Hari 18: OOP - Encapsulation
* Private members (_variableName)
* Getters dan Setters
* Data hiding principles
* Access control

**Project:** Bank Account System
- Class BankAccount dengan encapsulated balance
- Methods: deposit, withdraw, getBalance
- Validasi transaksi (tidak bisa withdraw lebih dari balance)
- Transaction history menggunakan private list

---

### Hari 19: OOP - Inheritance
* Extends keyword
* Super keyword
* Method overriding
* Constructor inheritance

**Project:** Employee Hierarchy
- Base class: Employee (name, id, salary)
- Derived classes: Manager, Developer, Designer
- Override method calculateBonus() untuk setiap type
- Demonstrate inheritance dengan multiple objects

---

### Hari 20: OOP - Polymorphism
* Method overriding vs overloading
* Runtime polymorphism
* Type checking (is, as)
* Dynamic dispatch

**Project:** Animal Kingdom Simulator
- Base class Animal dengan method makeSound()
- Subclasses: Dog, Cat, Bird dengan sound implementation masing-masing
- List of Animals dengan berbagai types
- Loop dan panggil makeSound() untuk demonstrate polymorphism

---

### Hari 21: OOP - Abstract Classes
* Abstract class definition
* Abstract methods
* Implementing abstract classes
* When to use abstract classes

**Project:** Payment System
- Abstract class Payment dengan abstract method processPayment()
- Concrete classes: CreditCard, DebitCard, EWallet
- Setiap class implement processPayment() dengan cara berbeda
- Payment processor yang handle berbagai payment types

---

### Hari 22: OOP - Interfaces (Implicit)
* Dart's interface mechanism
* Implementing multiple interfaces
* Interface vs abstract class
* Duck typing in Dart

**Project:** Multi-Interface Implementation
- Interface Printable dengan method print()
- Interface Saveable dengan method save()
- Class Document yang implements keduanya
- Class Report yang implements keduanya dengan implementation berbeda

---

### Hari 23: OOP - Mixins
* Mixin definition dengan 'mixin' keyword
* Using mixins dengan 'with' keyword
* Mixin constraints
* Multiple mixins

**Project:** Character Builder (Game)
- Mixins: Flyable, Swimmable, Fightable
- Base class Character
- Various character types dengan kombinasi mixins berbeda
- Demonstrate reusable behaviors

---

### Hari 24: Enumerations (Enums)
* Enum definition
* Enum values dan properties
* Enhanced enums (Dart 2.17+)
* Switch dengan enums

**Project:** Task Management dengan Priority
- Enum TaskPriority (Low, Medium, High, Critical)
- Enum TaskStatus (Todo, InProgress, Done)
- Class Task yang menggunakan enums
- Filter dan sort tasks berdasarkan enum values

---

### Hari 25: Collections Advanced - Iterable
* Iterable interface
* Lazy evaluation
* Custom iterables
* Iterable methods (where, map, reduce, etc.)

**Project:** Data Filter & Transform Pipeline
- Input list of numbers
- Chain multiple operations: filter, map, reduce
- Demonstrate lazy evaluation benefits
- Compare performance dengan eager evaluation

---

### Hari 26: Higher-Order Functions
* Functions sebagai first-class objects
* Passing functions sebagai parameters
* Returning functions
* Closures

**Project:** Custom Sort & Filter System
- Buat generic sorting function yang accept custom comparator
- Filter function yang accept predicate function
- Combine multiple filters
- Reusable transformation functions

---

### Hari 27: Lambda & Anonymous Functions
* Lambda syntax
* Anonymous functions in collections
* Capturing variables
* When to use lambdas

**Project:** Event Handler System
- System untuk register dan trigger events
- Use anonymous functions sebagai event handlers
- Multiple handlers per event
- Pass data ke event handlers

---

### Hari 28: Generics - Basics
* Generic classes
* Generic methods
* Type parameters
* Bounded generics

**Project:** Generic Data Structure - Stack
- Implement Stack<T> yang bisa hold any type
- Methods: push, pop, peek, isEmpty
- Type-safe operations
- Test dengan berbagai types (int, String, custom objects)

---

### Hari 29: Generics - Advanced
* Multiple type parameters
* Generic constraints
* Generic type aliases
* Covariance dan contravariance

**Project:** Generic Pair & Triple Classes
- Class Pair<F, S> untuk hold two values
- Class Triple<F, S, T> untuk three values
- Generic methods untuk swap, compare
- Use cases dengan different type combinations

---

### Hari 30: Asynchronous Programming - Futures
* Future basics
* then() dan catchError()
* async dan await keywords
* Error handling dalam async code

**Project:** Fake API Data Fetcher
- Simulate API calls dengan Future.delayed()
- Fetch user data asynchronously
- Handle loading, success, error states
- Multiple sequential API calls

---

### Hari 31: Asynchronous Programming - Streams
* Stream basics
* StreamController
* Listen to streams
* Stream transformations

**Project:** Real-time Counter Stream
- Create stream yang emit angka setiap detik
- Listen dan display values
- Transform stream data (multiply, filter)
- Multiple listeners pada same stream

---

### Hari 32: File I/O - Reading Files
* File class
* Reading file content (readAsString, readAsLines)
* Synchronous vs asynchronous reading
* Error handling untuk file operations

**Project:** Text File Reader & Analyzer
- Read text file
- Count lines, words, characters
- Find longest word
- Display file statistics
- Handle file not found errors

---

### Hari 33: File I/O - Writing Files
* Writing to files (writeAsString, writeAsBytes)
* Appending to files
* File modes
* Creating directories

**Project:** Simple Note Taking App
- Create, read, update, delete notes
- Save notes ke separate files
- List all saved notes
- Read dan display note content

---

### Hari 34: JSON Serialization
* JSON encoding dan decoding
* jsonEncode() dan jsonDecode()
* Converting objects to/from JSON
* Nested JSON handling

**Project:** User Profile Manager
- Class User dengan properties
- toJson() method untuk serialization
- fromJson() factory constructor
- Save dan load user profiles dari JSON file

---

### Hari 35: Working with APIs Basics
* HTTP package introduction
* GET requests
* Parsing JSON responses
* Error handling untuk network calls

**Project:** Weather Info Fetcher (Mock)
- Simulate weather API dengan local JSON
- Fetch weather data asynchronously
- Parse dan display relevant information
- Handle network errors gracefully

---

### Hari 36: DateTime Operations
* DateTime class
* Creating dan parsing dates
* Date arithmetic
* Formatting dates

**Project:** Age Calculator & Date Utilities
- Calculate age dari birth date
- Calculate days until next birthday
- Add/subtract days, months, years
- Compare dates
- Display dates dalam berbagai formats

---

### Hari 37: Regular Expressions Advanced
* Regex patterns
* Matching dan searching
* Replacing dengan regex
* Common regex use cases

**Project:** Input Validator
- Validate email addresses
- Validate phone numbers
- Validate passwords (complexity requirements)
- Extract data dari formatted strings
- Clean dan normalize user input

---

### Hari 38: Testing - Unit Tests Basics
* Test package introduction
* Writing test cases
* Assertions (expect)
* Running tests

**Project:** Math Library dengan Tests
- Buat utility functions untuk math operations
- Write unit tests untuk setiap function
- Test edge cases
- Test error conditions
- Achieve high test coverage

---

### Hari 39: Testing - Advanced Testing
* Group tests
* setUp dan tearDown
* Testing async code
* Matchers

**Project:** Complete Testing Suite
- Test collection operations
- Test async functions
- Test exception throwing
- Organize tests dengan groups
- Generate test coverage report

---

### Hari 40: Debugging Techniques
* Using debugger
* Print debugging
* Assert statements
* Debugging tools

**Project:** Bug Hunting Challenge
- Diberikan buggy code
- Use debugging techniques untuk find bugs
- Fix bugs systematically
- Document findings
- Write tests untuk prevent regression

---

### Hari 41: Code Organization - Libraries
* Creating libraries
* Exporting dan importing
* Part files
* Library visibility

**Project:** Utility Library Package
- Organize code ke dalam library
- String utilities library
- Math utilities library
- Date utilities library
- Proper exports dan documentation

---

### Hari 42: Code Organization - Packages
* Pubspec.yaml
* Dependencies
* Creating reusable packages
* Package structure

**Project:** Custom Dart Package
- Create simple reusable package
- Add dependencies
- Write proper documentation
- Include examples
- Version management

---

### Hari 43: Design Patterns - Singleton
* Singleton pattern implementation
* Use cases
* Thread safety considerations
* Lazy initialization

**Project:** Configuration Manager
- Singleton class untuk app configuration
- Load configuration dari file
- Access config dari anywhere
- Update configuration values
- Save changes

---

### Hari 44: Design Patterns - Factory
* Factory pattern
* Abstract factory
* When to use factories
* Benefits

**Project:** Shape Factory System
- Factory untuk create different shapes
- Abstract factory untuk shape families
- Parameters-based shape creation
- Type-safe object creation

---

### Hari 45: Design Patterns - Observer
* Observer pattern
* Subject dan observers
* Notification mechanism
* Use cases

**Project:** Event System dengan Observers
- Subject class yang notify observers
- Multiple observer implementations
- Subscribe/unsubscribe mechanism
- Event data passing
- Practical use case (stock price updates)

---

### Hari 46: SOLID Principles - SRP & OCP
* Single Responsibility Principle
* Open-Closed Principle
* Practical examples
* Refactoring to follow principles

**Project:** Refactoring Exercise
- Diberikan code yang violate SRP dan OCP
- Identify violations
- Refactor untuk follow principles
- Write tests untuk verify behavior preserved

---

### Hari 47: SOLID Principles - LSP, ISP, DIP
* Liskov Substitution Principle
* Interface Segregation Principle
* Dependency Inversion Principle
* Complete SOLID review

**Project:** Clean Architecture Example
- Implement small system following all SOLID principles
- Demonstrate each principle dengan concrete examples
- Benefits of following SOLID
- Compare dengan non-SOLID code

---

### Hari 48: Clean Code Practices
* Naming conventions
* Code formatting
* Comments dan documentation
* Code smells

**Project:** Code Review & Cleanup
- Review existing code
- Identify code smells
- Refactor untuk clean code
- Add proper documentation
- Apply Dart style guide

---

### Hari 49: Performance Optimization
* Performance profiling
* Memory management
* Optimizing loops dan algorithms
* Best practices

**Project:** Performance Comparison
- Implement same functionality dengan different approaches
- Measure performance
- Identify bottlenecks
- Optimize critical paths
- Document findings

---

### Hari 50: Mini Project - CLI Todo Application
* Combine semua concepts dari 49 hari pertama
* Full-featured command-line todo application
* File persistence
* Proper error handling
* Clean code dan testing

**Project:** CLI Todo App - Complete
- CRUD operations untuk tasks
- Priority levels dan due dates
- Filter dan search functionality
- Data persistence dengan JSON
- Full test coverage
- Clean architecture
- Comprehensive documentation
- Error handling yang robust

---

## Ringkasan Part 1 (Hari 1-50)

Dalam 50 hari pertama, Anda telah mempelajari:
- **Dasar Programming**: Variables, operators, control flow
- **Functions**: Basic hingga higher-order functions
- **Collections**: Lists, Sets, Maps, dan operasinya
- **OOP**: Classes, inheritance, polymorphism, abstract classes, mixins
- **Advanced Concepts**: Generics, async programming, file I/O
- **Best Practices**: Testing, debugging, clean code, SOLID principles
- **Design Patterns**: Singleton, Factory, Observer

Anda sekarang memiliki fondasi yang solid dalam Dart programming dan siap untuk melangkah ke Flutter development di Part 2!
