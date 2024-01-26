import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import 'button_loading_widget.dart';

class TSocialButton extends StatelessWidget {
  const TSocialButton({
    Key? key,
    required this.text,
    required this.image,
    this.isLoading = false,
    required this.foreground,
    required this.background,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final String image;
  final Color foreground, background;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            side: BorderSide.none,
            shape: const StadiumBorder()),
        icon: isLoading
            ? const SizedBox()
            : Image(image: AssetImage(image), width: 24, height: 24),
        label: isLoading
            ? const ButtonLoadingWidget()
            : Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: foreground)),
      ),
    );
  }
}
