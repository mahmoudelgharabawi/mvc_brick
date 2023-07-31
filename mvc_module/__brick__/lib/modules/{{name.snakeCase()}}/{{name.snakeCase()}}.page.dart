import 'package:flutter/material.dart';

import '{{name.snakeCase()}}.controller.dart';

class {{name.pascalCase()}}Page extends {{cname.pascalCase()}}StatefulWidget<{{name.pascalCase()}}Controller> {
  const {{name.pascalCase()}}Page({{{name.pascalCase()}}Controller? controllerEx, Key? key})
      : super(controllerEx, key: key);

  @override
  State<{{name.pascalCase()}}Page> createState() => _{{name.pascalCase()}}PageState();
}



class _{{name.pascalCase()}}PageState extends {{cname.pascalCase()}}State<{{name.pascalCase()}}Page, {{name.pascalCase()}}Controller> {
  @override
  createController() {
    return  {{name.pascalCase()}}Controller();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  
}