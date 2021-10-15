import 'package:flutter/material.dart';
import 'package:soccer_app/configs/configs.dart';
import 'package:soccer_app/services/services.dart';

class CustomBottomBar extends StatelessWidget {
  /// A bottom bar that faithfully follows the design by Aurélien Salomon
  ///
  /// https://dribbble.com/shots/5925052-Google-Bottom-Bar-Navigation-Pattern/
  CustomBottomBar({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<CustomBottomBarItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// The opacity of color of the touchable background when the item is selected.
  final double? selectedColorOpacity;

  /// The border shape of each item.
  final ShapeBorder itemShape;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(
            color: Config.perpel,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final item in items)
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                  ),
                  curve: curve,
                  duration: duration,
                  builder: (context, t, _) {
                    final _selectedColor = item.selectedColor ??
                        selectedItemColor ??
                        theme.primaryColor;

                    return Material(
                      color: Color.lerp(
                          _selectedColor.withOpacity(0.0),
                          _selectedColor
                              .withOpacity(selectedColorOpacity ?? 0.9),
                          t),
                      shape: itemShape,
                      child: InkWell(
                        onTap: () => onTap?.call(items.indexOf(item)),
                        customBorder: itemShape,
                        focusColor: _selectedColor,
                        highlightColor: _selectedColor,
                        splashColor: _selectedColor,
                        hoverColor: _selectedColor,
                        child: Padding(
                          padding: itemPadding -
                              EdgeInsets.only(right: itemPadding.right * t),
                          child: Row(
                            children: [
                              IconTheme(
                                data: IconThemeData(
                                  color: Color.lerp(
                                      Colors.black, Config.perpel, t),
                                  size: 24,
                                ),
                                child: items.indexOf(item) == currentIndex
                                    ? item.activeIcon ?? item.icon
                                    : item.icon,
                              ),
                              ClipRect(
                                child: SizedBox(
                                  height: 20,
                                  child: Align(
                                    alignment: Alignment(-0.2, 0.0),
                                    widthFactor: t,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: itemPadding.right / 2,
                                          right: itemPadding.right),
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                            color: Config.perpel,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                        child: item.title,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ));
  }
}

/// A tab to display in a [CustomBottomBar]
class CustomBottomBarItem {
  /// An icon to display.
  final Widget icon;

  /// An icon to display when this tab bar is active.
  final Widget? activeIcon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  CustomBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
