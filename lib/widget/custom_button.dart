import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String title;
  final VoidCallback? onTap;
  const CustomButton(this.title,{this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.54),
              offset: const Offset(2, 2),
              spreadRadius: 0
            )
          ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
          color: Theme.of(context).colorScheme.primary,
        ),
        alignment: Alignment.center,
        child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge,),
      ),
    );
  }

}