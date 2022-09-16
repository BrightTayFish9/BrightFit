import 'package:bright_fit/controllers/singleton.dart';
import 'package:bright_fit/models/human_readable_categories.dart';
import 'package:bright_fit/widgets/rack_teaser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';

import 'camera_view.dart';
import 'goal_changer.dart';

class Profile extends StatefulWidget {
  Function setNavState;

  Profile(this.setNavState);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = Singleton().user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ///IMAGE
            InkWell(
              onTap: () async {
                debugPrint('camera tapped');
                WidgetsFlutterBinding.ensureInitialized();
                final cameras = await availableCameras();
                final firstCamera = cameras.first;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CameraView(
                              camera: firstCamera,
                              from: 'profile',
                            )));
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                user.avatarUrls.s96))),
                  ),
                  Opacity(
                    opacity: .9,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey.shade400),
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///TITLE
            Column(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 80,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      user.name,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Singleton().model.color),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => GoalChanger()))
                          .then((value) {
                        widget.setNavState();
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          Singleton().model.title,
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        Icon(
                          Singleton().model.icon.icon,
                          size: 40,
                          color: Colors.white,
                        ),
//                            Icon(Icons.edit)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        ///RACKS
//        RackTeaser("PHOTO JOURNAL"), //TODO: implement photo journal
        RackTeaser(HumanReadableCategories.videos),
        RackTeaser(HumanReadableCategories.quotes),
        RackTeaser(HumanReadableCategories.education),
        RackTeaser(HumanReadableCategories.recipes),
      ],
    );
  }
}
