import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget{
  final double? fontSize;
  final String leadingTitle;
  final String trailingTitle;

  const AppBarTitle({
    super.key,
    this.fontSize = 24,
    this.leadingTitle = '',
    this.trailingTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(leadingTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: fontSize),),
        Text(trailingTitle == '' || leadingTitle == '' ? '' : ' ',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: fontSize),),
        Text(trailingTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: fontSize),),
      ],
    );
  }
}

class AppTitleWithTransition extends AppBarTitle{
  final AnimationController titleAnimController;
  const AppTitleWithTransition(this.titleAnimController, {super.fontSize, super.key});

  @override
  Widget build(BuildContext context){
    return FadeTransition(opacity: titleAnimController,child: AppBarTitle(
      fontSize: fontSize, trailingTitle: 'TodoList',
    ),);
  }
}