import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v1/EditPlace.dart';
import 'package:flutter_v1/MenuDrawerPage.dart';
import 'package:flutter_v1/PlaceMainPage.dart';
import 'package:flutter_v1/Services/AuthServices.dart';
import 'package:flutter_v1/constants/constants.dart';
import 'package:flutter_v1/models/PlaceModel.dart';

class LinearColoredButton extends StatefulWidget {
  const LinearColoredButton({this.buttonTittle = 'Button', Key? key})
      : super(key: key);
  final String buttonTittle;
  @override
  _LinearColoredButtonState createState() => _LinearColoredButtonState();
}

class _LinearColoredButtonState extends State<LinearColoredButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      borderRadius: const BorderRadius.all(
        Radius.circular(90),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(90),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff02ECB9),
              Color(0xff0C89C3)
            ], // red to yellow
            tileMode: TileMode.repeated,
          ),
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.buttonTittle,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SignInPageTemplate extends StatefulWidget {
  const SignInPageTemplate(
      {this.canGoBack = true,
      this.pageTittle = 'Tittle',
      required this.child,
      Key? key})
      : super(key: key);

  final String pageTittle;
  final bool canGoBack;
  final Widget child;

  @override
  _SignInPageTemplateState createState() => _SignInPageTemplateState();
}

class _SignInPageTemplateState extends State<SignInPageTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 4,
              shadowColor: Colors.grey,
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(130)),
              child: Container(
                height: 239,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(130)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xff02ECB9),
                        Color(0xff0C89C3)
                      ], // red to yellow
                      tileMode: TileMode.repeated,
                    )),
                child: Column(
                  children: [
                    widget.canGoBack
                        ? Expanded(
                            flex: 1,
                            child: Align(
                              child: GestureDetector(
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 28,
                              width: 28,
                            ),
                          ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Image.asset(
                          'image/logo.png',
                          height: 90,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.pageTittle,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          alignment: Alignment.centerRight),
                    ),
                  ],
                ),
              ),
            ),
            widget.child
          ],
        ),
      ),
    );
  }
}

class BuildTextField extends StatefulWidget {
  const BuildTextField(
      {this.prefixIcon = Icons.edit,
      this.hint = 'hint',
      required this.onChanged,
      Key? key})
      : super(key: key);

  final IconData prefixIcon;
  final String hint;
  final Function onChanged;

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.grey,
      borderRadius: const BorderRadius.all(
        Radius.circular(90),
      ),
      child: TextField(
        onChanged: (String val) {
          widget.onChanged(val);
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(90),
            ),
            borderSide: BorderSide(
              color: Color(0x0000ffff),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
            borderSide: const BorderSide(color: Color(0x0000ffff), width: 3.0),
          ),
          hintText: widget.hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              widget.prefixIcon,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class BuildPasswordTextField extends StatefulWidget {
  const BuildPasswordTextField({required this.onChanged, Key? key})
      : super(key: key);

  final Function onChanged;

  @override
  _BuildPasswordTextFieldState createState() => _BuildPasswordTextFieldState();
}

class _BuildPasswordTextFieldState extends State<BuildPasswordTextField> {
  Color suffixIconColor = Colors.grey;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Colors.grey,
      borderRadius: const BorderRadius.all(
        Radius.circular(90),
      ),
      child: TextField(
        onChanged: (String val) {
          widget.onChanged(val);
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(90),
            ),
            borderSide: BorderSide(
              color: Color(0x0000ffff),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
            borderSide: const BorderSide(color: Color(0x0000ffff), width: 3.0),
          ),
          hintText: 'Password',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.lock,
              size: 30,
              color: Colors.grey,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(
                () {
                  if (suffixIconColor == Colors.grey) {
                    suffixIconColor = Colors.blue;
                    obscureText = false;
                  } else {
                    suffixIconColor = Colors.grey;
                    obscureText = true;
                  }
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.visibility,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardTemplate extends StatefulWidget {
  const DashboardTemplate(
      {this.linearTopColor = const Color(0xb8E1D0C1),
      this.linearBottomColor = const Color(0xb83AAEC2),
      required this.backgroundImagePath,
      this.pageTittle = 'Tittle',
      required this.child,
      Key? key})
      : super(key: key);

  final Color linearTopColor;
  final Color linearBottomColor;
  final String backgroundImagePath;
  final String pageTittle;
  final Widget child;

  @override
  _DashboardTemplateState createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MenuDrawerPage(),
        body: Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xb802ECB9),
                          Color(0xb80C89C3)
                        ], // red to yellow
                        tileMode: TileMode.repeated,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.pageTittle,
                              style: const TextStyle(
                                  fontSize: 27, color: Colors.white),
                            ),
                          ),
                          Container(
                            width: 30,
                          )
                        ],
                      ),
                    ),
                    height: 100,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[
                            widget.linearTopColor,
                            widget.linearBottomColor,
                          ], // red to yellow
                          tileMode: TileMode.repeated,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16),
                        child: SingleChildScrollView(child: widget.child),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({required this.onToggleCallback, Key? key})
      : super(key: key);
  final ValueChanged onToggleCallback;

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  final List<String> values = const ['Owner', 'User'];
  bool _toggle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(45),
        ),
      ),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _toggle = !_toggle;
              var index = 0;
              if (!_toggle) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: 300,
              height: 40,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  values.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Text(
                      values[index],
                      style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9e9e9e),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: _toggle ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 300 * 0.5,
              height: 40,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xff02ECB9),
                    Color(0xff0C89C3)
                  ], // red to yellow
                  tileMode: TileMode.repeated,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  _toggle ? values[0] : values[1],
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceWidget extends StatefulWidget {
  const PlaceWidget({Key? key, this.currentPlaceID = '', this.height = 190})
      : super(key: key);
  final String currentPlaceID;
  final double height;

  @override
  _PlaceWidgetState createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {

  bool isFavorite() {
    for (var placeId in AuthServices.signedInUser.favoritePlacesIds) {
      if (placeId == widget.currentPlaceID) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesref.doc(widget.currentPlaceID).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        try {
          PlaceModel placeModel = PlaceModel.fromDoc(snapshot.data);
          return Padding(
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
                            child: AuthServices.signedInUser.userType == 'user'
                                ? PlaceMainPage(
                                    currentplaceID: widget.currentPlaceID,
                                  )
                                : EditPlace(
                                    placeModel.costPerPerson,
                                    currentPlaceID: widget.currentPlaceID,
                                  ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(placeModel.placePicURl),
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.85), BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AuthServices.signedInUser.userType == 'user'
                              ? GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        if (isFavorite()) {
                                          usersref
                                              .doc(AuthServices.signedInUser.id)
                                              .update(
                                            {
                                              'favoriteplaces':
                                                  FieldValue.arrayRemove(
                                                      [widget.currentPlaceID])
                                            },
                                          );
                                          AuthServices
                                              .signedInUser.favoritePlacesIds
                                              .remove(widget.currentPlaceID);
                                        } else {
                                          usersref
                                              .doc(AuthServices.signedInUser.id)
                                              .update(
                                            {
                                              'favoriteplaces':
                                                  FieldValue.arrayUnion(
                                                      [widget.currentPlaceID])
                                            },
                                          );
                                          AuthServices
                                              .signedInUser.favoritePlacesIds
                                              .add(widget.currentPlaceID);
                                        }
                                      },
                                    );
                                  },
                                  child: Icon(
                                    isFavorite()
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              placeModel.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  placeModel.city + ' , ' + placeModel.area,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } catch (e) {
          return Container();
        }
      },
    );
  }
}

class CategoryWidget extends StatefulWidget {
  CategoryWidget(this.imagepath, this.fun);
  String imagepath;
  Function fun;
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Color backcolor = const Color(0x55ffffff);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          setState(
            () {
              backcolor = backcolor == const Color(0x55ffffff)
                  ? const Color(0xb83AAEC2)
                  : const Color(0x55ffffff);
              widget.fun();
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: backcolor,
            image: DecorationImage(
                image: AssetImage(widget.imagepath), fit: BoxFit.cover),
          ),
          height: 90,
          width: 90,
        ),
      ),
    );
  }
}

class Categoryaddplace extends StatefulWidget {
  Categoryaddplace(this.imagepath, this.backcolor);
  String imagepath;
  Color backcolor;

  @override
  _CategoryaddplaceState createState() => _CategoryaddplaceState();
}

class _CategoryaddplaceState extends State<Categoryaddplace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: widget.backcolor,
          image: DecorationImage(
              image: AssetImage(widget.imagepath), fit: BoxFit.cover),
        ),
        height: 90,
        width: 90,
      ),
    );
  }
}

class Dropdownbox extends StatefulWidget {
  Dropdownbox(this._salutations, this.hint, this.fun);

  final List<String> _salutations;
  Function fun;
  String hint;

  @override
  _DropdownboxState createState() => _DropdownboxState();
}

class _DropdownboxState extends State<Dropdownbox> {
  var salutation;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0x33ffffff),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: DropdownButton(
          underline: Container(
            height: 0,
          ),
          icon: const Icon(Icons.keyboard_arrow_down),

          iconSize: 30,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          isExpanded: true,
          //menuMaxHeight: 200,
          dropdownColor: const Color(0xb83AAEC2),
          iconEnabledColor: Colors.white,
          hint: Text(
            widget.hint,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          items: widget._salutations
              .map(
                (String item) =>
                    DropdownMenuItem<String>(child: Text(item), value: item),
              )
              .toList(),
          onChanged: (val) {
            setState(
              () {
                salutation = val;
                widget.fun(val);
              },
            );
          },
          value: salutation,
        ),
      ),
    );
  }
}

class ImageContainerStackTemplate extends StatelessWidget {
  ImageContainerStackTemplate(
      this.imagepath, this.imagechild, this.containerchild);
  ImageProvider imagepath;
  Widget imagechild;
  Widget containerchild;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 390,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image/default.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Container(),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
                height: 390,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagepath,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: imagechild),
          ),
          Positioned(
            top: 235,
            bottom: 0,
            child: Container(
              height: mq.size.height - 300,
              width: mq.size.width + 0.3,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xff02ECB9),
                    Color(0xff0C89C3)
                  ], // red to yellow
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(child: containerchild),
              ),
            ),
          ),
        ],
        fit: StackFit.expand,
        overflow: Overflow.visible,
      ),
    );
  }
}
