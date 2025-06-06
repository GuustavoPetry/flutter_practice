import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutModel {
  final String photoUrl;
  final List<String> aboutMe;
  final List<SocialLinks> socialLinks;

  AboutModel({
    required this.photoUrl,
    required this.aboutMe,
    required this.socialLinks,
  });
}

class SocialLinks {
  final String name;
  final IconData icon;
  final Color color;
  final String url;

  SocialLinks({
    required this.name,
    required this.icon,
    required this.color,
    required this.url,
  });
}
