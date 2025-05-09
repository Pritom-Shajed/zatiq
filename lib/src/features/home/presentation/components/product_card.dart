import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zatiq/src/core/configs/constants.dart';
import 'package:zatiq/src/core/utils/extensions/extensions.dart';
import 'package:zatiq/src/core/utils/images/app_images.dart';
import 'package:zatiq/src/core/utils/responsive/responsive_utils.dart';
import 'package:zatiq/src/features/home/domain/entities/product/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.theme.primaryColor.withValues(alpha: 0.4),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ]),
      child: Row(
        crossAxisAlignment: crossStart,
        spacing: 12,
        children: [
          // IMAGE
          CachedNetworkImage(
            width: ResponsiveUtil.scaleSize(context, 90),
            height: ResponsiveUtil.scaleSize(context, 90),
            imageUrl: product.img,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: context.theme.primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: context.theme.primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
                image: const DecorationImage(
                  image: AssetImage(AppPngImages.placeholder),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: context.theme.primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
                image: const DecorationImage(
                  image: AssetImage(AppPngImages.placeholder),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // PRODUCT DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: crossStart,
              spacing: 2,
              children: [
                // Name
                Text(
                  product.name,
                  style: context.text.labelSmall,
                ),

                // Category
                Text.rich(
                  TextSpan(
                    text: 'Category : ',
                    style: context.text.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: product.categoryName,
                        style: context.text.bodySmall,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Branch
                Text.rich(
                  TextSpan(
                    text: 'Brand : ',
                    style: context.text.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: product.brandName,
                        style: context.text.bodySmall,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Price
                Text.rich(
                  TextSpan(
                    text: 'Price : ',
                    style: context.text.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${product.sellingPrice}',
                        style: context.text.bodySmall,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
