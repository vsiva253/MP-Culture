import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool showForwardArrow;
  final ValueChanged<bool>? onToggleChanged;
  final VoidCallback? onArrowPressed;
  final bool isDarkMode;

  CustomContainer({
    required this.text,
    required this.icon,
    this.showForwardArrow = false,
    this.onToggleChanged,
    this.onArrowPressed,
    required this.isDarkMode,
  });

  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 0),
      child: Container(
        height: 54,
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            border: BorderDirectional(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        )),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                gradient: LinearGradient(
                  colors: [Color(0xFF1D2671), Color(0xFFC33764)],
                  stops: [0.0, 1.0],
                  transform: GradientRotation(122.32 * 3.1415927 / 180),
                ),
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Text(widget.text, style: const TextStyle(fontSize: 16)),
            Expanded(child: SizedBox()),
            if (widget.showForwardArrow)
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (widget.onArrowPressed != null) {
                    widget.onArrowPressed!();
                  }
                },
              )
            else
              Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                  trackColor: Colors.grey,
                  thumbColor: Colors.white70,
                  activeColor: Color(0xFFC33764),
                  value: isToggled,
                  onChanged: (value) {
                    if (widget.onToggleChanged != null) {
                      widget.onToggleChanged!(value);
                    }
                    setState(() {
                      isToggled = value;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
