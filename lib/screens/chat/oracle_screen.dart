import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horoscope_app/db/entities/entities.dart';
import 'package:horoscope_app/generated/l10n.dart';
import 'package:horoscope_app/providers/chats/chats_provider.dart';
import 'package:horoscope_app/providers/providers.dart';
import 'package:horoscope_app/widgets/widgets.dart';

class OracleScreen extends StatelessWidget {
  const OracleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChatView();
  }
}

class _ChatView extends ConsumerWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatProvider = ref.watch(chatsProvider);

    final isDarkmode = ref.watch(darkModeProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: !isDarkmode
              ? const Color.fromRGBO(254, 211, 170, 1)
              : const Color.fromRGBO(23, 5, 66, 1),
          title: Text(
            S.of(context).tOracle,
          ),
        ),
        body: Container(
          decoration: !isDarkmode
              ? const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/chat_pattern.png'),
                      alignment: Alignment.topRight,
                      repeat: ImageRepeat.repeat,
                      centerSlice: Rect.zero,
                      colorFilter: ColorFilter.linearToSrgbGamma(),
                      opacity: 0.5),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.decal,
                      stops: [
                        0.1,
                        0.6
                      ],
                      colors: [
                        Color.fromRGBO(254, 211, 170, 1),
                        Color.fromRGBO(191, 141, 187, 1),
                      ]))
              : const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topRight,
                      repeat: ImageRepeat.repeat,
                      image: AssetImage('assets/chat_pattern.png'),
                      // fit: BoxFit.cover,
                      colorFilter: ColorFilter.linearToSrgbGamma(),
                      opacity: 0.5),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.decal,
                      stops: [
                        0.1,
                        0.6
                      ],
                      colors: [
                        Color.fromRGBO(23, 5, 66, 1),
                        Color.fromRGBO(155, 85, 148, 1),
                      ])),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OracleMessageBubble(
                              text: S.of(context).mOracle,
                              imageUrl:
                                  'https://pm1.narvii.com/7083/d8bad77dd802352b0587362104062c65a25e9392r1-798-420v2_128.jpg'),
                        );
                      }
                      final message = chatProvider.messageList[index];

                      final scale = index == chatProvider.messageList.length - 1
                          ? 1.0
                          : 0.85;

                      return Transform.scale(
                        scale: scale,
                        child: (message.fromWho == FromWho.oracle)
                            ? OracleMessageBubble(
                                text: message.text,
                                imageUrl: message.imageUrl!,
                              )
                            : MyMessageBubble(
                                message: message,
                              ),
                      );
                    },
                  ),
                ),
                MessageFieldBox(onValue: chatProvider.sendMessage),
              ]),
            ),
          ),
        ));
  }
}
