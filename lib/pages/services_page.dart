import 'package:flutter/material.dart';
import 'package:luxepass/constants/const_variables.dart';
import 'package:luxepass/get_storage_services/get_storage_service.dart';
import 'package:luxepass/pages/service_inquery_page.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/web_view.dart';
import 'authentication/signin.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with SingleTickerProviderStateMixin {
  ConstWidgets constWidgets = ConstWidgets();

  List<String> servicesImage = [
    "assets/services/service1.svg",
    "assets/services/service2.svg",
    "assets/services/service3.svg",
    "assets/services/service4.svg",
    "assets/services/service5.svg",
    "assets/services/service6.svg",
    "assets/services/service7.svg",
    "assets/services/service8.svg",
    "assets/services/service9.svg",
  ];

  List<String> keyPoints = [
    "Sales",
    "Letting",
    "Auction ",
    "Conveyancing",
    "EPC",
    "Accomodation",
    "Heating & Electrical",
    "Mortgages",
    "Insepection Report"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.backgroundColor,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ConstVar.backgroundImg), fit: BoxFit.cover),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
                child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: width,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  constWidgets.textWidget(
                      "Services", FontWeight.w700, 22, Colors.black),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.more_vert,
                  //       size: 24.0,
                  //       color: Colors.grey,
                  //     ))
                ],
              ),
            )),
          ];
        },
        body: _descriptionWidget(),
      ),
    );
  }

  Widget _descriptionWidget() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width - 30,
      child: SingleChildScrollView(
          child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: servicesImage.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (context, index) {
          return serviceItem(index);
        },
      )),
    );
  }

  Widget serviceItem(int index) {
    return InkWell(
      onTap: () {
        if (GetStorageServices.getUserLoggedInStatus() == true) {
          if (index == 2) {
            Get.to(
              () => WebViewScreen(
                link: "https://www.sdlauctions.co.uk/search/",
              ),
            );
          } else if (index == 3) {
            Get.to(
              () => WebViewScreen(
                link: "https://www.speedconveyancing.co.uk/",
              ),
            );
          }
          if (index != 2 && index != 3) {
            Get.to(
              () => ServiceEnquiryPage(
                enquiryName: keyPoints[index],
                index: index,
              ),
            );
          }
        } else {
          Get.to(() => SignInScreen());
        }
      },
      child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: ConstColors.searchBoxColor,
              border:
                  Border.all(color: ConstColors.widgetDividerColor, width: 0.5),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  servicesImage[index],
                  height: 30,
                  width: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: constWidgets.textWidget(
                    keyPoints[index], FontWeight.w500, 12, Colors.grey),
              )
            ],
          )),
    );
  }
}
