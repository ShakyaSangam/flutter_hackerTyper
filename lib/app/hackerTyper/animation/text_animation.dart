import 'package:flutter/material.dart';

AnimatedCrossFade getAnimatedCrossFade(
    bool showTextInput,
    Animation<int> welcomeStringCount,
    String welcomeString,
    bool hideTextInput) {
  return AnimatedCrossFade(
    duration: Duration(milliseconds: 800),
    alignment: Alignment.centerLeft,
    firstChild:
        _getTextTypewriterExplicitAnimation(welcomeStringCount, welcomeString),
    firstCurve: Curves.fastOutSlowIn,
    secondChild: _hideTextInputWidget(hideTextInput),
    secondCurve: Curves.easeIn,
    crossFadeState:
        showTextInput ? CrossFadeState.showSecond : CrossFadeState.showFirst,
  );
}

_getTextTypewriterExplicitAnimation(
    Animation<int> welcomeStringCount, String welcomeString) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      width: 250,
      margin: EdgeInsets.all(24),
      child: AnimatedBuilder(
        animation: welcomeStringCount,
        builder: (BuildContext context, Widget child) {
          String text = welcomeString.substring(0, welcomeStringCount.value);
          return Align(
            alignment: Alignment.bottomLeft,
            child: Text(text,
                style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w400)),
          );
        },
      ),
    ),
  );
}

AnimatedPositioned getAnimatedText(
    double top, bool hideTextInput, String inputName) {
  return AnimatedPositioned(
    duration: Duration(seconds: 3),
    curve: Curves.bounceOut,
    child: getAnimatedOpacityText(hideTextInput, inputName),
    top: top,
    left: 16,
  );
}

getAnimatedOpacityText(bool hideTextInput, String inputName) {
  return AnimatedOpacity(
    duration: Duration(seconds: 1),
    curve: Curves.easeIn,
    opacity: hideTextInput ? 1 : 0,
    child: InkWell(
      onTap: () {},
      child: Container(
        child: Text(
          "Hey, $inputName >",
          style: TextStyle(
              fontSize: 14, color: Colors.green, fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}

getTextInput() {
  return Padding(
    padding: EdgeInsets.all(32),
    child: Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hey, May I know your name?",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                primaryColor: Colors.white,
                accentColor: Colors.white,
                hintColor: Colors.white,
              ),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(55.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(55.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.black26,
                    )),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

_hideTextInputWidget(bool hideTextInput) {
  return AnimatedOpacity(
    duration: Duration(seconds: 1),
    curve: Curves.easeInOut,
    opacity: hideTextInput ? 0 : 1,
    child: getTextInput(),
  );
}
