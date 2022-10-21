import 'package:bluebaker/exports.dart';

class BlueBaker extends StatefulWidget {
  const BlueBaker({Key? key}) : super(key: key);

  @override
  State<BlueBaker> createState() => _BlueBakerState();
}

class _BlueBakerState extends State<BlueBaker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlueBakerBloc, BlueBakerState>(
      listener: (context, state) {
        if (state.status == BlueBakerStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              tap: () {},
              content: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 20.w,
            title: Text(
              'BlueBaker',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35.h),
                        _buildBody(state),
                        SizedBox(height: 35.h),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width.w,
                    color: Colors.blue.shade300,
                    child: BlueBakerAltItem(
                      title: 'Sale',
                      onTap: () {},
                    ),
                  ),
                  BlueBakerAltItem(
                    title: 'BlueBaker Life',
                    onTap: () => Navigator.of(context).pushNamed(
                      BlueBakerLife.routeName,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BlueBakerState state) {
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          // controller: _scrollController,
          itemCount: state.bluebaker.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return BlueBakerItem(
              id: state.bluebaker[index].id,
              title: state.bluebaker[index].title,
            );
          },
        );
    }
  }
}
