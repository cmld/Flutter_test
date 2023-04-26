const String cmdStr = "LANGUAGE_ENV";

enum Envs { zh, cht, en }

// 获取的配置信息
class Env<T> {
  // 获取到当前环境
  static const appEnv = String.fromEnvironment(cmdStr, defaultValue: 'zh');

  static Envs get current => Envs.values.byName(appEnv);

  T withL(List<T> values) => values[current.index];
}
