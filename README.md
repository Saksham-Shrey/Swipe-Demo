# Swipe-Demo

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0-blue.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)


## Description

Swipe-Demo is an iOS application designed to showcase the implementation of a product listing screen, a search screen, and an add product screen. It's built using modern iOS development techniques and offers a seamless user experience.

## Features

- Product Listing Screen:
  - Displays a list of products fetched from a provided API endpoint.
  - Allows users to search, scroll, and navigate to the Add Product screen.
  - Utilizes image loading from URLs with a default image fallback.
  - Provides a visual loading indicator for better user experience.

- Add Product Screen:
  - Allows users to add new products to the database.
  - Supports selection of product type from a list of options.
  - Validates input fields such as product name, price, and tax rate.
  - Submits data using the POST method to the provided API endpoint.
 
- Search Screen:
  - Enables users to search for specific products based on their name.
  - Provides a clear and intuitive user interface for an efficient search experience.

## Working Demo

https://github.com/Saksham-Shrey/Swipe-Demo/assets/110986726/400dbfa4-f15d-440f-9be1-5d009511ecba

## Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/Swipe-Demo.git
```
2. Navigate to the project directory:
  ```bash
cd Swipe-Demo
```
3. Install dependencies using CocoaPods:
  ```bash
pod install
```
4. Open the Xcode workspace:
  ```bash
open Swipe-Demo.xcworkspace
```
5. Build and run the project in Xcode.

## Dependencies

Alamofire: Used for networking tasks such as fetching data from APIs.

## Usage
Launch the app on your iOS device or simulator.
Explore the product listing screen to view available products.
Use the search functionality to find specific products.
Navigate to the Add Product screen to add new products.
Fill in the required details and submit to add a new product.

## Credits
Alamofire: Alamofire is an HTTP networking library written in Swift.
