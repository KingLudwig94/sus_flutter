import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String description;
  final Function(String?) callback;
  final Function(String?)? callbackChanged;
  final String? unit;
  final String? Function(String?)? validator;
  final String? initial;

  final BoxConstraints? constraints;
  final int? maxlength;

  const InputField({
    Key? key,
    required this.description,
    required this.callback,
    this.callbackChanged,
    this.constraints,
    this.initial,
    this.unit,
    this.maxlength,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(description), //.tr(),
          Container(
            constraints: constraints ?? BoxConstraints.tightFor(width: MediaQuery.of(context).size.width/4),
            padding: EdgeInsets.only(left: 16),
            child: TextFormField(
              decoration: unit != null
                  ? InputDecoration(
                      isDense: true,
                      suffixText: unit,
                    )
                  : null,
              style: TextStyle(height: 1),
              textAlign: TextAlign.center,
              onSaved: callback,
              initialValue: initial,
              maxLength: maxlength,
              onChanged: callbackChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
