import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utilidades/src/models/about_model.dart';

class AboutController {
  AboutModel getAbout() {
    return AboutModel(
      photoUrl: "https://avatars.githubusercontent.com/u/172058538?v=4",
      aboutMe: [
        "Sou profissional da indústria metal-mecânica há 7 anos, especializado em Usinagem,"
            "Programação CNC e Metrologia, e estou em transição para a área da Tecnologia.",

        "Meu objetivo é atuar como Desenvolvedor, afim de adquirir experiência prática,"
            "e contribuir com soluções eficientes e alinhadas às necessidades do usuário.",

        " Meus conhecimentos na área incluem: "
            "Dart, Flutter, Python, Django, Node.js, JavaScript, React.js, HTML, CSS, MySQL, Git",
      ],
      socialLinks: [
        SocialLinks(
          name: "GitHub",
          icon: FontAwesomeIcons.github,
          color: Colors.black,
          url: "https://github.com/guustavopetry",
        ),

        SocialLinks(
          name: "LinkedIn",
          icon: FontAwesomeIcons.linkedin,
          color: Colors.indigo,
          url: "https://linkedin.com/in/ogustavopetry1999",
        ),
      ],
    );
  }
}
