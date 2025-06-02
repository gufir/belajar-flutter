import 'package:flutter/material.dart';
import 'package:go_moon/widgets/custom_dropdown.dart';

class HomePage extends StatelessWidget {

  late double _deviceHeight, _deviceWidth;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: 0.05 *_deviceWidth),
        child: Stack(
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _pageTitle(),
              _bookRideWidget(),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _astroImageWidget(),
            )
          
          ],
        )
      ),) 
    );
  }

  Widget _pageTitle () {
    return const Text("#GoMoon", 
      style: TextStyle(
        fontSize: 78, 
        color: Colors.white, 
        fontWeight: FontWeight.w800
      )
    );
  }

  Widget _astroImageWidget () {
    return Container(
      height: _deviceHeight*0.50,
      width: _deviceWidth*0.70,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/astro_moon.png"),)
      )
    );
  }

  Widget _bookRideWidget () {
    return Container(
      height: _deviceHeight*0.20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _destinationDropDownWidget(),
          _travellersInformationWidget(),
          _rideButton()
        ],
      ),
    );
  }

  Widget _destinationDropDownWidget () {

    return CustomDropdownButtonClass(values: [
      'Earth Union',
      'Moon Base',
      'Mars Colony',
    ], width: _deviceWidth
    );
    
  }

  Widget _travellersInformationWidget () {
    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ 
        CustomDropdownButtonClass(
          values: const ['1', '2', '3', '4'], 
          width: 0.45* _deviceWidth),
        CustomDropdownButtonClass(
          values: const ['Economy', 'Business', 'First', 'Private'], 
          width: 0.40* _deviceWidth),
      ],
    );
  }

  Widget _rideButton() {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight*0.001),
      width: _deviceWidth,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        onPressed: () {},
        child: const Text("Book Ride", style: TextStyle(color: Colors.black),),),
    );
  }

}