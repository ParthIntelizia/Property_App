import 'package:flutter/material.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant_widgets.dart';
import '../../../providers/search_screen_provider.dart';

class SearchSuggestionWidget extends StatefulWidget {
  final String suggestionType;
  final String image;
  final String cityName;

  const SearchSuggestionWidget(
      {Key? key,
      required this.suggestionType,
      required this.image,
      required this.cityName})
      : super(key: key);

  @override
  State<SearchSuggestionWidget> createState() => _SearchSuggestionWidgetState();
}

class _SearchSuggestionWidgetState extends State<SearchSuggestionWidget> {
  ConstWidgets constWidgets = ConstWidgets();
  @override
  void initState() {
    SearchScreenProvider _searchScreenProvider =
        Provider.of<SearchScreenProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SearchScreenProvider _searchScreenProvider =
        Provider.of<SearchScreenProvider>(context);
    return InkWell(
      onTap: () {
        if (widget.suggestionType == "city") {
          _searchScreenProvider.selectCity(widget.cityName);
        } else if (widget.suggestionType == "amenities") {
          _searchScreenProvider.selectAmenities(widget.cityName);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: (widget.cityName == _searchScreenProvider.selectedCity) ||
                    (widget.cityName == _searchScreenProvider.selectedAmenities)
                ? EdgeInsets.all(3)
                : EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      (widget.cityName == _searchScreenProvider.selectedCity) ||
                              (widget.cityName ==
                                  _searchScreenProvider.selectedAmenities)
                          ? ConstColors.lightColor
                          : Colors.transparent,
                  width:
                      (widget.cityName == _searchScreenProvider.selectedCity) ||
                              (widget.cityName ==
                                  _searchScreenProvider.selectedAmenities)
                          ? 3
                          : 1),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(widget.image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          constWidgets.textWidget(
              widget.cityName,
              FontWeight.w600,
              14,
              (widget.cityName == _searchScreenProvider.selectedCity) ||
                      (widget.cityName ==
                          _searchScreenProvider.selectedAmenities)
                  ? ConstColors.lightColor
                  : const Color.fromRGBO(65, 65, 65, 1))
        ],
      ),
    );
  }
}
