import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:luxepass/constants/constant_widgets.dart';

class SearchWidget extends StatefulWidget {
  final String title;
  final String highlight;
  const SearchWidget({Key? key, required this.title, required this.highlight})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  ConstWidgets constWidgets = ConstWidgets();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ConstColors.searchBoxColor,
                  border: Border.all(
                      color: ConstColors.widgetDividerColor, width: 1.0),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        const Icon(Icons.search,
                            size: 22, color: ConstColors.lightColor),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          child: constWidgets.textWidget(
                              widget.title,
                              FontWeight.w500,
                              12,
                              ConstColors.searchBoxHighlightColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
