import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:beauty_center/service_price_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SServicesCardHorizontal extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final String duration;
  final String price;

  const SServicesCardHorizontal({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
  });

  @override
  _SServicesCardHorizontalState createState() => _SServicesCardHorizontalState();
}

class _SServicesCardHorizontalState extends State<SServicesCardHorizontal> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: dark ? const Color(0xFF939393) : const Color(0xFFF4F4F4),
        ),
        child: Row(
          children: [
            SRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(8.0),
              backgroundColor: dark ? const Color(0xFF272727) : const Color(0xFFF6F6F6),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.duration,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SServicePriceText(
                          price: widget.price,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: _isSelected ? Colors.teal : Colors.black54,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                          child: SizedBox(
                            width: 32.0 * 1.2,
                            height: 32.0 * 1.2,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(FontAwesomeIcons.plus),
                                onPressed: _toggleSelection,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
