import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';

import '../../../../core/base_component/base/base_widgets/action_buttons.dart';
import '../../../../core/base_component/base/base_widgets/icon_and_count.dart';
import '../../../../core/base_component/base/base_widgets/make_email_call.dart';
import '../../../../core/base_component/base/base_widgets/make_phone_call.dart';
import '../../../../core/base_component/base/base_widgets/make_whatsapp_call.dart';

class VehicleDetailsPage extends StatefulWidget {
  final String adId;
  final AdUserInfo? userInfo;

  const VehicleDetailsPage({super.key, required this.adId, this.userInfo});

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  // final cubit = base_sl.get<PropertyDetailsCubit>();
  late final GoogleMapController mapController;

  late ScrollController _scrollController;
  bool _showTitle = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 56 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      } else if (_scrollController.offset > 56 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
    });

    // cubit.getPropertyById(widget.adId);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                // Collapsible Toolbar
                SliverAppBar(
                  leadingWidth: context.width * 0.25,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leading: UrgentBackButton(
                      // showBackText: true,
                      ),
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: true,
                  iconTheme: const IconThemeData(color: Colors.blue),
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "propertyEntity.title ??",
                    ),
                    background: Stack(
                      children: [
                        AppCarouselSlider(
                          imageUrls: [],
                          height: 225,
                        ),
                        // Positioned(
                        //   top: 50.0,
                        //   right: 6.0,
                        //   child: propertyEntity.isApproved ?? false
                        //       ? const VerifiedChip()
                        //       : const SizedBox(),
                        // ),
                        Positioned(
                          right: 6.0,
                          bottom: 85,
                          child: const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Property Details Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "{propertyEntity.currency} {propertyEntity.price}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // _buildBedBathAreaSection(propertyEntity),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 16),
                        const SizedBox(height: 16),
                        // Amenities Section
                        // Map View
                        const SizedBox(height: 16),
                        const SizedBox(
                          height: 16,
                        ),
                        // _buildMoreInfoSection(propertyEntity),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildOverviewSection(VehicleResponseEntity vehicle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Type", style: TextStyle(color: Colors.grey)),
            Text("Property Type"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Purpose", style: TextStyle(color: Colors.grey)),
            Text(vehicle.status ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Completion Status",
                style: TextStyle(color: Colors.grey)),
            Text("Completion Status"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Furnishing", style: TextStyle(color: Colors.grey)),
            Text("Furnishing Status"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Updated At", style: TextStyle(color: Colors.grey)),
            Text(""),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildBedBathAreaSection(VehicleResponseEntity propertyAd) {
    return Row(
      children: [
        IconAndCount(
          icon: AppAssets.manAboveCarLottie,
          count: " beds",
        ),
        const Gap(12),
        IconAndCount(
          icon: AppAssets.facebookSVG,
          iconWidget: const Icon(
            Icons.bathroom_outlined,
            size: 16,
          ),
          count: " baths",
        ),
        const Gap(12),
        IconAndCount(
          icon: AppAssets.circleLogoNoBackGroundSvg,
          count: " sqft",
        ),
      ],
    );
  }

  Column _buildAddressSection(
      VehicleResponseEntity propertyEntity, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address of car', style: context.bodyMedium),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _buildBottomCallSection() {
    return Row(
      children: [
        Expanded(
          child: MakePhoneCall(phoneNumber: ""),
        ),
        const Gap(2),
        Expanded(
          child: MakeEmailCall(email: ""),
        ),
        const Gap(2),
        Expanded(
          child: MakeWhatsAppCall(whatsappNumber: ""),
        ),
      ],
    );
  }

  _buildProfileSection(BuildContext context, VehicleResponseEntity vehicle) {
    return widget.userInfo != null
        ? SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppAssets.circleLogoNoBackGroundPng,
                        width: 50,
                        height: 50,
                      ),
                    )),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.userInfo?.displayName}\n${widget.userInfo?.phone}\n${widget.userInfo?.email}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       fullscreenDialog: true,
                    //       barrierDismissible: true,
                    //       builder: (context) =>
                    //           AgentProfilePage(userInfo: widget.userInfo!)),
                    // );
                  },
                  child: const Text(
                    "View All Properties >>",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
              ],
            ),
          )
        : const SizedBox();
  }

  _buildMoreInfoSection(VehicleResponseEntity vehicle) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("More Info",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Permit Number", style: TextStyle(color: Colors.grey)),
            Text("123456789"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("DED", style: TextStyle(color: Colors.grey)),
            Text("445566"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("RERA", style: TextStyle(color: Colors.grey)),
            Text("123345"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Reference ID", style: TextStyle(color: Colors.grey)),
            Text("UR-01-2345"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("BRN (DLD)", style: TextStyle(color: Colors.grey)),
            Text("998877"),
          ],
        ),
        SizedBox(height: 16),
        Divider(),
      ],
    );
  }
}

class AdUserInfo {
  final String? displayName;
  final String? phone;
  final String? email;

  AdUserInfo({this.displayName, this.phone, this.email});
}
