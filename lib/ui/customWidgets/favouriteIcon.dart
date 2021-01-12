import 'package:flutter/material.dart';

class TwoStateIconButton extends StatefulWidget {
  final void Function(bool isActive) onTap;
  final bool isActive;
  final Icon activeIcon;
  final Icon inActiveIcon;

  TwoStateIconButton(
      {@required this.onTap,
      @required this.isActive,
      @required this.activeIcon,
      @required this.inActiveIcon});

  @override
  State<StatefulWidget> createState() => _TwoStateIconButtonState();
}

class _TwoStateIconButtonState extends State<TwoStateIconButton> {
  bool isActive;

  @override
  void initState() {
    isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isActive = !isActive;
          widget.onTap(isActive);
        });
      },
      icon: isActive ? widget.activeIcon : widget.inActiveIcon,
    );
  }
}
