import pythonproject


def _foo(hive_context, date):
    pythonproject.foo.process(hive_context, date)
    pythonproject.foo.compute(hive_context, date)


def _bar(hive_context, date):
    pythonproject.bar.process(hive_context, date)
    pythonproject.bar.compute(hive_context, date)


def run(hive_context, date):
    _foo(hive_context, date)
    _bar(hive_context, date)
