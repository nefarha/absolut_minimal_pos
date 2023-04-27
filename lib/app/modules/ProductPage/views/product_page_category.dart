import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';

final _faker = Faker();

class ProductCategory extends StatelessWidget {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          String categoryName = _faker.food.cuisine();
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  categoryName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
