import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_event.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_state.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

class ChangeSetting extends StatelessWidget {
  const ChangeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.halfPadding),
            child: Text("বাংলা"),
          ),
          CupertinoSwitch(
              value: state.locale == const Locale('en'),
              applyTheme: true,
              trackColor: AppColors.colorPrimary,
              autofocus: true,
              onChanged: (v) {
                context.read<BaseBloc>().add(ChangeLanguageEvent(
                    locale: Locale(v == true ? 'en' : 'bn')));
              }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppValues.halfPadding),
            child: Text("English"),
          ),
          IconButton(
              onPressed: () {
                context.read<BaseBloc>().add(ChangeThemeEvent(
                    themeMode: state.themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark));
              },
              icon: state.themeMode == ThemeMode.dark
                  ? const CircleAvatar(
                      child: Icon(
                      Icons.light_mode_outlined,
                    ))
                  : const CircleAvatar(
                      child: Icon(
                        Icons.dark_mode,
                      ),
                    ))
        ],
      );
    });
  }
}
