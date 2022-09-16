import 'package:bright_fit/models/glossary_radio_model.dart';
import 'package:bright_fit/views/glossary_list.dart';
import 'package:bright_fit/widgets/glossary_radio_widget.dart';
import 'package:flutter/material.dart';

///Shows various muscle groups that the user can see exercises for
class Glossary extends StatefulWidget {
  @override
  _GlossaryState createState() => _GlossaryState();
}

class _GlossaryState extends State<Glossary> {
  static List<GlossaryRadioModel> models = [
    GlossaryRadioModel('UPPER BACK', Colors.yellow),
    GlossaryRadioModel('SHOULDERS', Colors.green),
    GlossaryRadioModel('CHEST', Colors.deepOrangeAccent.shade200),
    GlossaryRadioModel('UPPER ARMS', Colors.blueAccent),
    GlossaryRadioModel('FOREARMS', Colors.cyan.shade300),
    GlossaryRadioModel('CORE', Colors.pink.shade200),
    GlossaryRadioModel('LOWER BACK', Colors.grey.shade800),
    GlossaryRadioModel('UPPER LEG', Colors.red),
    GlossaryRadioModel('GLUTES', Colors.teal.shade300),
    GlossaryRadioModel('LOWER LEG', Colors.deepPurpleAccent.shade100),
  ];
  GlossaryRadioModel selectedModel =
      GlossaryRadioModel('', Colors.grey.shade300);

  @override
  void initState() {
    super.initState();
    for (GlossaryRadioModel m in models) if (m.isSelected) selectedModel = m;
  }

  @override
  Widget build(BuildContext context) {
    ///Choose which picture to show, based on what's selected
    String asset;
    switch (selectedModel.title) {
      case "UPPER BACK":
        asset = 'assets/images/glossaryGuy/Upper Back.jpg';
        break;
      case "SHOULDERS":
        asset = 'assets/images/glossaryGuy/Shoulders.jpg';
        break;
      case "CHEST":
        asset = 'assets/images/glossaryGuy/Chest.jpg';
        break;
      case "UPPER ARMS":
        asset = 'assets/images/glossaryGuy/Upper Arm.jpg';
        break;
      case "FOREARMS":
        asset = 'assets/images/glossaryGuy/Forearm.jpg';
        break;
      case "CORE":
        asset = 'assets/images/glossaryGuy/Core.jpg';
        break;
      case "LOWER BACK":
        asset = 'assets/images/glossaryGuy/Lower Back.jpg';
        break;
      case "UPPER LEG":
        asset = 'assets/images/glossaryGuy/Upper Leg.jpg';
        break;
      case "GLUTES":
        asset = 'assets/images/glossaryGuy/Glutes.jpg';
        break;
      case "LOWER LEG":
        asset = 'assets/images/glossaryGuy/Lower Leg.jpg';
        break;
      default:
        asset = 'assets/images/glossaryGuy/Full Grey.jpg';
        break;
    }
    double padding = 8.0;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(padding),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('UPPER BODY',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  glossaryButtons(models[0]),
                  glossaryButtons(models[1]),
                  glossaryButtons(models[2]),
                  glossaryButtons(models[3]),
                  glossaryButtons(models[4]),
                  glossaryButtons(models[5]),
                  glossaryButtons(models[6]),
                  Text('LOWER BODY',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  glossaryButtons(models[7]),
                  glossaryButtons(models[8]),
                  glossaryButtons(models[9]),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 2 - padding,
                  child: Image.asset(asset, fit: BoxFit.fitWidth))
            ],
          ),
          ElevatedButton(
            onPressed: selectedModel == null
                ? null
                : () {
                    print(selectedModel.title);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            GlossaryList(selectedModel.title)));
                  },
            style: ButtonStyle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  selectedModel == null
                      ? "EXERCISES"
                      : '${selectedModel.title} EXERCISES',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  InkWell glossaryButtons(GlossaryRadioModel model) {
    return InkWell(
      onTap: () {
        setState(() {
          for (GlossaryRadioModel m in models) m.isSelected = false;
          model.isSelected = true;
          selectedModel = model;
        });
      },
      child: GlossaryRadioWidget(model),
    );
  }
}
