import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_start/config/sl/injection_container.dart' as di;
import 'package:quick_start/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:quick_start/features/landing/presentation/blocs/landing_bloc.dart';
import 'package:quick_start/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:quick_start/features/sign_up/presentation/bloc/sign_up_bloc.dart';

class GlobalBlocProviders {
  dynamic providers = [
    BlocProvider(create: (_) => di.sl<BaseBloc>()),
    BlocProvider(create: (_) => di.sl<LandingBloc>()),
    BlocProvider(create: (_) => di.sl<SignUpBloc>()),
    BlocProvider(create: (_) => di.sl<SignInBloc>()),
  ];
}
