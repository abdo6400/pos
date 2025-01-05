import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../domain/entities/question.dart';
import '../bloc/question/question_bloc.dart';

class QuestionsList extends StatelessWidget {
  final String productId;
  final MultiSelectController<Question> controller;
  const QuestionsList(
      {super.key, required this.productId, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(builder: (context, state) {
      if (state is QuestionError) {
        return ErrorCard(
          message: state.message,
          onRetry: () => context.read<QuestionBloc>().add(GetQuestionsEvent()),
        );
      }
      final List<Question> questions = state is QuestionSuccess
          ? state.filterQuestionsByProduct(productId)
          : [];
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
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withAlpha(225),
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: context.ResponsiveValu(16,
                                mobile: 14, tablet: 20, desktop: 25),
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state is QuestionSuccess
                    ? MultiSelectCheckList<Question>(
                        maxSelectableCount: questions.length,
                        listViewSettings: ListViewSettings(
                            separatorBuilder: (context, index) => const Divider(
                                  height: 0,
                                )),
                        controller: controller,
                        items: List.generate(
                            questions.length,
                            (index) => CheckListCard(
                                  value: questions[index],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text(context.trValue(
                                      questions[index].questionAr,
                                      questions[index].questionAr)),
                                  textStyles: MultiSelectItemTextStyles(
                                    selectedTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: context.ResponsiveValu(16,
                                              mobile: 14,
                                              tablet: 20,
                                              desktop: 25),
                                        ),
                                    disabledTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: context.ResponsiveValu(16,
                                              mobile: 14,
                                              tablet: 20,
                                              desktop: 25),
                                        ),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: context.ResponsiveValu(16,
                                              mobile: 14,
                                              tablet: 20,
                                              desktop: 25),
                                        ),
                                  ),
                                )),
                        onChange: (allSelectedItems, selectedItem) {},
                      )
                    : Card(),
              )
            ],
          ));
    });
  }
}
