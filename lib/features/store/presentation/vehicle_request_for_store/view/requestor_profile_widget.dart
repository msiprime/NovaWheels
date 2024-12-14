import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/profile/data/datasources/profile_datasource_impl.dart';
import 'package:nova_wheels/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/cubit/profile_of_requester_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequesterProfileWidget extends StatelessWidget {
  final String profileId;
  final String text;

  const RequesterProfileWidget({
    super.key,
    this.text = "Requested By:",
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileOfRequesterCubit(
        profileRepository: ProfileRepositoryImp(
          profileDataSource: ProfileDataSourceImpl(
            supabaseClient: Supabase.instance.client,
          ),
        ),
      )..fetchProfileDataById(id: profileId),
      child: RequesterProfileView(
        text: text,
      ),
    );
  }
}

class RequesterProfileView extends StatelessWidget {
  const RequesterProfileView({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileOfRequesterCubit, ProfileOfRequesterState>(
      builder: (context, state) {
        if (state is ProfileOfRequesterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProfileOfRequesterError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }

        if (state is ProfileOfRequesterSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      state.profile.avatarUrl ??
                          'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                    ), // Replace with actual image URL
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.profile.fullName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        state.profile.email,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
