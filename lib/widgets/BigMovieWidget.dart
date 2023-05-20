// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class BigMovieWidget extends StatelessWidget {

  BigMovieWidget({
    required this.title,
    required this.image,
    required this.onTap, 
    required this.rate,
  });

  final String title;
  final String image;
  final String rate;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context,) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [xbg, xx],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        child: Container(
                          // height: 150,
                          // width: 125,
                          child: Image.network(image, fit: BoxFit.cover
                        )
                      )
                    ),
                )]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: xtxt,
                      fontSize: 14,
                    )
                  ),
                  Row(
                    children: [
                      Text("rate :",
                        style: GoogleFonts.ubuntu(
                          color: xtxt.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                            height: 29,
                            child: Center(
                              child: Row(
                                children: [
                                  Text(rate,
                                    style: GoogleFonts.ubuntu(
                                      color: xsc,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 1),
                                  Icon(Icons.star_rate_rounded, 
                                    color: xsc, 
                                    size: 12,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}