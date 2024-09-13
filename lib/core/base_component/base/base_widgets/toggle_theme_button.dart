import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_start/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:quick_start/core/base_component/base/base_bloc/base_event.dart';
import 'package:quick_start/core/base_component/base/base_bloc/base_state.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        bool isDarkMode = state.themeMode == ThemeMode.dark;
        return GestureDetector(
          onTap: () {
            context.read<BaseBloc>().add(
                  ChangeThemeEvent(
                    themeMode: state.themeMode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  ),
                );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: isDarkMode ? Colors.grey[850] : Colors.grey[300],
            ),
            child: Row(
              mainAxisAlignment:
                  isDarkMode ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color: isDarkMode ? Colors.amber : Colors.blue,
                    size: 20,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
