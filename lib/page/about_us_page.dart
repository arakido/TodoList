import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:todo_list/widget/app_title.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          )
        ],
        title: const AppBarTitle(
          leadingTitle: 'About',
          trailingTitle: 'Us',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Icon(
              Icons.task,
              size: 64,
            ),
            const SizedBox(
              height: 8,
            ),
            const AppBarTitle(
              trailingTitle: 'Todopad',
              fontSize: 36,
            ),
            const AppBarTitle(
              leadingTitle: 'by',
              fontSize: 16,
            ),
            const AppBarTitle(
              leadingTitle: 'App',
              trailingTitle: 'Dexon',
              fontSize: 20,
            ),
            const SizedBox(
              height: 48,
            ),
            const Spacer(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.facebook,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.email,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    MdiIcons.github,
                    size: 32,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
