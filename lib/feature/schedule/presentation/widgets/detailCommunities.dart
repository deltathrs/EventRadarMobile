import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

Widget detailCommunityText(String content) {
  return ReadMoreText(
    content,
    trimMode: TrimMode.Line,
    trimLines: 3,
    trimExpandedText: "Show less",
    trimCollapsedText: "Show more",
  );
}
