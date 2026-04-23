import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveIndicesBanner extends StatefulWidget {
  const LiveIndicesBanner({super.key});

  @override
  State<LiveIndicesBanner> createState() => _LiveIndicesBannerState();
}

class _LiveIndicesBannerState extends State<LiveIndicesBanner> {
  double index1Price = 1225.55;
  double index1Change = 144.50;

  double index2Price = 54172.15;
  double index2Change = -14.75;

  Timer? _timer;
  final Random _random = Random();
  final NumberFormat _format = NumberFormat("#,##0.00", "en_IN");

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        double tick1 = (_random.nextDouble() * 4) - 2;
        double tick2 = (_random.nextDouble() * 10) - 5;

        index1Price += tick1;
        index1Change += tick1;

        index2Price += tick2;
        index2Change += tick2;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 12.0),
      child: IntrinsicHeight(
        child: Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          'SENSEX 18TH SEP 8...',
                          style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'BSE',
                        style: TextStyle(color: Colors.black87, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                          _format.format(index1Price),
                          style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)
                      ),
                      const SizedBox(width: 6),
                      Text(
                          '${index1Change > 0 ? '' : ''}${_format.format(index1Change)} (13.3...)',
                          style: TextStyle(
                              color: index1Change >= 0 ? Colors.green.shade600 : Colors.red.shade400,
                              fontSize: 12
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: VerticalDivider(color: Colors.black26, thickness: 0.5, width: 1),
            ),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'NIFTY BANK',
                          style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                                _format.format(index2Price),
                                style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)
                            ),
                            const SizedBox(width: 6),
                            Text(
                                '${index2Change > 0 ? '' : ''}${_format.format(index2Change)} (-0.03...)',
                                style: TextStyle(
                                    color: index2Change >= 0 ? Colors.green.shade600 : Colors.red.shade400,
                                    fontSize: 12
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // The arrow icon on the far right
                  const Icon(Icons.chevron_right, color: Colors.black, size: 24),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}