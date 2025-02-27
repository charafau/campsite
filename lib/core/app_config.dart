  enum AppFlavor { prod, dev, local }

  abstract class AppConfig {
    const AppConfig._();

    String get httpScheme => "https";

    String get serverLink => "";

    int get serverPort => null;

    String get apiPath => "";

    AppFlavor get flavor;

    factory AppConfig(AppFlavor flavor) {
      switch (flavor) {
        case AppFlavor.prod:
          return const _ProdConfig();
        case AppFlavor.dev:
          return const _DevConfig();
        case AppFlavor.local:
          return const _LocalConfig();
      }

      throw '$flavor is not a recognised app flavor value';
    }
  }

  class _ProdConfig extends AppConfig {
    const _ProdConfig() : super._();

    @override
    AppFlavor get flavor => AppFlavor.prod;
  }

  class _DevConfig extends AppConfig {
    const _DevConfig() : super._();

    @override
    AppFlavor get flavor => AppFlavor.dev;
  }

  class _LocalConfig extends AppConfig {
    const _LocalConfig() : super._();

    @override
    AppFlavor get flavor => AppFlavor.local;
  }
 
  