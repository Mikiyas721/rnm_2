import 'package:flutter/material.dart';
import '../../data/model/location.dart';
import '../../ui/customWidgets/myText.dart';

class LocationTile extends StatelessWidget {
  final Location location;

  LocationTile({@required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black38),
        child: Icon(
          Icons.location_on,
          color: Colors.white,
        ),
      ),
      title: Text(location.name),
      subtitle: Text(location.dimension),
      trailing: IconButton(
        icon: Icon(
          Icons.remove,
        ),
        onPressed: () {},
      ),
    );
  }
}
