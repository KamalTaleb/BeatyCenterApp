import 'package:beauty_center/custom/common/services/cart/add_remove_button.dart';
import 'package:beauty_center/custom/common/services/cart/cart_item.dart';
import 'package:beauty_center/service_price_text.dart';
import 'package:flutter/material.dart';

class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key,
    this.showAddRemoveButtons = true,
    required this.selectedServices,
    required this.selectedStaffForServices,
  });

  final bool showAddRemoveButtons;
  final List<Map<String, dynamic>> selectedServices;
  final Map<int, Map<String, String>> selectedStaffForServices;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(
        height: 32.0,
      ),
      itemCount: selectedServices.length,
      itemBuilder: (_, index) {
        final service = selectedServices[index];
        final staff = selectedStaffForServices[service['id']];
        return Column(
          children: [
            SCartItem(
              serviceName: service['name'],
              staffName: staff?['name'],
            ),
            if (showAddRemoveButtons)
              const SizedBox(
                height: 32.0,
              ),
            if (showAddRemoveButtons)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                      ),
                      SServicesQuantityWithAddRemoveButton(),
                    ],
                  ),
                ],
              ),
            SServicePriceText(
              price: service['price'].toString(),
            ),
          ],
        );
      },
    );
  }
}

