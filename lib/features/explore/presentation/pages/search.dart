import 'dart:io';

import 'package:bluebaker/exports.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search';
  const Search({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      // transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      //     FadeTransition(opacity: animation, child: child),
      pageBuilder: (_, __, ___) => BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(
          blueBakerRepository: context.read<BlueBakerRepository>(),
        ),
        child: const Search(),
      ),
    );
  }

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();

  changesOnField() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(changesOnField);
    // _controller = TextEditingController(text: widget.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0.w,
          leading: Container(),
          titleSpacing: 0.sp,
          title: HeroMode(
            enabled: true,
            child: Hero(
              tag: 'search',
              transitionOnUserGestures: true,
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: textFormFieldDecoration.copyWith(
                    hintText: 'Search BlueBaker',
                    fillColor: Theme.of(context).hoverColor,
                    prefixIcon: Icon(
                      FeatherIcons.search,
                      color: Colors.grey.shade600,
                      size: 25.h,
                    ),
                    hintStyle: GoogleFonts.lato(
                      fontSize: 14.h,
                      // fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                    suffixIcon: _controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              context.read<SearchCubit>().clearSearch();
                              _controller.clear();
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                  ),
                  style: GoogleFonts.lato(
                    fontSize: 17.h,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).focusColor,
                  ),
                  textInputAction: TextInputAction.search,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    if (value.trim().isNotEmpty) {
                      context.read<SearchCubit>().searchBlueBaker(value.trim());
                    }
                  },
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, right: 20.h),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.lato(
                    color: Theme.of(context).focusColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            switch (state.status) {
              case SearchStatus.initial:
                return Container();
              case SearchStatus.error:
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(
                      state.failure.message,
                      style: GoogleFonts.lato(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              case SearchStatus.loading:
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).focusColor,
                  ),
                );
              case SearchStatus.loaded:
                return state.items.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: GridView.builder(
                          padding: EdgeInsets.all(20.h),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio:
                                Platform.isIOS ? 2 / 3.6 : 2 / 3.2,
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: state.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SearchItem(
                              id: state.items[index].id,
                              name: state.items[index].name,
                              description: state.items[index].description,
                              imageURL: state.items[index].photoUrl,
                              price: state.items[index].price,
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.h),
                          child: Text(
                            'No results found for ' '\'' +
                                _controller.text +
                                '\'',
                            style: GoogleFonts.lato(
                              color: Theme.of(context).focusColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
