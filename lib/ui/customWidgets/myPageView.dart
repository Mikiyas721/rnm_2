import 'package:flutter/material.dart';
import '../../data/model/character.dart';
import '../../ui/customWidgets/characterCard.dart';

class MyPageView extends StatefulWidget {
  final List data;

  MyPageView({@required this.data});

  @override
  State<StatefulWidget> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int selectedPage;

  @override
  void initState() {
    selectedPage = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.data.length,
      controller: PageController(viewportFraction: 0.5, initialPage: 2),
      onPageChanged: (int index) {
        setState(() {
          selectedPage = index;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return Transform.scale(
            scale: index == selectedPage ? 1.05 : 1,
            child: CharacterCard(
              isActive: index == selectedPage ? true : false,
              character: Character.fromAPI(widget.data[index]['data']),
              isStarred: widget.data[index]['isStarred'],
            ));
      },
    );
  }
}
