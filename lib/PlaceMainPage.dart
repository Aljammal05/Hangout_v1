import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/Templates/Templates.dart';
import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/models/PlaceModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PlaceMainPage extends StatefulWidget {
  PlaceMainPage({this.currentplaceID=''});
  String currentplaceID;
  @override
  _PlaceMainPageState createState() => _PlaceMainPageState();
}



class _PlaceMainPageState extends State<PlaceMainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesref.doc(widget.currentplaceID).get(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        };
        PlaceModel placeModel= PlaceModel.fromDoc(snapshot.data);


        return ImageContainerStackTemplate(
          NetworkImage(placeModel.placePicURl),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          placeModel.name,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(placeModel.city + ',' + placeModel.area,
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only( top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AVG Cost : ',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      placeModel.costPerPerson.round().toString() ,
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    Text(
                      ' JD',
                      style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                ' Category',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Container(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      placeModel.category == 'relax' ? 'Cafe` and Chalets' :
                      placeModel.category == 'gaming'
                          ? 'Game Centers'
                          : 'Tourism Sites',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(placeModel.category == 'relax'
                                  ? 'image/relax-category.png'
                                  :
                              placeModel.category == 'gaming'
                                  ? 'image/gaming-category.png'
                                  : 'image/tourism-category.png',),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
              Text(
                ' Description',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Container(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  placeModel.description,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'For more information : \nCall : ' + placeModel.phoneNo +
                          '\nOr visit : ' +placeModel.websiteURL,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}


