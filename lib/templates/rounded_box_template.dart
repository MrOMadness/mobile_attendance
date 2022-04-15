import 'package:flutter/material.dart';

import '../styles.dart';

// Template for rounded box
class RoundedBoxTemplate extends StatelessWidget {
  final String title;
  final String data;

  const RoundedBoxTemplate(this.title, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: const Color(Styles.lightBlue),
              border: Border.all(
                color: const Color(Styles.lightBlue),
              ),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: Styles.black_16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        data,
                        style: Styles.grey_13,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )),
    );
  }
}
