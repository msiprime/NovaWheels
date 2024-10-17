import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';

class GeneralStoreDetails extends StatelessWidget {
  final StoreEntity store;

  const GeneralStoreDetails({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: NovaWheelsAppBar(
          title: store.name,
        ),
        safeArea: true,
        body: Column(
          children: [
            ImageAttachmentThumbnail(
                imageUrl: store.coverImage ?? '', height: 200),
            const Gap(10),
            Text(store.name),
            const Gap(10),
            // UpdateStoreWidget(id: store.id)
          ],
        ));
  }
}
