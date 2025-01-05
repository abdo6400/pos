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
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: state is QuestionSuccess ? questions.length : 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Text(
                    state is QuestionSuccess
                        ? context.trValue(questions[index].questionAr,
                            questions[index].questionAr)
                        : "loading",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ]),
              );
            }),
      );
    });
  }
}
