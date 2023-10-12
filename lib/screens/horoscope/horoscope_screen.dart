import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:horoscope_app/providers/providers.dart';

class HoroscopeScreen extends ConsumerStatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  HoroscopeScreenState createState() => HoroscopeScreenState();
}

class HoroscopeScreenState extends ConsumerState<HoroscopeScreen> {
  String mySign = 'aries';
  @override
  Widget build(BuildContext context) {
    final horoscope = ref.watch(dayliHoroscopeProvider(mySign));

    return Scaffold(
        appBar: AppBar(
          title: const Text('tu horoscopo'),
        ),
        body: Column(
          children: [
            horoscope.when(
              data: (data) => _HoroscopeText(data: data),
              loading: () => const CircularProgressIndicator(),
              error: (Object error, StackTrace stackTrace) => Text('$error'),
            ),
            // TextFormField(
            //   onTap:,

            // )
          ],
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => context.push('/oracle')));
  }
}

class _HoroscopeText extends StatelessWidget {
  final data;
  const _HoroscopeText({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data.date),
        AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
          TypewriterAnimatedText((data.horoscopeData),
              speed: const Duration(milliseconds: 60))
        ]),
      ],
    );
  }
}
