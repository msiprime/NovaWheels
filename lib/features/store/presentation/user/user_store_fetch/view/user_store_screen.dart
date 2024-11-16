import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/blocs/fetch_store_bloc/fetch_store_bloc.dart';
import 'package:nova_wheels/features/store/shared/widget/verification_chip.dart';

class UserStoreScreen extends StatelessWidget {
  const UserStoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchStoreBloc, FetchStoreState>(
      builder: (context, state) {
        return switch (state) {
          FetchStoreInitial() => const Center(child: Text('Initializing...')),
          FetchStoreLoading() =>
            //TODO: create shimmer loading here
            const Center(child: CircularProgressIndicator()),
          FetchStoreSuccess storeSuccess => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Gap(10),
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: storeSuccess.storeEntities.length,
              itemBuilder: (context, index) {
                final store = storeSuccess.storeEntities[index];
                return StoreFrontWidget(store: store);
              },
            ),
          FetchStoreFailure failure => Center(
              child: Text(failure.errorMessage),
            ),
        };
      },
    );
  }
}

class StoreFrontWidget extends StatelessWidget {
  const StoreFrontWidget({
    super.key,
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    final bool isVerified = store.isVerified;

    return GestureDetector(
      onTap: () {
        context.goNamed(
          Routes.userStoreDetails,
          extra: store,
        );
      },
      child: Card(
        color: Colors.grey.shade100,
        clipBehavior: Clip.antiAlias,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        key: ValueKey(store.id),
        child: SizedBox(
          height: 200,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ImageAttachmentThumbnail(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                height: 140,
                width: double.infinity,
                imageUrl: store.coverImage ?? '',
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SlimVerificationLabel(isVerified: isVerified),
              ),
              Positioned(
                left: 10,
                top: 85,
                child: DottedBorder(
                  borderType: BorderType.Circle,
                  borderPadding: const EdgeInsets.all(1),
                  color: Colors.grey.shade50,
                  strokeWidth: 2,
                  stackFit: StackFit.loose,
                  // radius: const Radius.circular(200),
                  dashPattern: [1, 0],
                  child: ClipOval(
                    clipBehavior: Clip.antiAlias,
                    child: ImageAttachmentThumbnail(
                      height: 100,
                      width: 100,
                      imageUrl: store.profilePicture ?? '',
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 150,
                child: Column(
                  children: [
                    Text(
                      store.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor.withOpacity(0.8),
                        fontFamily: GoogleFonts.sansita().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
