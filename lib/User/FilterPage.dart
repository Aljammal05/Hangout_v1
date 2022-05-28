import 'package:flutter/material.dart';
import 'package:flutter_v1/User/DashboardPage.dart';
import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/lists/Lists.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Templates/DashboardTemplate.dart';
import '../Widgets/CategoryFilterButton.dart';
import '../Widgets/DropDownBox.dart';
import '../Widgets/LinearColoredButton.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _costPerPerson = 0;
  int _countOfPerson = 1;
  String _city = '', _area = '', _relax = '', _gaming = '', _tourism = '';

  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      pageTittle: 'Filter',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: DropDownBox(
                values: const ['Amman', 'Zarqa', 'Aqaba', 'Irbid'],
                hint: 'Select your City',
                onSelect: (val) {
                  setState(
                    () {
                      _city = val;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DropDownBox(
                values: selectedCity(_city),
                hint: 'Select your Area',
                onSelect: (val) {
                  _area = val;
                },
              ),
            ),
            const SizedBox(
              height: 30,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryFilterButton(
                  imagePath: 'image/gaming-category.png',
                  onTap: () {
                    _gaming = _gaming.isEmpty ? 'gaming' : '';
                  },
                ),
                CategoryFilterButton(
                  imagePath: 'image/tourism-category.png',
                  onTap: () {
                    _tourism = _tourism.isEmpty ? 'tourism' : '';
                  },
                ),
                CategoryFilterButton(
                  imagePath: 'image/relax-category.png',
                  onTap: () {
                    _relax = _relax.isEmpty ? 'relax' : '';
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Num of persons : ',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Text(
                      '$_countOfPerson',
                      style: const TextStyle(color: Colors.white, fontSize: 37),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                        child: FloatingActionButton(
                          heroTag: 'h1',
                          child: const Icon(Icons.add),
                          backgroundColor: secondaryColorHalfOpacity,
                          onPressed: () {
                            setState(
                              () {
                                _countOfPerson = _countOfPerson >= 25
                                    ? _countOfPerson
                                    : ++_countOfPerson;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: FloatingActionButton(
                          heroTag: 'h2',
                          child: const Icon(
                            FontAwesomeIcons.minus,
                            size: 14,
                          ),
                          backgroundColor: secondaryColorHalfOpacity,
                          onPressed: () {
                            setState(
                              () {
                                _countOfPerson = _countOfPerson <= 1
                                    ? _countOfPerson
                                    : --_countOfPerson;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Row(
                children: [
                  const Text(
                    'Total budget :  ',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Text(
                    _costPerPerson.round().toString(),
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  const Text(
                    ' JD',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Slider(
              value: _costPerPerson,
              min: 0,
              max: 150,
              divisions: 30,
              activeColor: secondaryColor,
              inactiveColor: const Color(0xffffffff),
              onChanged: (newValue) {
                setState(
                  () {
                    _costPerPerson = newValue;
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SafeArea(
                              child: DashboardPage(
                                area: _area,
                                city: _city,
                                gaming: _gaming,
                                relax: _relax,
                                tourism: _tourism,
                                costPerPerson: _costPerPerson != 0
                                    ? _costPerPerson / _countOfPerson
                                    : 0,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: const LinearColoredButton(
                  buttonTittle: 'SEARCH',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> selectedCity(String s) {
    switch (s) {
      case 'Amman':
        return amman;
      case 'Zarqa':
        return zarqa;
      case 'Irbid':
        return irbid;
      case 'Aqaba':
        return aqaba;
      default:
        return ['please select city'];
    }
  }
}
