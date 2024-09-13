import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';
import 'package:nova_wheels/shared/utils/utils.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';
import 'package:nova_wheels/shared/values/app_values.dart';
import 'package:nova_wheels/shared/values/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseMarkdown extends StatelessWidget {
  final String screenTitle;
  final String? markdownSource;

  const BaseMarkdown({
    super.key,
    required this.screenTitle,
    this.markdownSource,
  });

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: context.theme.colorScheme.onInverseSurface,
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: markdownSource != null
            ? Markdown(
                data: markdownSource ?? "",
                padding: const EdgeInsets.all(AppValues.padding),
                onTapLink: (text, href, title) async {
                  if (href != null) {
                    final Uri url = Uri.parse(href);
                    try {
                      await _launchInBrowser(url);
                    } catch (e) {
                      showSnackBarMessage(
                        //todo: fix async gap
                        context,
                        "Unable to open link: $href",
                        SnackBarMessageType.failure,
                      );
                    }
                  }
                },
              )
            : const Center(
                child: Text(
                  "No content to show",
                  style: titleStyle,
                ),
              ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      foregroundColor: context.theme.colorScheme.surface,
      backgroundColor: AppColors.colorPrimary,
      title: Text(screenTitle),
      centerTitle: true,
    );
  }
}
