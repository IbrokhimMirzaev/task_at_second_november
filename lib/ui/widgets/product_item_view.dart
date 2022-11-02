import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_at_second_november/data/models/product/product_item.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView({
    Key? key,
    required this.pr,
    required this.onSaveTap,
    required this.icon,
    required this.progress,
    required this.isVisible,
  }) : super(key: key);

  final ProductItem pr;
  final VoidCallback onSaveTap;
  final Widget icon;
  final double progress;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(1, 3),
            color: Colors.grey.shade300,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pr.name,
                    style: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${pr.price.toString()} \$",
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: onSaveTap, icon: icon),
                  Visibility(
                    visible: isVisible,
                    child: IconButton(
                      onPressed: onSaveTap,
                      icon: const Icon(Icons.folder, color: CupertinoColors.systemYellow),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: progress,
              backgroundColor: Colors.grey.shade400,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
