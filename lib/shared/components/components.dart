import 'package:flutter/material.dart';
Widget builtDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    color: Colors.grey,
    height: 1.0,
    width: double.infinity,
  ),
);
Widget tFF({
  required TextEditingController controller,
  required TextInputType keyboard,
  required var valid,
  required String label,
  required IconData prefix,
  //IconData? suffix,
  bool show = true,
  var tap,
  var onchange,
  var onSubmit,
  var suffix,
  var suffixPress,
}) =>
    TextFormField(
      validator: valid,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(icon: Icon(suffix), onPressed: suffixPress)
            : null,
      ),
      keyboardType: keyboard,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      obscureText: show,
      onTap: tap,
    );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
      context,MaterialPageRoute(builder: (context) => widget
    ),
          (Route<dynamic>route)=> false,
    );


PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>AppBar(
  titleSpacing: 5.0,
    leading: IconButton(
    onPressed:(){
      Navigator.pop(context);
    },
    icon:const Icon(Icons.arrow_circle_left_rounded),
  ),
  title:Text(
    title!,
  ),
  actions:actions,
);


Widget dB({
  double width = double.infinity,
  Color background = Colors.deepOrange,
  bool isUpper = true,
  required var function,
  required String text,
})=> Container(
  height: 40.0,
  color: background,
  width:width,
  child:
  MaterialButton(
    onPressed: function,
    child:Text(
      isUpper? text.toUpperCase() : text,
      style:const
      TextStyle(
        color:Colors.white,
      ),
    ),
  ),
);

Widget tB({required String text, required var function,})=>
    TextButton(
      onPressed:function,
      child:Text(text.toUpperCase()),
    );