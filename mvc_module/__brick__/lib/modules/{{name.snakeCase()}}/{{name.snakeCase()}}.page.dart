import 'package:flutter/material.dart';
import 'package:tecfy_basic_package/tecfy_basic_package.dart';

import '{{name.snakeCase()}}.controller.dart';

class {{name.pascalCase()}}Page extends TecfyStatefulWidget<{{name.pascalCase()}}Controller> {
  const {{name.pascalCase()}}Page({{{name.pascalCase()}}Controller? controllerEx, Key? key})
      : super(controllerEx, key: key);

  @override
  State<{{name.pascalCase()}}Page> createState() => _{{name.pascalCase()}}PageState();
}



class _{{name.pascalCase()}}PageState extends TecfyState<{{name.pascalCase()}}Page, {{name.pascalCase()}}Controller> {
  @override
  createController() {
    return  {{name.pascalCase()}}Controller();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  
}