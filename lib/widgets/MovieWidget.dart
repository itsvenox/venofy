import 'package:flutter/material.dart';

import '../constants.dart';

class MovieWidget extends StatelessWidget {

  MovieWidget({
    required this.title,
    required this.image,
    required this.onTap,

  });

  final String title;
  final String image;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context,) {
    
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: 120, 
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.5, right: 6.5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(height: 150, width: 100,
                          child: Image.network(image, fit: BoxFit.cover
                        )
                      )
                    ),
                  ),
                  Container(
                    child: Text(title,
                    overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: xtxt,
                          fontSize: 14,
                        )
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}