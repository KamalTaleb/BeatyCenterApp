import 'package:beauty_center/billing_address_section.dart';
import 'package:beauty_center/billing_amount_section.dart';
import 'package:beauty_center/billing_payment_section.dart';
import 'package:beauty_center/coupon_widget.dart';
import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/custom/common/services/cart/cart_Items.dart';
import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:beauty_center/screens/cart.dart';
import 'package:beauty_center/screens/navigation_menu.dart';
import 'package:beauty_center/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class SCheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedServices;
  final Map<int, Map<String, String>> selectedStaffForServices;
  final DateTime selectedDate;
  final String selectedTime;

  const SCheckoutScreen({
    super.key,
    required this.selectedServices,
    required this.selectedStaffForServices,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: SAppbar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SCartScreen()),
          );
        },
        showBackArrow: true,
        title: Text(
          'Appointment Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'images/checkout.PNG',
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Wohoo! Can't wait to see you",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Date: $formattedDate',
                style: const TextStyle(fontSize: 18,),
              ),
              const SizedBox(height: 10),
              Text(
                'Time: $selectedTime',
                style: const TextStyle(fontSize: 18,),
              ),
              const SizedBox(height: 20),
              SCartItems(
                showAddRemoveButtons: false,
                selectedServices: selectedServices,
                selectedStaffForServices: selectedStaffForServices,
              ),
              const SizedBox(
                height: 32.0,
              ),
              SRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(8.0),
                backgroundColor: dark ? Colors.black : Colors.white,
                child: const Column(
                  children: [
                    SBillingPaymentSection(),
                    SizedBox(
                      height: 16.0,
                    ),
                    SBillingAddressSection(),
                  ],
                  
                ),
                
              ),
              SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                ),
                onPressed:() {
                  Get.to(() => NavigationMenu());
                }, child: Text('Return to homepage', style: TextStyle(color: Colors.white)),
              ),],
          ),
        ),
      ),
    );
  }
}
