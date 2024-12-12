import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/features/home/shared/drawer/nova_wheels_drawer.dart';
import 'package:nova_wheels/features/home/shared/images/banners_urls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text('Welcome to Nova Wheels!'),
        titleTextStyle: context.titleLarge,
      ),
      drawer: NovaWheelsDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Best Car Deals at One Place!',
                style: context.labelLarge,
              ),
              5.gap,
              AppCarouselSlider(
                imageUrls: rentACarBannerImages,
                height: 150,
                scale: 0.5,
              ),
              // categories row
              10.gap,
              CategoriesRow(),
              5.gap,
              Text(
                'Explore the best deals on cars from top dealerships',
                style: context.labelLarge,
              ),
              5.gap,
              AppCarouselSlider(
                imageUrls: buyCarBannerImages,
                height: 150,
                scale: 0.5,
              ),
              20.gap,
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[300], // Light grey background
      ), // Light grey background
      padding: const EdgeInsets.symmetric(
          vertical: 16.0), // Add some vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCategoryItem(
            icon: Icons.directions_car,
            label: "Buy Cars",
          ),
          _buildCategoryItem(
            icon: Icons.car_rental,
            label: "Sell Cars",
          ),
          _buildCategoryItem(
            icon: Icons.key,
            label: "Rent Cars",
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
