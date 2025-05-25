import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/features/tasbih/presentation/widgets/drop_menu.dart';
import 'package:islamic/features/tasbih/presentation/widgets/tasbih_app_bar.dart';
import '../../cubit/athkar_cubit.dart';
import '../widgets/total_widget.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  String quran = "assets/images/quran3.png";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              AthkarCubit()
                ..getTotalCount()
                ..loadCount(),
      child: BlocListener<AthkarCubit, AthkarState>(
        listener: (context, state){
          if (state is AthkarGetDeleteSuccess) {
            Navigator.pop(context);
            TasbihAppBar.showHistoryDialog(context);
          }
        },
        child: BlocBuilder<AthkarCubit, AthkarState>(
          builder: (context, state) {
            final cubit = context.read<AthkarCubit>();
            return Scaffold(
              appBar: TasbihAppBar(
                onPressed: () {
                  cubit.removeAll();
                  Navigator.pop(context);
                },
                onTap: () {
                  TasbihAppBar.showHistoryDialog(
                    context,
                    onDelete: () {
                      TasbihAppBar(
                        onPressed: () {
                          cubit.removeAll();
                          Navigator.pop(context);
                        },
                      ).showDeleteDialog(context);
                    },
                  );
                },
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 270.h,
                      width: 300.w,
                      child: Image.asset(quran),
                    ),
                    SizedBox(height: 15.h),
                    DropMenu(
                      count: cubit.count,
                      increment: () {
                        cubit.incrementCount();
                      },
                      loading: () {
                        cubit.loadCount();
                      },
                      onChanged: (String? newValue) {
                        cubit.selectedThikr = newValue!;
                        cubit.loadCount();
                      },
                      athkarList: cubit.athkarList,
                      selectedThikr: cubit.selectedThikr,
                    ),
                    SizedBox(height: 35.h),
                    TotalWidget(
                      totalCount: cubit.totalCount,
                      onTap: () {
                        cubit.resetCount();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
