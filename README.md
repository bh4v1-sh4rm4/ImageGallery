# ImageGallery

ImageGallery is an iOS application that uses the Unsplash API to fetch and display images in a gallery format. The app follows the MVVM (Model-View-ViewModel) architecture and includes features like image search, swipe down to refresh, and dynamic layout for various screen sizes. 

## Features
- **Unsplash API Integration**: Fetch images and display them in a gallery view.
- **Search Functionality**: Search for images by keyword using a search bar.
- **Image Caching**: Utilizes `SDWebImage` to cache images for improved performance.
- **Swipe Down to Refresh**: Reload the image gallery with new data on swipe-down gesture.
- **Error Handling**: API and validation errors are handled gracefully using `UIAlertController`.
- **Responsive UI**: Adapts dynamically to all screen sizes, ensuring a consistent user experience across devices.
- **MVVM Architecture**: Implements the MVVM design pattern for better code separation and testability.

## Screenshots
<h3> Home </h3>
<p align="center">
<img src= "https://github.com/user-attachments/assets/b10747b8-fc16-4bb1-9704-b035d47c5d9c" width="200" height="400" align="center"/>
   &nbsp;&nbsp;&nbsp;&nbsp;
   &nbsp;&nbsp;&nbsp;&nbsp;
   <img src= "https://github.com/user-attachments/assets/87c2dc38-304f-48f9-b71c-4cd66b24fa04" width="200" height="400" align="center"/>
</p>

<h3> Searching </h3>
<p align="center">
<img src= "https://github.com/user-attachments/assets/b8d496b5-05a5-442b-8082-c285a4bf7ada" width="200" height="400" align="center"/>
   &nbsp;&nbsp;&nbsp;&nbsp;
   &nbsp;&nbsp;&nbsp;&nbsp;
   <img src= "https://github.com/user-attachments/assets/53f31772-aec4-4d23-86a2-31675f6b6d19" width="200" height="400" align="center"/>
</p>

<h3> Loading Indicator </h3>
<p align="center">
<img src= "https://github.com/user-attachments/assets/142659c1-0f72-4913-beb1-af47b1e94c7d" width="200" height="400" align="center"/>
</p>

<h3> Network Error Handeling </h3>
<p align="center">
<img src= "https://github.com/user-attachments/assets/c4e5b1f8-d0e1-47fd-9168-7abd705cf34e" width="200" height="400" align="center"/>
</p>

## Requirements
- iOS 13.0+
- Xcode 12+
- Swift 5.0+
- [Unsplash API](https://unsplash.com/developers) key

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ImageGallery.git
   cd ImageGallery
   ```
2. Install dependencies using CocoaPods:
   ```bash
   pod install
   ```
3. Open the .xcworkspace file in Xcode:
   ```bash
   open ImageGallery.xcworkspace
   ```
4. Add your Unsplash API key in the project.
5. Build and run the project on your simulator or device.

## Usage

1. Search for Images: Use the search bar at the top of the screen to search for images related to a specific keyword.
   
2. Swipe to Refresh: Pull down on the gallery screen to refresh the images.
   
3. Image Caching: Images are cached using SDWebImage for faster loading and offline viewing.

## Libraries Used

**Image Caching**: Utilizes [`SDWebImage`](https://github.com/SDWebImage/SDWebImage) to cache images for improved performance.

URLSession for API requests.

DispatchQueue for handling asynchronous tasks.

## Future Enhancements

Infinite scrolling to load more images as the user scrolls.

Detailed image view with sharing functionality.

Unit tests for ViewModel and API handling.
