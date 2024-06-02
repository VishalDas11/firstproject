import "dart:io";
import "package:cached_network_image/cached_network_image.dart";
import "package:firstproject/controller/theme_controller.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get.dart";

class UserImageView extends StatelessWidget {
  const UserImageView({
    Key? key,
    this.radius = 50,
    required this.url,
    this.local = false,
    this.backgroundColor,
    this.frameUrl,
  }) : super(key: key);
  final double radius;
  final String url;
  final bool local;
  final Color? backgroundColor;
  final String? frameUrl;
  @override
  // final themeController = Get.put((DarkThemeController()));

  Widget build(BuildContext context) {
    // var darkThemeProvider = Provider.of<DarkThemeProvider>(context);

    return GetBuilder<DarkThemeController>(builder: (themeController) {
      return Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius * 2.5),
            child: url.isEmpty
                ? Container(
                    width: radius * 2.5,
                    height: radius * 2.5,
                    color: themeController.isDarkTheme
                        ? const Color.fromARGB(255, 65, 67, 73)
                        : const Color.fromARGB(255, 201, 201, 201),
                    padding: EdgeInsets.all(radius / 1.5),
                    child: SvgPicture.asset(
                      "assets/icon/user.svg",
                      color: Colors.white,
                    ),
                  )
                : local
                    ? Image.file(
                        File(url),
                        height: radius * 2.5,
                        width: radius * 2.5,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: url,
                        height: frameUrl != null && frameUrl!.isNotEmpty
                            ? radius * 2
                            : radius * 2.5,
                        width: frameUrl != null && frameUrl!.isNotEmpty
                            ? radius * 2
                            : radius * 2.5,
                        fit: BoxFit.cover,
                        // imageBuilder: (ctx, _) => Container(
                        //   width: radius * 2,
                        //   height: radius * 2,
                        //   color: darkThemeProvider.darkTheme
                        //       ? Constants.darkCardColor
                        //       : const Color(0xFFEFEEEE),
                        //   padding: EdgeInsets.all(radius / 1.5),
                        //   child: SvgPicture.asset(
                        //     "assets/icons/user.svg",
                        //     color: Colors.white,
                        //   ),
                        // ),
                        placeholder: (ctx, _) => Container(
                          width: radius * 2,
                          height: radius * 2,
                          color: themeController.isDarkTheme
                              ? themeController.colorCard
                              : const Color(0xFFEFEEEE),
                          padding: EdgeInsets.all(radius / 1.5),
                          child: SvgPicture.asset(
                            "assets/icon/user.svg",
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: radius * 2,
                          height: radius * 2,
                          color: themeController.isDarkTheme
                              ? themeController.colorCard
                              : const Color(0xFFEFEEEE),
                          padding: EdgeInsets.all(radius / 1.5),
                          child: SvgPicture.asset(
                            "assets/icon/user.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
          ),
        ],
      );
    });
  }
}
