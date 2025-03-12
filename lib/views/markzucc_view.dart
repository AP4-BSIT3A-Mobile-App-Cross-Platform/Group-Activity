import 'package:flutter/material.dart';
import 'package:group_activity/models/people.dart';

import '../widgets/modal.dart';

class MarkzuccView extends StatefulWidget {
  final int index;

  const MarkzuccView({super.key, required this.index});

  @override
  State<MarkzuccView> createState() => _MarkzuccViewState();
}

class _MarkzuccViewState extends State<MarkzuccView> {
  final people = PeopleModel.sampleData();
  final List<String> imageNetwork = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdhbXhg6EE65TqR5ZSCWtA39gH6zAljb4vCg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa38vyZh50JKq4LM-CVZtlOuFy2mW05re9Cg&s',
    'https://i.insider.com/5b02f5ba1ae6621b008b48a6?width=700'
  ];
  late ScrollController _carouselController;

  int currentImgNetworkIndex = 0;

  @override
  void initState() {
    super.initState();

    _carouselController = ScrollController();
    _carouselController.addListener(_updateCurrentIndex);
  }

  void _updateCurrentIndex() {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentIndex = (_carouselController.offset / screenWidth).round();

    if (currentImgNetworkIndex != currentIndex) {
      setState(() {
        currentImgNetworkIndex = currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${people.names[widget.index]} Profile',
          style:
              const TextStyle(color: Colors.white, fontFamily: 'DelightPurple'),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // This changes the back arrow to white
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar:
          true, // Let the background image extend behind the app bar
      body: Stack(
        children: [
          // Background Image - Always first image for background
          Positioned.fill(
            child: Image.network(
              'https://www.washingtonpost.com/wp-apps/imrs.php?src=https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/V7INO3BYEQI6ZFTCHGOPU5PP5Y.jpg&w=1800&h=1800', // You can change to another image if needed
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay to improve contrast
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Main Content (Profile and images)
          Column(
            children: [
              const SizedBox(
                  height: kToolbarHeight +
                      16), // To account for transparent app bar

              // Image Carousel
              Expanded(
                flex: 3,
                child: ListView.builder(
                  controller: _carouselController,
                  scrollDirection:
                      Axis.horizontal, // Important: Horizontal scroll
                  itemCount: imageNetwork.length,
                  itemBuilder: (context, imgIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          imageNetwork[imgIndex],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context)
                              .size
                              .width, // Full screen width per item
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Slider Bar (Image Indicator)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imageNetwork.length, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        decoration: BoxDecoration(
                          color: currentImgNetworkIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Profile Info
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        people.names[widget.index],
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'DelightPurple'),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Age: ${people.ages[widget.index]}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => showModal(
                            context,
                            'Metaverse Mastermind',
                            'Creator of Facebook, shaping how the world connects online. Passionate about technology, AI, and building the future of the internet.'),
                        child: const Text(
                          'View Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Like / Dislike Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: 'dislike',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    content: Text(
                                        'You disliked ${people.names[widget.index]}👎')),
                              );
                              Navigator.pop(context);
                            },
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.close),
                          ),
                          FloatingActionButton(
                            heroTag: 'like',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    content: Text(
                                        'You liked ${people.names[widget.index]}!💚')),
                              );
                              Navigator.pop(context);
                            },
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.favorite),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
