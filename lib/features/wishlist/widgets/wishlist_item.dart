import 'package:bluebaker/exports.dart';

class WishlistItem extends StatelessWidget {
  final void Function() tap;
  final String title;
  final String subtitle;
  final IconData icon;
  const WishlistItem({
    Key? key,
    required this.tap,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              color: Theme.of(context).primaryColor,
            ),
            height: 75.h,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 75.h,
                    child: Icon(
                      icon,
                      color: Theme.of(context).focusColor,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      color: Theme.of(context).hoverColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.h,
                            color: Theme.of(context).focusColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          subtitle + ' items',
                          style: GoogleFonts.lato(
                              fontSize: 14.h,
                              color: Theme.of(context).focusColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
