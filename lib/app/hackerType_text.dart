import 'package:flutter/material.dart';

import 'hackerTyper/animation/text_animation.dart';
import 'hackerTyper/widget/dialog.dart';

class HackerTyper extends StatefulWidget {
  @override
  HackerTyperState createState() => new HackerTyperState();
}

class HackerTyperState extends State<HackerTyper>
    with SingleTickerProviderStateMixin {
  bool showTextInput = false;
  bool hideTextInput = false;
  double _top = 10;
  String inputName = "";
  AnimationController animatedTextController;
  Animation<int> stringCount;

  static const String CODE =
      """struct group_info init_groups = { .usage = ATOMIC_INIT(2) };

struct group_info *groups_alloc(int gidsetsize){

	struct group_info *group_info;

	int nblocks;
	int i;

	nblocks = (gidsetsize + NGROUPS_PER_BLOCK - 1) / NGROUPS_PER_BLOCK;

	/* Make sure we always allocate at least one indirect block pointer */

	nblocks = nblocks ? : 1;

	group_info = kmalloc(sizeof(*group_info) + nblocks*sizeof(gid_t *), GFP_USER);

	if (!group_info)
		return NULL;

	group_info->ngroups = gidsetsize;

	group_info->nblocks = nblocks;""";
  @override
  void initState() {
    super.initState();
    animatedTextController = new AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    stringCount = StepTween(begin: 0, end: CODE.length).animate(CurvedAnimation(
      parent: animatedTextController,
      curve: Curves.easeIn,
    ))
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          Dialogs()..getDialogs(context);
        }
      })
      ..addListener(() {
        setState(() {});
      });
    animatedTextController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            stringCount == null
                ? null
                : getAnimatedCrossFade(
                    showTextInput, stringCount, CODE, hideTextInput),
            getAnimatedText(_top, hideTextInput, inputName),
          ],
        ),
      ),
    );
  }
}
