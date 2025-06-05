import 'package:flutter/material.dart';

class DetailsPages extends StatelessWidget {

  final Map rates;

  const DetailsPages({required this.rates});

  @override
  Widget build(BuildContext context) {
    List _currencies = rates.keys.toList();
    List _excchangeRates = rates.values.toList();

    return Scaffold(
      body: SafeArea(child: ListView.builder(
        itemCount: _currencies.length,
        itemBuilder: (_context, _index){
          String _currency = _currencies[_index].toString().toUpperCase();
          String _exchangeRate = _excchangeRates[_index].toString();
          return ListTile(
            title: Text("$_currency: $_exchangeRate",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
          );
      })),
    );
    
  }
}