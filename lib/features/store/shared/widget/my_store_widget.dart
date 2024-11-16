// import 'package:app_ui/app_ui.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nova_wheels/config/sl/injection_container.dart';
// import 'package:nova_wheels/core/routes/routes.dart';
// import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
// import 'package:nova_wheels/features/store/presentation/blocs/fetch_store_bloc/fetch_store_bloc.dart';
// import 'package:nova_wheels/features/store/shared/store_type_enum.dart';
//
// import 'verification_chip.dart';
//
// class MyStoreWidget extends StatelessWidget {
//   const MyStoreWidget({
//     super.key,
//     required this.type,
//   });
//
//   final FetchStoreType type;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl.get<FetchStoreBloc>()
//         ..add(
//           StoreFetched(type: type),
//         ),
//       child: BlocBuilder<FetchStoreBloc, FetchStoreState>(
//         builder: (context, state) {
//           return switch (state) {
//             FetchStoreInitial() => const Center(child: Text('Initializing...')),
//             FetchStoreLoading() =>
//               //TODO: create shimmer loading here
//               const Center(child: CircularProgressIndicator()),
//             FetchStoreSuccess storeSuccess => ListView.separated(
//                 physics: const NeverScrollableScrollPhysics(),
//                 separatorBuilder: (context, index) => const Gap(10),
//                 padding: const EdgeInsets.all(8),
//                 shrinkWrap: true,
//                 itemCount: storeSuccess.storeEntities.length,
//                 itemBuilder: (context, index) {
//                   final store = storeSuccess.storeEntities[index];
//                   return StoreFrontWidget(store: store, type: type);
//                 },
//               ),
//             FetchStoreFailure failure => Center(
//                 child: Text(failure.errorMessage),
//               ),
//           };
//         },
//       ),
//     );
//   }
// }
//
