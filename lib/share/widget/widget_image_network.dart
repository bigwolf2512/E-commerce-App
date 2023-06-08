import 'package:ecommerceshop/data/model/product_model.dart';
import 'package:ecommerceshop/design/extension/double_extension.dart';
import 'package:ecommerceshop/share/constant/constant.dart';
import 'package:ecommerceshop/share/widget/widget_loading_indicator.dart';
import 'package:flutter/material.dart';

class CustomNetworkImageWidget extends StatefulWidget {
  const CustomNetworkImageWidget(
      {Key? key,
      required this.product,
      this.height,
      this.width,
      this.borderRadius = 0,
      this.child = const SizedBox()})
      : super(key: key);

  final ProductModel product;
  final double? height;
  final double? width;
  final Widget child;
  final double borderRadius;

  @override
  State<CustomNetworkImageWidget> createState() =>
      _CustomNetworkImageWidgetState();
}

class _CustomNetworkImageWidgetState extends State<CustomNetworkImageWidget> {
  final image = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      image.value = await widget.product.getFirstImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: image,
        builder: (_, data, __) {
          if (widget.product.images.isEmpty) {
            return Container(
              height: widget.height ?? 0.3.w,
              width: widget.width ?? 0.3.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(defaultImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: kSecondaryColor),
              child: widget.child,
            );
          }
          if (data.isEmpty) {
            return Container(
              height: widget.height ?? 0.3.w,
              width: widget.width ?? 0.3.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: kSecondaryColor),
              child: OnLoadingIndicator(),
            );
          }
          return Container(
            height: widget.height ?? 0.3.w,
            width: widget.width ?? 0.3.w,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: kSecondaryColor),
            child: widget.child,
          );
        });
  }
}

const defaultImage =
    'https://img.freepik.com/free-vector/white-product-podium-with-green-tropical-palm-leaves-golden-round-arch-green-wall_87521-3023.jpg?w=1380&t=st=1686233299~exp=1686233899~hmac=d727bc186f7989729e776608195721cd8acaaa82699b0e4dec6ce4e2494934a3';