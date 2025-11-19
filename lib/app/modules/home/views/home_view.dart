import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            children: [
              _buildUserProfileSection(context, isTablet),
              SizedBox(height: isTablet ? 32 : 24),
              _buildMainGridSection(context, isTablet),
              SizedBox(height: isTablet ? 32 : 24),
              _buildRecentActivitySection(context, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileSection(BuildContext context, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 24 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isTablet ? 80 : 60,
            height: isTablet ? 80 : 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 2,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  controller.profileImage.value,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: isTablet ? 20 : 16),

          // User Details
          Expanded(
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back! 👋',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.8),
                              fontSize: isTablet ? 16 : 14,
                            ),
                      ),
                      SizedBox(height: isTablet ? 8 : 4),
                      Text(
                        controller.userName.value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: isTablet ? 24 : 20,
                            ),
                      ),
                      SizedBox(height: isTablet ? 4 : 2),
                      Text(
                        controller.userEmail.value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.8),
                              fontSize: isTablet ? 14 : 12,
                            ),
                      ),
                    ],
                  ))),

          // Edit Profile Button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit_outlined,
                size: isTablet ? 24 : 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: controller.onEditProfilePressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainGridSection(BuildContext context, bool isTablet) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildGridItem(
                context,
                title: 'Shopping',
                subtitle: 'Continue shopping',
                icon: Icons.shopping_cart_outlined,
                color: Colors.green,
                onTap: controller.onShoppingPressed,
                isTablet: isTablet,
              ),
            ),
            SizedBox(width: isTablet ? 20 : 16),
            Expanded(
              child: _buildGridItem(
                context,
                title: 'My Orders',
                subtitle: 'Track your orders',
                icon: Icons.shopping_bag_outlined,
                color: Colors.blue,
                onTap: controller.onOrdersPressed,
                isTablet: isTablet,
              ),
            ),
          ],
        ),
        SizedBox(height: isTablet ? 20 : 16),
        Row(
          children: [
            Expanded(
              child: _buildGridItem(
                context,
                title: 'Settings',
                subtitle: 'App preferences',
                icon: Icons.settings_outlined,
                color: Colors.orange,
                onTap: controller.onSettingsPressed,
                isTablet: isTablet,
              ),
            ),
            SizedBox(width: isTablet ? 20 : 16),
            Expanded(
              child: _buildGridItem(
                context,
                title: 'Profile',
                subtitle: 'Manage account',
                icon: Icons.person_outlined,
                color: Colors.purple,
                onTap: controller.onProfilePressed,
                isTablet: isTablet,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGridItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isTablet,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(isTablet ? 24 : 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                width: isTablet ? 50 : 40,
                height: isTablet ? 50 : 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: isTablet ? 24 : 20,
                  color: color,
                ),
              ),
              SizedBox(height: isTablet ? 16 : 12),

              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: isTablet ? 18 : 16,
                    ),
              ),
              SizedBox(height: isTablet ? 4 : 2),

              // Subtitle
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: isTablet ? 14 : 12,
                    ),
              ),

              // Arrow Icon
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: isTablet ? 16 : 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 24 : 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: isTablet ? 20 : 18,
                    ),
              ),
              TextButton(
                onPressed: controller.onViewAllActivityPressed,
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: isTablet ? 14 : 12,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 16 : 12),

          // Activity Items
          _buildActivityItem(
            context,
            icon: Icons.shopping_bag_rounded,
            title: 'Order #12345',
            subtitle: 'Delivered successfully',
            time: '2 hours ago',
            color: Colors.green,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 12 : 8),
          _buildActivityItem(
            context,
            icon: Icons.payment_rounded,
            title: 'Payment Received',
            subtitle: 'Amount: \$125.99',
            time: '5 hours ago',
            color: Colors.blue,
            isTablet: isTablet,
          ),
          SizedBox(height: isTablet ? 12 : 8),
          _buildActivityItem(
            context,
            icon: Icons.local_offer_rounded,
            title: 'Special Offer',
            subtitle: '50% off on electronics',
            time: '1 day ago',
            color: Colors.orange,
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
    required bool isTablet,
  }) {
    return Row(
      children: [
        // Icon
        Container(
          width: isTablet ? 45 : 40,
          height: isTablet ? 45 : 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: isTablet ? 20 : 18,
            color: color,
          ),
        ),
        SizedBox(width: isTablet ? 16 : 12),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: isTablet ? 16 : 14,
                    ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      fontSize: isTablet ? 14 : 12,
                    ),
              ),
            ],
          ),
        ),

        // Time
        Text(
          time,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                fontSize: isTablet ? 12 : 10,
              ),
        ),
      ],
    );
  }
}
