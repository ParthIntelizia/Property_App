import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxepass/constants/constant_colors.dart';
import 'package:luxepass/models/more_hotel_model.dart';

import '../../constants/constant_widgets.dart';

class MoreHotelItemWidget extends StatefulWidget {
  final MoreHotelModel moreHotelModel;
  const MoreHotelItemWidget(
      {Key? key,
        required this.moreHotelModel})
      : super(key: key);

  @override
  State<MoreHotelItemWidget> createState() => _MoreHotelItemWidgetState();
}

class _MoreHotelItemWidgetState extends State<MoreHotelItemWidget> {
  ConstWidgets constWidgets = ConstWidgets();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          width: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  height: 100,
                  width: 220,
                  child: Image.asset(
                    widget.moreHotelModel.image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: 200,
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       constWidgets.textWidget(
                           widget.moreHotelModel.title!,
                           FontWeight.w700,
                           14, Colors.black),
                       const SizedBox(height: 5),
                       Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           const Icon(Icons.location_pin,
                               size: 12, color: ConstColors.lightColor),
                           const SizedBox(width: 2),
                           constWidgets.textWidget(widget.moreHotelModel.location!,
                               FontWeight.w600, 12, ConstColors.serviceRateStatmentColor),
                         ],
                       ),

                     ],
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.star,
                              size: 12, color: ConstColors.lightColor),
                          const SizedBox(width: 3),
                          constWidgets.textWidget(widget.moreHotelModel.rating!,
                              FontWeight.w600, 12, ConstColors.serviceRateStatmentColor),
                        ],
                      ),
                      const SizedBox(height: 5),
                      constWidgets.textWidget("${widget.moreHotelModel.review!} Reviews",
                          FontWeight.w600, 12, ConstColors.serviceRateStatmentColor),

                    ],

                   )

                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
