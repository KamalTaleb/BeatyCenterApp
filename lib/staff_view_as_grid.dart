import 'package:beauty_center/screens/booking_calendar.dart';
import 'package:flutter/material.dart';

class ViewAsGrid extends StatefulWidget {
  const ViewAsGrid({super.key});

  @override
  State<ViewAsGrid> createState() => _ViewAsGridState();
}

class _ViewAsGridState extends State<ViewAsGrid> {
  Set<String> selectedImagePaths = {};
  final List<Section> sections = [
    Section(
      title: 'Section 1',
      images: [
        {'path': 'images/home1.JPG', 'title': 'Staff Name 1'},
        {'path': 'images/home2.JPG', 'title': 'Staff Name 2'},
        {'path': 'images/home3.JPG', 'title': 'Staff Name 3'},
        {'path': 'images/home4.JPG', 'title': 'Staff Name 4'},
      ],
    ),
    Section(
      title: 'Section 2',
      images: [
        {'path': 'images/home5.JPG', 'title': 'Staff Name 5'},
        {'path': 'images/home6.jpg', 'title': 'Staff Name 6'},
        {'path': 'images/hair1.jpg', 'title': 'Staff Name 7'},
        {'path': 'images/hair2.jpg', 'title': 'Staff Name 8'},
        {'path': 'images/home3.jpg', 'title': 'Staff Name 9'},
        {'path': 'images/mua1.jpg', 'title': 'Staff Name 10'},
      ],
    ),
  ];

  void _onImageTap(String imagePath) {
    setState(() {
      if (selectedImagePaths.contains(imagePath)) {
        selectedImagePaths.remove(imagePath);
      } else {
        selectedImagePaths.add(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: sections.expand((section) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        section.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 8, // Space between columns
                      mainAxisSpacing: 8, // Space between rows
                      childAspectRatio: 3 / 2, // Aspect ratio for the items
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final image = section.images[index];
                        return SelectableImageWithTitle(
                          imagePath: image['path']!,
                          title: image['title']!,
                          isSelected:
                              selectedImagePaths.contains(image['path']),
                          onTap: () => _onImageTap(image['path']!),
                        );
                      },
                      childCount: section.images.length,
                    ),
                  ),
                ),
              ];
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SBookingCalendarPage(),
                ),
              );
            },
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }
}

class Section {
  final String title;
  final List<Map<String, String>> images;

  Section({
    required this.title,
    required this.images,
  });
}

class SelectableImageWithTitle extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableImageWithTitle({
    required this.imagePath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.teal : Colors.transparent,
                  width: 3,
                ),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
