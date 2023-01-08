import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/modules/details.dart';
import 'package:noteapp/modules/edit.dart';

Widget textFormFiled(
    {String? hint,
    required IconData icon,
    String? helper,
    bool obscure = false,
    int maxLines = 1,
    String? initial,
    required TextEditingController controller,
    required String? Function(String?) validator}) {
  return TextFormField(
    initialValue: initial,
    keyboardType: TextInputType.emailAddress,
    maxLines: maxLines,
    cursorColor: Colors.white,
    obscureText: obscure,
    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      helperText: helper,
      helperStyle: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[300]),
      prefixIcon: Icon(icon, color: Colors.white),
    ),
  );
}

Widget button({required String text, required Function() function}) {
  return MaterialButton(
    onPressed: function,
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

void navigator({required BuildContext context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget listTile(
    {required String text,
    required String body,
    required String image,
    required String doc,
    required BuildContext context,
    required Map<String, dynamic> notes}) {
  return ListTile(
    onTap: () {
      navigator(
          context: context,
          widget: Details(text: text, body: body, image: image));
    },
    leading: image != ""
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          )
        : null,
    title: Column(
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
    trailing: IconButton(
        color: Colors.white,
        onPressed: () {
          navigator(context: context, widget: Edit(doc: doc, notes: notes));
        },
        icon: const Icon(Icons.edit)),
  );
}
