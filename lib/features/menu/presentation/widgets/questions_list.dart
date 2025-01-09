import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/question.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/question/question_bloc.dart';

class QuestionsList extends StatelessWidget {
  final String productId;
  final MultiSelectController<Product> controller;
  final List<Product> selectedQuestions;
  const QuestionsList(
      {super.key,
      required this.productId,
      required this.controller,
      this.selectedQuestions = const []});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: context.AppResponsiveValue(16,
              mobile: 14, tablet: 20, desktop: 25),
        );
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final List<Product> products =
            state is ProductSuccess ? state.products : [];
        return BlocBuilder<QuestionBloc, QuestionState>(
            builder: (context, state) {
          if (state is QuestionError) {
            return ErrorCard(
              message: state.message,
              onRetry: () =>
                  context.read<QuestionBloc>().add(GetQuestionsEvent()),
            );
          }
          final Map<int, List<Question>> questions = state is QuestionSuccess
              ? state
                  .filterQuestionsByProduct(productId)
                  .groupListsBy((x) => x.productQuestionId)
              : Map();
          if (state is QuestionSuccess && questions.isEmpty) {
            return Center(
              child: EmptyMessage(
                message: StringEnums.no_questions_found.name.tr(),
              ),
            );
          }
          return Skeletonizer(
              enabled: state is QuestionLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withAlpha(225),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.question_answer,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          StringEnums.questions.name.tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.AppResponsiveValue(16,
                                        mobile: 14, tablet: 20, desktop: 25),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: state is QuestionSuccess
                        ? ListView.builder(
                            itemCount: questions.keys.toList().length,
                            itemBuilder: (context, key) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Text("${key + 1}".toString(),
                                          style: style),
                                      Text(
                                          questions[
                                                  questions.keys.toList()[key]]!
                                              .first
                                              .questionAr,
                                          style: style),
                                    ],
                                  ),
                                  const Divider(),
                                  MultiSelectCheckList<Product>(
                                    maxSelectableCount:
                                        questions[questions.keys.toList()[key]]!
                                            .length,
                                    listViewSettings: ListViewSettings(
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                              height: 0,
                                            )),
                                    controller: controller,
                                    items: List.generate(
                                        questions[questions.keys.toList()[key]]!
                                            .length, (index) {
                                      final question = questions[
                                          questions.keys.toList()[key]]![index];
                                      final product = products.firstWhere((x) =>
                                          x.proId ==
                                          question.questionElements1);
                                      return CheckListCard(
                                        value: product,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        selected:
                                            selectedQuestions.contains(product),
                                        title: Text(
                                          "${context.trValue(product.proArName, product.proEnName)}",
                                        ),
                                        textStyles: MultiSelectItemTextStyles(
                                            selectedTextStyle: style,
                                            disabledTextStyle: style,
                                            textStyle: style),
                                      );
                                    }),
                                    onChange:
                                        (allSelectedItems, selectedItem) {},
                                  ),
                                ],
                              );
                            })
                        : Card(),
                  )
                ],
              ));
        });
      },
    );
  }
}
