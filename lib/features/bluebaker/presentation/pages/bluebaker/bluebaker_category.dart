import 'package:bluebaker/exports.dart';

class BlueBakerCategoryArgs {
  final String id;

  const BlueBakerCategoryArgs({
    required this.id,
  });
}

class BlueBakerCategory extends StatefulWidget {
  static const String routeName = '/bluebaker-category';

  const BlueBakerCategory({required this.id, Key? key}) : super(key: key);

  static Route route({required BlueBakerCategoryArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<BlueBakerBloc>(
        create: (context) => BlueBakerBloc(
          authBloc: context.read<AuthBloc>(),
          blueBakerRepository: context.read<BlueBakerRepository>(),
        )..add(FetchItems()),
        child: BlueBakerCategory(
          id: args.id,
        ),
      ),
    );
  }

  final String id;

  @override
  State<BlueBakerCategory> createState() => _BlueBakerCategoryState();
}

class _BlueBakerCategoryState extends State<BlueBakerCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlueBakerBloc, BlueBakerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              // title: Text(
              //   'BlueBaker',
              //   style: GoogleFonts.poppins(
              //     fontWeight: FontWeight.w600,
              //     fontSize: 18.sp,
              //     color: Theme.of(context).focusColor,
              //   ),
              // ),
              ),
          body: SafeArea(
            child: _buildBody(state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BlueBakerState state) {
    switch (state.status) {
      case BlueBakerStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return ListView.builder(
          padding: EdgeInsets.zero,
          // controller: _scrollController,
          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            List<String> ids = state.items[index].bluebakerID;
            if (ids.contains(widget.id)) {
              return BlueBakerCategoryItem(
                id: state.items[index].id,
                name: state.items[index].name,
                description: state.items[index].description,
                imageURL: state.items[index].photoUrl,
                price: state.items[index].price,
              );
            }
            return Container();
          },
        );
    }
  }
}
