import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercleancode/features/watchlist/presentation/pages/widgets/app_scaffold.dart';
import 'package:fluttercleancode/features/watchlist/presentation/pages/widgets/text_widget.dart';

import '../../data/models/watchlist_model.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_state.dart';

class Watchlist extends StatefulWidget {
  final WatchlistBloc watchlistBloc;
  const Watchlist({Key? key, required this.watchlistBloc}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  late WatchlistBloc watchlistBloc;
  @override
  void initState() {
    watchlistBloc = widget.watchlistBloc;

    watchlistBloc.add(const FetchWatchlist());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Appscaffold(
      color: Theme.of(context).cardColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: TextWidget(
              "Watchlist",
              size: 20,
              fontweight: FontWeight.bold,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          BlocConsumer<WatchlistBloc, WatchlistState>(
            bloc: watchlistBloc,
            listener: (context, state) {
              print(state);
            },
            builder: (context, state) {
              if (state is WatchlistDone) {
                Data watchlist = state.watchlist.response.data;
                return Expanded(
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: watchlist.symbols.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Theme.of(context).indicatorColor,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ExpandableNotifier(
                            child: Builder(builder: (context) {
                          return Column(children: [
                            ScrollOnExpand(
                                child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                hasIcon: false,
                                useInkWell: true,
                              ),
                              collapsed: Container(
                                height: 1,
                              ),
                              header: bodyData(context, watchlist, index),
                              expanded: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          /*   Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamed(
                                                  RouteName.confirmScreen,
                                                  arguments: ConfirmArgs(
                                                      watchlist
                                                          .symbols[index])); */
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        child: const TextWidget(
                                          "Buy",
                                          color: Colors.white,
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          /*  Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamed(
                                                  RouteName.confirmScreen,
                                                  arguments: ConfirmArgs(
                                                      watchlist
                                                          .symbols[index])); */
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: const TextWidget(
                                          "sell",
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                            ))
                          ]);
                        }));

                        //bodyData(context, watchlist, index);
                      },
                    ),
                  ),
                );
              }

              if (state is WatchlistError) {
                return ErrorsWidget(message: state.message);
              }
              return loadData(context);
            },
          ),
        ],
      ),
    );
  }

  Container bodyData(BuildContext context, Data watchlist, int index) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    watchlist.symbols[index].dispSym.toString(),
                    fontweight: FontWeight.w500,
                    size: 16,
                    color: Theme.of(context).indicatorColor,
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  TextWidget(
                    watchlist.symbols[index].companyName.toString(),
                    size: 13,
                    color: Theme.of(context).indicatorColor,
                  ),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      watchlist.symbols[index].sym.exc,
                      size: 13,
                      color: Colors.pink[300],
                    ),
                  ],
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: TextWidget(
                      watchlist.symbols[index].excToken.toString(),
                      color: Colors.red,
                      size: 14,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          watchlist.symbols[index].haircut.toString(),
                          color: Colors.orange,
                          size: 13,
                          fontweight: FontWeight.w400,
                        ),
                      ),
                      TextWidget(
                        watchlist.symbols[index].sym.lotSize.toString(),
                        color: Colors.green,
                        size: 13,
                        fontweight: FontWeight.w400,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget loadData(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      )),
    );
  }
}

class ErrorsWidget extends StatelessWidget {
  final String message;
  const ErrorsWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 60,
          color: Colors.red[900],
        ),
        Text(message)
      ],
    ));
  }
}
