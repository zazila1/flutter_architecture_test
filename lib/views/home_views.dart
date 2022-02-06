import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:hotels/models/hotel.dart';
import 'package:hotels/router/fluro_router.dart';
import 'package:architecture_test_business/architecture_test_business.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<HotelPreview>>? _hotelPreviewData;
  bool _isListView = true;
  var dio = Dio();

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    getHotelsData();
  }

  void getHotelsData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await dio.get('https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301');
      setState(() {
        _hotelPreviewData = HotelPreview.parseHotelsPreview(response.data);
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              setState(() {
                _isListView = true;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              setState(() {
                _isListView = false;
              });
            },
          ),
        ],
        // Icon(Icons.list),
        // Icon(Icons.grid_3x3),
        // ],
      ),
      body: SafeArea(
        child: hasError
            ? Center(
                child: Text(errorMessage),
              )
            : FutureBuilder<List<HotelPreview>>(
                future: _hotelPreviewData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                          //child: Text('Введите имя файла'),
                          );
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return const Center(child: Text("Файл не найден"));
                      } else {
                        return _isListView
                            ? HomeViewList(previews: snapshot.data)
                            : HomeViewGrid(previews: snapshot.data);
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

class HomeViewList extends StatelessWidget {
  const HomeViewList({Key? key, required this.previews}) : super(key: key);
  final List<HotelPreview> previews;

  @override
  Widget build(BuildContext context) {
    bool _isBigScreen = MediaQuery.of(context).size.width > 500;

    return ListView.builder(
      itemCount: previews.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 280,
            color: Colors.grey[300],
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              elevation: 4,
              margin: const EdgeInsets.only(left: 10.0, top: 8.0, right: 10.0, bottom: 8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/images/loading2.gif"),
                        image: AssetImage('assets/images/${previews[index].poster}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                previews[index].name ?? "-",
                                style: TextStyle(
                                  fontSize: (_isBigScreen ? 16 : 10),
                                ),
                              )),
                              SizedBox(
                                width: _isBigScreen ? 100 : 80,
                                child: TextButton(
                                  child: const Text(
                                    'Подробнее',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                  onPressed: () => {
                                    AppRouter.router.navigateTo(context, Routes.hotelDetails,
                                        routeSettings: RouteSettings(arguments: previews[index]))
                                  },
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: (_isBigScreen ? 12 : 9),
                                    ),
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                    ),
                                    //
                                  ),
                                ),
                              ),
                            ],
                          )))
                ],
              ),
            ));
      },
    );
  }
}

class HomeViewGrid extends StatelessWidget {
  const HomeViewGrid({Key? key, required this.previews}) : super(key: key);
  final List<HotelPreview> previews;

  @override
  Widget build(BuildContext context) {
    bool _isBigScreen = MediaQuery.of(context).size.width > 500;
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1, crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
        itemCount: previews.length,
        itemBuilder: (BuildContext ctx, index) {
          return Card(
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: SizedBox(
                      width: double.infinity,
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/images/loading2.gif"),
                        image: AssetImage('assets/images/${previews[index].poster}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          previews[index].name ?? "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: (_isBigScreen ? 16 : 9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: const Text('Подробнее'),
                        onPressed: () => {
                          AppRouter.router.navigateTo(context, Routes.hotelDetails,
                              routeSettings: RouteSettings(arguments: previews[index]))
                        },
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0.0)),
                            ),
                            textStyle: TextStyle(
                              fontSize: (_isBigScreen ? 12 : 9),
                            )),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
