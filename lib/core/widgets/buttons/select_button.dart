import 'package:flutter/material.dart';

Widget selectButton({
  Function? actionOnPressed,
  required String text,
  Key? key,
  required BuildContext context,
  TextStyle? textStyle,
  required IconData iconData,
  bool selected = false,
}) {
  Color _getTextColor(Set<MaterialState> states) => states.any(<MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      }.contains)
          ? Colors.grey.shade200
          : Colors.white;

  return ElevatedButton.icon(
    key: key,
    onPressed: actionOnPressed != null ? () => actionOnPressed() : null,
    icon: Icon(
      iconData,
      color: selected ? Colors.orange : Colors.grey.shade400,
      size: 20.0,
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith(_getTextColor),
      padding: MaterialStateProperty.resolveWith(
        (states) => const EdgeInsets.symmetric(horizontal: 12.0),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: selected
              ? const BorderSide(color: Colors.orange)
              : const BorderSide(color: Colors.white),
        ),
      ),
    ),
    label: Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 12),
    ),
  );
}
