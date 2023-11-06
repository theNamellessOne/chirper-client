import 'package:chirper_client/features/feed/model/chirp.dart';
import 'package:chirper_client/features/feed/service/chirp__service.dart';
import 'package:chirper_client/fragments/button__fragment.dart';
import 'package:chirper_client/fragments/input__fragment.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool isLoading = false;
  bool isSending = false;
  int currentPage = 0;
  List<Chirp> chirps = [];

  final chirpController = TextEditingController();

  fetchChirps(int page) async {
    setState(() {
      isLoading = true;
    });

    chirps.addAll(await ChirpService().getChirps(page));

    setState(() {
      isLoading = false;
      currentPage = currentPage + 1;
    });
  }

  @override
  void initState() {
    fetchChirps(currentPage);
    super.initState();
  }

  @override
  void dispose() {
    chirpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: InputFragment(
                    hintText: "chirp...",
                    icon: Icons.text_fields,
                    controller: chirpController,
                    isDisabled: isSending || isLoading,
                  ),
                ),
                ButtonFragment(
                  onClick: () async {
                    setState(() {
                      isSending = true;
                    });

                    try {
                      final chirp =
                          await ChirpService().postChirp(chirpController.text);
                      setState(() {
                        if (chirp is Chirp) {
                          chirps.add(chirp);
                        }
                      });
                    } finally {
                      setState(() {
                        isSending = false;
                      });
                    }
                  },
                  isDisabled: isSending || isLoading,
                  child: const Icon(Icons.send),
                )
              ],
            ),
            Expanded(
                child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                final metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels != 0) {
                    fetchChirps(currentPage);
                  }
                }

                return true;
              },
              child: ListView.builder(
                  itemCount: chirps.length,
                  itemBuilder: (context, index) {
                    final chirp = chirps[index];

                    return ListTile(
                      subtitle: Text(chirp.content),
                      title: Text("${chirp.authorId}"),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
