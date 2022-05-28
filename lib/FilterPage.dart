import 'package:flutter/material.dart';
import 'package:flutter_v1/DashboardPage.dart';
import 'package:flutter_v1/Templates/Templates.dart';
import 'package:flutter_v1/lists/Lists.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      backgroundImagePath: 'image/petra.jpg',
      pageTittle: 'Filter',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Dropdownbox(
                const ['Amman', 'Zarqa', 'Aqaba', 'Irbid'],
                'Select your City',
                (val) {
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
              child: Dropdownbox(
                selectedCity(_city),
                'Select your Area',
                (val) {
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
                CategoryWidget(
                  'image/gaming-category.png',
                  () {
                    _gaming = _gaming.isEmpty ? 'gaming' : '';
                  },
                ),
                CategoryWidget(
                  'image/tourism-category.png',
                  () {
                    _tourism = _tourism.isEmpty ? 'tourism' : '';
                  },
                ),
                CategoryWidget(
                  'image/relax-category.png',
                  () {
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
                          backgroundColor: const Color(0xb83AAEC2),
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
                          backgroundColor: const Color(0xb83AAEC2),
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
              activeColor: const Color(0xff3AAEC2),
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
