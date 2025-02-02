# mcqtest
## APP LINK:
 the APK file [here](https://github.com/Mr-CodeBin/questionAppTask/blob/main/lib/APK/app-release.apk).


# Description:
- **MVVM Architecture**:
     Ensures a clear and organized structure by separating code into models, views, and viewmodels.
- **Provider for State Management**:
     Uses the provider package to manage the state of the application.
- **Firebase Integration**:
     Utilizes Firebase Authentication for user login/signup and Firebase Firestore for data storage.
- **Daily MCQs**:
     Allows users to answer daily multiple-choice questions.
- **Streak Tracking**:
     Tracks and displays the user's streak based on consecutive days of practice.


## Project Setup:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/Mr-CodeBin/questionAppTask.git
   cd <project folder name>
   code .

2. **Setup Firebase:**
   - Go to Your Firebase Console
   - Create new project
   - Add an Android app to your Firebase project.
   - Follow the instructions to download the google-services.json (for Android) and place them in the appropriate directories.

3. ## Environment Variables

To run this project, you will need to add the following environment variables to your `.env` file :
first, make new .env file in your Project root Dir. then add these data from firebase_options.dart.

```plaintext
FIREBASE_API_KEY= 'YOUR_API_KEY'
FIREBASE_APP_ID= 'YOUR_APP_ID'
FIREBASE_MESSAGING_SENDER_ID= 'YOUR_SENDER_ID'
FIREBASE_PROJECT_ID= 'YOUR_PROJECT_ID'
FIREBASE_STORAGE_BUCKET= 'YOUR_STORAGE_BUCKET'

## Screens

1. **Authentication Screen**:
        - Users can sign up or log in using Firebase Authentication.
2. **Daily MCQ Screen**:
        - Displays daily multiple-choice questions for users to answer.
3. **Streak Screen**:
        - Shows the user's streak based on consecutive days of practice.

## Dependencies
      - flutter
      - provider
      - firebase_core
      - firebase_auth
      - cloud_firestore
      - 

## Usage
1. Authentication Screen
      - Users can sign up or log in using their email and password.
2. Daily MCQ Screen
      - Displays a list of daily multiple-choice questions.
      - Users can select an answer for each question.
3. Streak Screen
      - Displays the user's streak based on consecutive days of answering questions.
