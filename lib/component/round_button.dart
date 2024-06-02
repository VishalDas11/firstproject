
import 'package:firstproject/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'small_loader.dart';


class RoundButton extends StatefulWidget {
  const RoundButton({
    super.key,
    this.backgroundColor =  primaryColor,
    this.titleColor = whiteColor,
    required this.title,
    required this.onTap,
    this.icon,
    this.height = 55,
    this.width,
    this.margin = 40,
    this.loading = false,
    this.disabled = false,
  });

  final String title;
  final IconData? icon;
  final Color backgroundColor;
  final Color titleColor;
  final double height;
  final double? width;
  final double margin;
  final bool loading;
  final bool disabled;
  final VoidCallback onTap;

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: widget.onTap,
      onPanDown: (details) {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = true;
        });
      },
      onPanEnd: (_) {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = false;
        });
      },
      onPanCancel: () {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = false;
        });
      },
      onTap: () {
        if (widget.loading || widget.disabled) return;
        widget.onTap();
      },
      child: AnimatedOpacity(
        opacity: pressed ? 0.8 : 1,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.height,
          width: widget.width,
          margin: EdgeInsets.symmetric(horizontal: widget.margin),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.disabled
                ? widget.backgroundColor.withOpacity(0.6)
                : widget.backgroundColor,
            // gradient: widget.gradient ? backgroundGradient : null,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withOpacity(0.1),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null && !widget.loading)
              Icon(widget.icon),
                // SvgPicture.asset(
                //   widget.icon!,
                //   color: widget.titleColor,
                //   height: 18,
                // ),
              if (widget.icon != null && !widget.loading)
                const SizedBox(width: 10),
              if (!widget.loading)
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: widget.titleColor,
                    fontSize: 17,
                  ),
                ),
              if (widget.loading) SmallLoader(color: widget.titleColor)
            ],
          ),
        ),
      ),
    );
  }
}
