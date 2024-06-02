import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class RecipeItem extends StatelessWidget {
  final String image, title, desc;

  const RecipeItem(
      {super.key,
      required this.image,
      required this.title,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Image.asset(
            image,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          // Bu widget metnin alanını genişletir ve sarmalanmasını sağlar.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 12, color: TW3Colors.gray.shade500),
                overflow: TextOverflow
                    .clip, // Metin taşarsa kesilir ve yeni satıra geçer.
              ),
            ],
          ),
        ),
      ],
    );
  }
}
