import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/Templates/Templates.dart';
import 'package:flutter_v1/constants/constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage(
      {Key? key,
      this.city = '*',
      this.area = '',
      this.costPerPerson = 0,
      this.gaming = '',
      this.relax = '',
      this.tourism = ''})
      : super(key: key);

  final String city, area, relax, gaming, tourism;
  final double costPerPerson;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<PlaceWidget> _dash1 = [];
  List<PlaceWidget> _dash2 = [];

  var _query = placesref
      .where(
        'city',
        isEqualTo: '',
      )
      .where('status', isEqualTo: 'accepted');

  var _stream = placesref
      .where(
        'city',
        isEqualTo: '',
      )
      .where('status', isEqualTo: 'accepted')
      .snapshots();

  getData() async {
    String city = AuthServices.signedInUser.city;
    setState(
      () {
        if (widget.city == '*') {
          _query = placesref.where('city', isEqualTo: city);
        } else if (widget.city.isNotEmpty) {
          _query = placesref.where('city', isEqualTo: widget.city);
        }
        if (widget.city.isEmpty) _query = placesref;
        if (widget.area.isNotEmpty) {
          _query = _query.where('area', isEqualTo: widget.area);
        }
        if (widget.gaming.isNotEmpty ||
            widget.relax.isNotEmpty ||
            widget.tourism.isNotEmpty) {
          _query = _query.where(
            'category',
            whereIn: [widget.tourism, widget.relax, widget.gaming],
          );
        }
        if (widget.costPerPerson != 0) {
          _query = _query.where('cost per person',
              isLessThanOrEqualTo: widget.costPerPerson);
        }
        _stream = _query.where('status', isEqualTo: 'accepted').snapshots();
      },
    );
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }

        _dash1 = [];
        _dash2 = [];

        for (var doc in snapshot.data!.docs) {
          if (_dash1.length <= _dash2.length) {
            if (_dash1.length % 2 == 0) {
              _dash1.add(
                PlaceWidget(currentPlaceID: doc.id, height: 230),
              );
            } else {
              _dash1.add(
                PlaceWidget(currentPlaceID: doc.id),
              );
            }
          } else {
            if (_dash2.length % 2 == 1) {
              _dash2.add(
                PlaceWidget(currentPlaceID: doc.id, height: 230),
              );
            } else {
              _dash2.add(
                PlaceWidget(currentPlaceID: doc.id),
              );
            }
          }
        }

        _dash1.shuffle();
        _dash2.shuffle();

        return DashboardTemplate(
          backgroundImagePath: 'image/waterfall-wallpaper.jpg',
          pageTittle: 'Dashboard',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: _dash1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: _dash2,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
