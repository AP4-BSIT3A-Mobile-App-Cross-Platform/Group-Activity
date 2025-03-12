import 'package:flutter/material.dart';
import '../models/people.dart';
import '../views/elonmusk_view.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late PeopleModel people;
  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    refresh(); // Load initial data
  }

  Future<void> refresh() async {
    setState(() {
      isLoading = true; // Start loading
    });

    await Future.delayed(const Duration(milliseconds: 500)); // 0.5 second delay

    setState(() {
      people = PeopleModel.sampleData(); // Reload data
      isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://i.pinimg.com/736x/e6/2c/be/e62cbe878799d496ebc32bc291feba13.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : people.names.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No people found!',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: refresh,
                child: const Text('Refresh List'),
              ),
            ],
          )
              : ListView.builder(
            shrinkWrap: true,
            itemCount: people.names.length,
            itemBuilder: (context, index) {
              final personName = people.names[index]; // Save name before dismiss

              return Dismissible(
                key: ValueKey(personName),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    people.names.removeAt(index);
                    people.imagePaths.removeAt(index);
                    people.themeColors.removeAt(index);
                    people.splashColors.removeAt(index);
                    people.descriptions.removeAt(index);
                    people.redirectionPage.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$personName dismissed'),
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                  },
                child: Card(
                  color: people.themeColors[index],
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    splashColor: people.splashColors[index],
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          people.imagePaths[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      people.names[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(people.descriptions[index]),
                    trailing: const Icon(Icons.remove_red_eye),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          people.redirectionPage[index],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
