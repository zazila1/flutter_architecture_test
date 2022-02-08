import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:hotels/models/hotel.dart';
import 'package:architecture_test_business/architecture_test_business.dart';

class HotelDetailsView extends StatefulWidget {
  const HotelDetailsView({Key? key, required this.hotelPreview}) : super(key: key);

  final HotelPreview hotelPreview;

  @override
  _HotelDetailsViewState createState() => _HotelDetailsViewState();
}

class _HotelDetailsViewState extends State<HotelDetailsView> {
  var dio = Dio();
  Future<Hotel>? _hotelData;

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    getHotelData();
  }

  void getHotelData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await dio.get('https://run.mocky.io/v3/${widget.hotelPreview.uuid}');
      setState(() {
        _hotelData = Hotel.parseHotel(response.data);
      });
    } on DioError catch (e) {
      setState(() {
        errorMessage = e.response?.data["message"] ?? e.error.toString();
        hasError = true;
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Hotel _currentHotel;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotelPreview.name),
      ),
      body: SafeArea(
        child: hasError
            ? Center(
                child: Text(errorMessage),
              )
            : FutureBuilder<Hotel>(
                future: _hotelData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center();
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        _currentHotel = snapshot.data;
                        return SingleChildScrollView(
                            child: Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: false,
                              ),
                              items: _currentHotel.photos!
                                  .map((item) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Center(
                                          child: FadeInImage(
                                            placeholder:
                                                const AssetImage("assets/images/loading2.gif"),
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
                                  DescriptionText(
                                      label: "Страна", text: _currentHotel.address?.country),
                                  DescriptionText(
                                      label: "Город", text: _currentHotel.address?.city),
                                  DescriptionText(
                                      label: "Улица", text: _currentHotel.address?.street),
                                  DescriptionText(
                                      label: "Рейтинг", text: _currentHotel.rating.toString()),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                                    child: const Text("Сервисы",
                                        textAlign: TextAlign.left,
                                        style:
                                            TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
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
                                              if (_currentHotel.services?.paid != null)
                                                ..._currentHotel.services!.paid!
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
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 20)),
                                                  const SizedBox(height: 10),
                                                  if (_currentHotel.services?.free != null)
                                                    ..._currentHotel.services!.free!
                                                        .map((e) => Text(e.toString()))
                                                        .toList()
                                                ],
                                              ))),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ));
                      }
                    default:
                      return const SingleChildScrollView(
                        child: Text('Default'),
                      );
                  }
                },
              ),
      ),
    );
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
