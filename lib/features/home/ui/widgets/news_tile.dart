import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final int index;
  const NewsTile({
    super.key,
    required this.dummyImages,
    required this.index,
  });

  final List<String> dummyImages;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.35,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  dummyImages[index],
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Sports',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Flexible(
                      child: Text(
                        'Alexander wears modified helmet in road races ',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'McKindney • Feb 27 2023',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
