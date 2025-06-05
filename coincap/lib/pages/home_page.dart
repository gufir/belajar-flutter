import 'dart:convert';

import 'package:coincap/pages/detail_pages.dart';
import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomepageState();

}


class _HomepageState extends State<HomePage> {

  double? _deviceHeight, _deviceWidth;
  String? _selectedCoin = "bitcoin";
  HttpServices? _http;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HttpServices>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            _selectedCoinDropdown(),
            _dataWidget(),
          ],
          ),
        ),
    ));
  }

  Widget _selectedCoinDropdown() {
    List<String> _coins = [
      "bitcoin", 
      "ethereum", 
      "ripple", 
      "dogecoin", 
      "litecoin"
    ];

    List<DropdownMenuItem<String>> _items = _coins.map((e) => DropdownMenuItem(
      value: e, 
      child: Text(e, 
        style: TextStyle(
          color: Colors.white, 
          fontSize: 40, 
          fontWeight: FontWeight.w600),
      ),
    ),).toList();
    return DropdownButton(
      value: _selectedCoin,
      items: _items, 
      onChanged: (dynamic _value) {
        setState(() {
          _selectedCoin = _value;
        });
      },
      dropdownColor: const Color.fromRGBO(83, 83, 206, 1.0),
      iconSize: 30,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 30,),
      underline: Container(),
    );
  }


  Widget _dataWidget() {
    
    return FutureBuilder(
      future: _http!.get("/coins/$_selectedCoin"), 
      builder: (BuildContext _context, AsyncSnapshot _snapshot){
        if (_snapshot.hasData) {
          Map _data = jsonDecode(_snapshot.data.toString());
          num _usdPrice = _data["market_data"]["current_price"]["usd"];
          num _percentageChange = _data["market_data"]["price_change_percentage_24h"];
          Map _excchangeRates = _data["market_data"]["current_price"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext _context){
                        return DetailsPages(rates: _excchangeRates,); // Assuming you have a DetailPages widget
                    },
                  ),
                  );
                },
                child: _coinImageWidget(_data["image"]["large"]),
              ),
              _currentPriceWidget(_usdPrice),
              _percetageChangeWidget(_percentageChange),
              _descriptionCardWidget(_data["description"]["en"] ?? "No description available."),
            ],
          );
        } else {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        }
      }
    );
  }

  Widget _currentPriceWidget(num _price) {
    return Text("${_price.toStringAsFixed(2)} USD",
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w300
      ),
    );
  }

  Widget _percetageChangeWidget(num _percentage) {
    return Text("${_percentage.toString()} %",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300
      ),
    );
  }

  Widget _coinImageWidget(String _imgURL){
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.02,
      ),
      height: _deviceHeight! * 0.2,
      width: _deviceWidth! * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imgURL)
        )
      ),
    );
  }

  Widget _descriptionCardWidget(String _description) {
    return Container(
      height: _deviceHeight! * 0.2,
      width: _deviceWidth! * 0.8,
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.01,
        horizontal: _deviceWidth! * 0.01,
      ),
      color: const Color.fromRGBO(83, 83, 206, 0.5),
      child: Text(
        _description, 
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}