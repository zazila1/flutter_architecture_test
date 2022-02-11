import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:architecture_test_business/architecture_test_business.dart';
import 'home_view_grid.dart';
import 'home_view_list.dart';

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




