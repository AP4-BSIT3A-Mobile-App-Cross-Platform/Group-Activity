import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

import '../models/people.dart';

class ElonmuskView extends StatefulWidget {
  final int index;

  const ElonmuskView({super.key, required this.index});

  @override
  State<ElonmuskView> createState() => _ElonmuskViewState();
}

class _ElonmuskViewState extends State<ElonmuskView> {
  final TCardController _controller = TCardController();
  final people = PeopleModel.sampleData();
  final imgNetwork =
      'https://www.rollingstone.com/wp-content/uploads/2023/04/elon-musk-RS-1800.jpg?w=1581&h=1054&crop=1';

  late ConfettiController _confettiController;

  bool showRefreshButton = false; //

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void onSwipe(int index, SwipDirection direction) async {
    if (direction == SwipDirection.Right) {
      showMatchModal();
    } else if (direction == SwipDirection.Left) {
      if (index == people.names.length - 1) {
        setState(() {
          showRefreshButton = true;  // <-- Show the refresh button when all cards gone
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text("No more cards! Press refresh."),
        ));
      }
    }
  }

  void resetCards() {
    setState(() {
      showRefreshButton = false;
    });
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${people.names[widget.index]} Profile',
          style: const TextStyle(fontFamily: 'Popartpixel'),
        ),
        actions: [
          if (showRefreshButton)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: resetCards,
            )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://www.investors.com/wp-content/uploads/2025/01/Stock-ElonMuskCompanies-01-IBD.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.3)),
          Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.01,
                numberOfParticles: 100,
                gravity: 0.3,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.yellow,
                  Colors.green,
                  Colors.purple,
                ],
              )),
          Center(
            child: TCard(
              controller: _controller,
              size: const Size(350, 550),
              cards: [
                _buildProfileCard(),
              ],
              onForward: (index, direction) {
                onSwipe(index + 1, direction.direction);
              },
            ),
          ),
        ],
      ),
    );
  }

  void showMatchModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        ConfettiController modalConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));
        modalConfettiController.play();

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "🎉 It's a Match! 🎉",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imgNetwork,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'You and Elon Musk liked each other! 🚀',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        modalConfettiController.dispose();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              ConfettiWidget(
                confettiController: modalConfettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.02,
                numberOfParticles: 50,
                gravity: 0.3,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.yellow,
                  Colors.green,
                  Colors.purple,
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imgNetwork,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${people.names[widget.index]}, ${people.ages[widget.index]}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Popartpixel'),
          ),
          const SizedBox(height: 4),
          const Text(
            'CEO of Tesla & SpaceX',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.black),
              SizedBox(width: 4),
              Text('Austin, Texas',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600))
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'I build rockets, cars, and memes. Looking for someone to colonize Mars with 🚀',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
