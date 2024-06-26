import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          left: 24,
          right: 24,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Image(
            image: AssetImage('assets/pets/img_logo.png'),
          ),
          const SizedBox(height: 16),
          Text(
            "Find needs fo your\nbeloved animal here",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: Image(
              image: AssetImage('assets/pets/img_get_started.png'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Get attractive promos here, immediately\njust register your account to fulfill the best needs for your beloved pet",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async {
              context.read<AuthBloc>().add(const AuthEventFirstLaunch());
              GoRouter.of(context).go('/home');
            },
            child: Container(
              height: 66,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(32)),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.getStarted,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}
