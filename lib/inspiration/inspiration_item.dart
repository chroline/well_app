import 'package:flutter/material.dart';

class InspirationItem extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onLoadMore;

  InspirationItem(
      {Key? key,
      required this.title,
      required this.child,
      required this.onLoadMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black.withOpacity(0.075),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        elevation: 0,
        child: InkWell(
          onTap: () {},
          overlayColor:
              MaterialStateProperty.all(Colors.black.withOpacity(0.01)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, bottom: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                child,
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onLoadMore,
                      style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.padded,
                          padding: const EdgeInsets.all(8)),
                      child: const Text('LOAD NEW'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
