import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:architecture_test_business/architecture_test_business.dart';
import 'package:provider/provider.dart';

class HotelDetailsView1 extends StatefulWidget {
  const HotelDetailsView1({Key? key, required this.hotelPreview}) : super(key: key);

  final HotelPreview hotelPreview;

  @override
  _HotelDetailsView1State createState() => _HotelDetailsView1State();
}

class _HotelDetailsView1State extends State<HotelDetailsView1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Consumer<HotelDetailsNotifier>(builder: (context, state, child) {
      print("Consumer");
      state.getHotelData(widget.hotelPreview.uuid);
      //Hotel _currentHotel = state.;

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.hotelPreview.name),
        ),
        body: SafeArea(
          child: !state.isLoaded
              ? const Center(
                  child: Text("Not loaded"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                        ),
                        items: state.hotelData.photos
                            .map((item) => Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Center(
                                    child: FadeInImage(
                                      placeholder: const AssetImage("assets/images/loading2.gif"),
                                      image: AssetImage('assets/images/$item'),
                                      width: 1000.0,
                                      height: 650,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Column(
                          children: [
                            DescriptionText(label: "Страна", text: state.hotelData.address.country),
                            DescriptionText(label: "Город", text: state.hotelData.address.city),
                            DescriptionText(label: "Улица", text: state.hotelData.address.street),
                            DescriptionText(
                                label: "Рейтинг", text: state.hotelData.rating.toString()),
                            DescriptionText(
                                label: "Индекс", text: state.hotelData.address.zipCode.toString()),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 20, bottom: 10),
                              child: const Text("Сервисы",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Платные",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500, fontSize: 20)),
                                          const SizedBox(height: 10),
                                          ...state.hotelData.services.paid
                                              .map((e) => Text(e.toString()))
                                              .toList()
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(left: 5),
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Платные",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500, fontSize: 20)),
                                              const SizedBox(height: 10),
                                              ...state.hotelData.services.free
                                                  .map((e) => Text(e.toString()))
                                                  .toList()
                                            ],
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key, required this.label, this.text}) : super(key: key);

  final String label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Text("$label:   "),
            Text(text ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ));
  }
}
