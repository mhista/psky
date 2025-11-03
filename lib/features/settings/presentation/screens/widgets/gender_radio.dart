
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:flutter/material.dart';

class GenderRadioGroup extends StatefulWidget {
  final Function(String?) onChanged;
  final String? initialValue;

  const GenderRadioGroup({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<GenderRadioGroup> createState() => _GenderRadioGroupState();
}

class _GenderRadioGroupState extends State<GenderRadioGroup> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ResponsiveText('Gender').withSize(9),
          RadioGroup<String>(
            groupValue: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value;
                widget.onChanged(value);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'male';
                        widget.onChanged(selectedGender);
                      });
                    },
                    child: Row(
                      children: [
                        const Radio<String>(value: 'male'),
                        const ResponsiveText('Male').withSize(9)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'female';
                        widget.onChanged(selectedGender);
                      });
                    },
                    child: Row(
                      children: [
                        const Radio<String>(value: 'female'),
                        const ResponsiveText('Female').withSize(9),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
