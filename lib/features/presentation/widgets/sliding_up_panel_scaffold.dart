import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlidingUpPanelScaffold extends StatelessWidget {
  final Color? headerBackgroundColor;
  final Widget header;
  final Widget body;
  final EdgeInsetsGeometry? scaffoldBodyPadding;
  final double? defaultBottomHeight;
  const SlidingUpPanelScaffold(
      {super.key,
      this.headerBackgroundColor,
      this.scaffoldBodyPadding,
      required this.header,
      required this.body,
      this.defaultBottomHeight});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openBottomSheet(
        context,
        CustomBottomSheetWidget(
            defaultBottomSheetHeight: defaultBottomHeight ?? 0.4.sh,
            content: body),
      );
    });

    return Scaffold(
        backgroundColor:
            headerBackgroundColor ?? Theme.of(context).primaryColor,
        body: SafeArea(
          child: Padding(
            padding: scaffoldBodyPadding ?? EdgeInsets.zero,
            child: header,
          ),
        ));
  }

  openBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
        useSafeArea: true,
        isDismissible: false,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.r),
                topRight: Radius.circular(22.r))),
        context: context,
        builder: (context) {
          return child;
        });
  }
}

class CustomBottomSheetWidget extends HookWidget {
  final Widget content;
  final double defaultBottomSheetHeight;
  final double maxBottomSheetHeight = 1.sh;
  CustomBottomSheetWidget(
      {super.key,
      required this.defaultBottomSheetHeight,
      required this.content});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final bottomSheetHeight = useState(defaultBottomSheetHeight);

    useEffect(() {
      scrollListener() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          bottomSheetHeight.value = maxBottomSheetHeight;
        }
        if (scrollController.position.userScrollDirection ==
                ScrollDirection.forward &&
            scrollController.position.pixels <= 10.0) {
          bottomSheetHeight.value = defaultBottomSheetHeight;
        }
      }

      Future.microtask(() {
        scrollController.addListener(scrollListener);
      });

      return () => scrollController.removeListener(scrollListener);
    }, []);

    return AnimatedContainer(
      padding: EdgeInsets.fromLTRB(16.spMin, 8.h, 16.spMin, 8.h),
      duration: const Duration(milliseconds: 200),
      height: bottomSheetHeight.value,
      width: double.infinity,
      child: Stack(
        children: [
          _buildScrollIndicatior(),
          SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: content,
            ),
          ),
        ],
      ),
    );
  }

  Align _buildScrollIndicatior() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 4.h,
          width: 24.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r), color: Colors.grey),
        ));
  }
}
