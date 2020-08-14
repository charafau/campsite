import 'package:campsite/core/platform/constants.dart';
import 'package:campsite/features/main/domain/model/group_path.dart';
import 'package:campsite/features/main/presentation/bloc/campsite_bloc.dart';
import 'package:campsite/features/main/presentation/screen/campsite_map.dart';
import 'package:campsite/features/main/presentation/screen/main_map_screen.dart';
import 'package:campsite/logic/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Graph graph;

  @override
  void initState() {
    super.initState();
    graph = Graph.campsite();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CampsiteBloc(),
      child: LayoutBuilder(
        builder: (_, dimens) => Scaffold(
          drawer: dimens.maxWidth <= kDesktopBreakpoint
              ? Drawer(
                  elevation: 5,
                  child: SizedBox(width: 300, child: MainMapScreen.create()))
              : null,
          appBar: dimens.maxWidth <= kTabletBreakpoint ? buildAppBar() : null,
          body: Row(
            children: [
              if (dimens.maxWidth > kTabletBreakpoint)
                SizedBox(width: 300, child: MainMapScreen.create()),
              BlocBuilder<CampsiteBloc, CampsiteState>(
                builder: (context, state) {
                  if (state is GroupSelected) {
                    return MainMap(
                      graph: graph,
                      groupPath: state.groupPath,
                    );
                  }
                  return MainMap(
                    graph: graph,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Campsite',
      ),
    );
  }
}

class MainMap extends StatelessWidget {
  const MainMap({
    Key key,
    @required this.graph,
    this.groupPath,
  }) : super(key: key);

  final Graph graph;
  final GroupPath groupPath;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: CustomPaint(
          painter: CampsiteMapPainter(graph, selectedGroup: groupPath),
        ),
      ),
    );
  }
}
