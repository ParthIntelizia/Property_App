import 'package:flutter/material.dart';
import 'package:luxepass/home/search/widgets/search_addGuest.dart';
import 'package:luxepass/home/search/widgets/search_date.dart';

import '../../../constants/constant_colors.dart';
import '../../../constants/constant_widgets.dart';

class SearchDateMemberWidget extends StatefulWidget {
  const SearchDateMemberWidget({Key? key}) : super(key: key);

  @override
  State<SearchDateMemberWidget> createState() => _SearchDateMemberWidgetState();
}

class _SearchDateMemberWidgetState extends State<SearchDateMemberWidget> {
  ConstWidgets constWidgets = ConstWidgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Material(
        elevation: 10,
        shadowColor: ConstColors.widgetDividerColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(children: [
            constWidgets.textWidget("Select Date", FontWeight.w600, 20,
                const Color.fromRGBO(0, 0, 0, 1)),
            const SizedBox(
              height: 10,
            ),
            const SearchDate(),
            const SizedBox(
              height: 20,
            ),
            constWidgets.textWidget("Select Guest", FontWeight.w600, 20,
                const Color.fromRGBO(0, 0, 0, 1)),
            const SizedBox(
              height: 10,
            ),
            const SearchAddGuestWidget(),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
