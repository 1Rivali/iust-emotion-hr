import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/cubit/calls/calls_cubit.dart';

import 'package:front/cubit/calls/confrence_cubit.dart';
import 'package:front/cubit/emotion/emotion_cubit.dart';
import 'package:screenshot/screenshot.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConferencePage extends HookWidget {
  const ConferencePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (context.read<ConferenceCubit>().participants.length > 1 &&
          context.read<AuthCubit>().isAdmin()) {
        context.read<EmotionCubit>().initEmotion();
      }
      // }
      return null;
    }, [context.watch<ConferenceCubit>().participants.length]);

    return BlocBuilder<EmotionCubit, void>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: BlocConsumer<ConferenceCubit, ConferenceState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ConferenceInitial) {
                  return showProgress();
                }
                if (state is ConferenceLoaded) {
                  return Stack(
                    children: <Widget>[
                      _buildParticipants(context),
                      Positioned(
                        bottom: 60,
                        right: 0,
                        left: 0,
                        child: IconButton(
                          color: Colors.red,
                          icon: const Icon(
                            Icons.call_end_sharp,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            context.read<ConferenceCubit>().disconnect();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      if (context.read<AuthCubit>().isAdmin())
                        Positioned(
                          top: 0,
                          child: Text(
                            "Room Name: ${context.read<CallsCubit>().createdCallUrl}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Colors.white,
                                    backgroundColor: Colors.black38),
                          ),
                        ),
                      if (context.read<AuthCubit>().isAdmin())
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: primaryColor,
                                  )),
                              child: BlocBuilder<EmotionCubit, String>(
                                builder: (context, state) {
                                  return Text(
                                    state == "" ? "Loading..." : state,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: Colors.white),
                                  );
                                },
                              ),
                            ))
                    ],
                  );
                }
                return Container();
              }),
        );
      },
    );
  }

  Widget showProgress() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(child: CircularProgressIndicator()),
        SizedBox(
          height: 10,
        ),
        Text(
          'Connecting to the room...',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildParticipants(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final children = <Widget>[];
    _buildOverlayLayout(context, size, children);
    return Stack(children: children);
  }

  void _buildOverlayLayout(
      BuildContext context, Size size, List<Widget> children) {
    final conferenceRoom = context.read<ConferenceCubit>();
    final participants = conferenceRoom.participants;
    children.add(GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemCount: participants.length,
        itemBuilder: (BuildContext context, int index) {
          if (context.read<ConferenceCubit>().participants.length > 1 &&
              index == 0 &&
              context.read<AuthCubit>().isAdmin()) {
            return Card(
              color: primaryColor,
              child: participants[index],
            );
          }
          return Card(
            child: participants[index],
          );
        }));
  }
}
