# Motorcycle App

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
- [Setup](#setup)
- [Usage](#usage)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This is a Motorcycle App developed in Swift and SwiftUI, designed to provide motorcycle enthusiasts with a seamless experience. Whether you're looking for motorcycle information, browsing a catalog, or managing your orders, this app has you covered.

## Features

1. **Registration**
   - As a user, you can register for an account.

2. **Login**
   - As a user, you can log in to your account.

3. **Logout**
   - As a user, you can log out of your account.

4. **Edit Profile**
   - As a user, you can edit your profile, including your profile picture.

5. **Motorcycle Catalogue**
   - As a user, you can browse a catalog of motorcycles with thumbnails.

6. **Motorcycle Details**
   - As a user, you can view detailed information about a motorcycle.

7. **Motorcycle Gallery**
   - As a user, you can view a gallery of motorcycle images.

8. **Order Motorcycle**
   - As a user, you can order a motorcycle product. (Notifications supported)

9. **My Orders**
   - As a user, you can view your order history.

10. **Cancel Orders**
    - As a user, you can cancel your orders. (Notifications supported)

11. **Dashboard Order Summary**
    - As a user, you can view a summary of your orders with charts.

## Architecture

The app follows the Clean Architecture pattern and utilizes the Resolver framework for dependency injection. It makes use of the following technologies:
- Alamofire for network requests.
- Firebase Storage for image storage.
- Firebase Firestore for database operations.
- Firebase Auth for user authentication.
- Onesignal and custom backend for notifications.

## Setup

Follow these steps to set up the project locally:

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Xcode installed on your macOS system.
- Cocoapods installed (for dependency management) or Swift Package Manager if you prefer.

### Clone the Repository

1. Open Terminal.

2. Change the current working directory to the location where you want the project folder to be created:

   ```shell
   cd /path/to/your/desired/location/
   
3. Clone the repository using the following command:

   ```shell
   git clone https://github.com/Azzamubaidillah/motorcycleApp.git

### Install Dependencies

  Navigate to the project folder and run pod install

### Configure Firebase

1. Create a Firebase project at https://console.firebase.google.com/.

2. In your Firebase project, set up Firebase Authentication, Firebase Firestore, and Firebase Storage. Note down the configuration details.

3. In Xcode, open the project workspace (.xcworkspace file).

4. Navigate to the AppDelegate.swift file and replace the Firebase configuration with your own:

### Backend Configuration

1. Configure your backend services, including Oneplus and your custom backend, to support notifications. Refer to their documentation for setup instructions.

### Build and Run

1. Open the Xcode workspace (.xcworkspace) by double-clicking it.

2. Select your target (e.g., the app name).

3. Choose a simulator or a physical device, and click the "Run" button (play icon) in Xcode to build and run the app.

4. You can now use the Motorcycle App locally for development and testing.

## Usage

## Usage

Here's how to use the Motorcycle App effectively:

### Registration and Login

1. **Registration**
   - Open the app and tap on the "Register" button.
   - Fill in the required registration information, such as your email and password.
   - Tap the "Register" button to create your account.

2. **Login**
   - After registration or if you already have an account, tap on the "Login" button.
   - Enter your registered email and password.
   - Tap the "Login" button to access your account.

### Profile Management

3. **Edit Profile**
   - Once logged in, navigate to the "Profile" section.
   - Here, you can edit your profile details, including your profile picture.

### Motorcycle Catalog

4. **Motorcycle Catalog**
   - In the app's main menu, select "Catalog."
   - Browse through the catalog to find motorcycles you're interested in. Thumbnails provide a quick preview.

5. **Motorcycle Details**
   - To learn more about a specific motorcycle, tap on its entry in the catalog.
   - You'll see detailed information about the motorcycle, including specifications and features.

6. **Motorcycle Gallery**
   - Inside the motorcycle details screen, you can access a gallery of images related to that motorcycle.

### Ordering

7. **Ordering a Motorcycle**
   - If you decide to purchase a motorcycle, find the "Order" button within the motorcycle details.
   - Follow the prompts to place an order.
   - You may receive a notification confirming your order if enabled.

8. **My Orders**
   - To view your order history, navigate to the "My Orders" section in the app.
   - You'll see a list of your previous orders and their statuses.

9. **Canceling Orders**
   - If you need to cancel an order, go to the "My Orders" section.
   - Find the order you wish to cancel and select it.
   - Look for the "Cancel" option and follow the steps.
   - You may receive a notification confirming the cancellation if enabled.

### Dashboard

10. **Dashboard Order Summary**
    - In the app's main menu, choose "Dashboard."
    - Here, you can see a summary of your orders, possibly represented using charts.

Feel free to explore and interact with the Motorcycle App to make the most out of its features. If you encounter any issues or have questions, don't hesitate to contact our support team.

Enjoy your experience with our Motorcycle App!

## Screenshots

<img src="https://github.com/Azzamubaidillah/MotorcycleApp/assets/66078837/f111419a-2939-4871-83fa-61d28abf2e45" width="50%">

<img src="https://github.com/Azzamubaidillah/MotorcycleApp/assets/66078837/beee4e48-4f05-47bc-9c13-5c1b1695c7e0" width="50%">

<img src="https://github.com/Azzamubaidillah/MotorcycleApp/assets/66078837/25cff47c-1184-41e1-a974-3c24be8dc20e" width="50%">

<img src="https://github.com/Azzamubaidillah/MotorcycleApp/assets/66078837/9427efa0-7c4a-4667-91df-6b4a101e8d57" width="50%">

<img src="https://github.com/Azzamubaidillah/MotorcycleApp/assets/66078837/e1049caf-8cdb-48a1-b096-682a33ff14e1" width="50%">

## License

MIT License
