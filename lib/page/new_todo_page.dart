import 'package:flutter/material.dart';

AlertDialog newTodoDialog(Color color, Function(String) addCallback){
  TextEditingController contentController = TextEditingController();
  return AlertDialog(
    content: Row(
      children: [
        Expanded(child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: color)
            ),
            labelText: 'Item',
            hintText: 'Item',
            contentPadding: EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 5),
          ),
          controller: contentController,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
        ))
      ],
    ),
    actions: [
      ButtonTheme(child: TextButton(
        onPressed: (){
          addCallback(contentController.text);
        },
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(3),
          backgroundColor: MaterialStatePropertyAll(color),
          foregroundColor: const MaterialStatePropertyAll(Color(0xFFFFFFFF))
        ),
        child: const Text('Add'),
      ))
    ],
  );
}