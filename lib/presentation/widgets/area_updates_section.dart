import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/area_updates_cubit.dart';
import 'area_updates_section_content.dart';

class AreaUpdatesSection extends StatelessWidget {
  const AreaUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AreaUpdatesCubit(),
      child: const AreaUpdatesSectionContent(),
    );
  }
}