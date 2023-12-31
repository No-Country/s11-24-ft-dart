import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horoscope_app/generated/l10n.dart';
import 'package:horoscope_app/screens/home/menu_items.dart';
import 'package:horoscope_app/widgets/widgets.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = S.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: HeadingWidget(
            title: 'Mystic Mind',
            subtitle: texts.tTitle,
          ),
        ),
        Text(texts.tSubTitle,
            style: GoogleFonts.krub(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 tarjetas por columna
              crossAxisSpacing: 15, // Espacio entre columnas
              mainAxisSpacing: 6, // Espacio entre filas
            ),
            itemCount: getAppMenuItems(context).length,
            itemBuilder: (BuildContext context, int index) {
              final menuItem = getAppMenuItems(context)[index];
              return _CustomListTile(
                menuItem: menuItem,
              );
            }),
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final MenuItem menuItem;

  const _CustomListTile({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            // color: Color.fromRGBO(254, 211, 170, 1),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => context.push(menuItem.location),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.asset(
                  menuItem.image,
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120,
                ),
              ),
            )),
        Text(
          menuItem.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 34 / 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
