import 'package:flutter/material.dart';
import 'package:timer_tasks/MODELS/firebase.dart'; // Adjust the import path as needed

class AsyncImageView extends StatefulWidget {
  const AsyncImageView({
    super.key,
    this.imagePath = "Images/cocoimage.png",
    this.width = 100, // Default width
    this.height = 100, // Default height
    this.radius = 0, // Default radius for container
  });

  final String imagePath;
  final double width;
  final double height;
  final double radius;

  @override
  _AsyncImageViewState createState() => _AsyncImageViewState();
}

class _AsyncImageViewState extends State<AsyncImageView> {
  String imageUrl = ""; // State variable to hold the fetched URL

  @override
  void initState() {
    super.initState();
    fetchImageUrl(); // Call async function in initState
  }

  Future<void> fetchImageUrl() async {
    try {
      final url = await storage_DownloadMedia(widget.imagePath);
      print(url);
      if (mounted) {
        // Check if the widget is still mounted before updating state
        setState(() {
          imageUrl = url ??
              ""; // Update state with fetched URL, or empty string if null
        });
      }
    } catch (error) {
      print("Error fetching image URL: $error");
      // Handle error gracefully, e.g., show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[300], // Placeholder color while loading
        ),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover, // Adjust the fit based on your requirement
              )
            : const Center(
                child:
                    CircularProgressIndicator()), // Show loading indicator while fetching data
      ),
    );
  }
}
