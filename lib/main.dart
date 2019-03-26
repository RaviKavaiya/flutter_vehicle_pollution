import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flare_flutter/flare_actor.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'CO2',
        home: Home(),
      );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _k = GlobalKey<FormState>();
  final fuel = {"Diesel": 2640, "Petrol": 2392, "CNG": 2252, "LPG": 1665};
  static final fix = (n, x) => n.toStringAsFixed(x);

  List<DropdownMenuItem> types;
  String type, unit = "litre", res;
  double dst, mlg, max = 4.8816, prsn;
  Widget ic;
  var anim = ['success', 'error'];

  @override
  initState() {
    super.initState();
    setState(() {
      types = fuel.keys
          .map((String s) => DropdownMenuItem(
                value: s,
                child: Text(s),
              ))
          .toList();

      type = fuel.keys.first;
      reset();
    });
  }

  reset() {
    setState(() {
      res = "Calculate";
      ic = Icon(Icons.done);
    });
  }

  svFuel(dynamic s) {
    setState(() {
      type = s;
      if (s.toString() == "CNG")
        unit = "kg";
      else
        unit = "litre";
    });
  }

  svDst(dynamic s) {
    setState(() {
      dst = double.parse(s);
    });
  }

  svMlg(dynamic s) {
    setState(() {
      mlg = double.parse(s);
    });
  }

  svPrsn(dynamic s) {
    setState(() {
      prsn = double.parse(s);
    });
  }

  calc() {
    FormState state = _k.currentState;
    if (_k.currentState.validate()) {
      state.save();

      if (dst > 0 && mlg > 0 && prsn > 0)
        setState(() {
          var emt = ((((dst / mlg) * fuel[type]) / 1000000) / prsn);

          res = "${fix(((((emt * 100) / max) - 100).abs()), 2)}% " +
              (emt < max ? "less" : "more") +
              " (${fix(emt, 3)} tons)";

          ic = flr(anim[emt < max ? 0 : 1]);
        });
      else
        reset();
    }
  }

  choice(vl, ch) => DropdownButtonHideUnderline(
        child: ButtonTheme(
          child: DropdownButton(
            value: vl,
            items: types,
            onChanged: ch,
          ),
        ),
      );

  txt(ln, hnt, lbl, sv) => TextFormField(
        validator: (x) {
          if (x.isEmpty) {
            reset();
            return 'I need this';
          }
        },
        decoration: InputDecoration(hintText: hnt, labelText: lbl),
        maxLength: ln,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onSaved: sv,
      );

  flr(x) => Container(
        height: 48,
        width: 48,
        child: FlareActor(
          'anim/' + x + '.flr',
          animation: x,
        ),
      );

  btn(tap, x, y, txt, sub) => RaisedButton(
      disabledColor: Colors.white,
      onPressed: tap,
      child: ListTile(
        leading: x,
        trailing: y,
        title: Text(txt),
        subtitle: Text(sub),
      ));

  spc() => Container(height: 6);

  getChildren() => <Widget>[
        choice(type, svFuel),
        txt(8, 'Kilometers', 'Driven last year', svDst),
        txt(3, 'Kilometers / $unit', 'Mileage', svMlg),
        txt(3, 'Travel on this', 'Persons', svPrsn),
        spc(),
        spc(),
        spc(),
        spc(),
        btn(null, Icon(Icons.info), null,
            "Avg. ${fix(max, 3)} ton CO2 was emitted per person", "In 2018"),
        btn(calc, null, ic, res, "Tap here"),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CO2 emission', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'img/bg.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Form(
              key: _k,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? ListView(
                            children: getChildren(),
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            children: getChildren(),
                            childAspectRatio: 5.0,
                            crossAxisSpacing: 16,
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
