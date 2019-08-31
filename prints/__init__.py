from collections import OrderedDict
from inspect import signature

from ._version import VERSION as __version__  # noqa: F401


class ParamsMeta(type):
    @classmethod
    def __prepare__(cls, *args, **kwargs):
        return OrderedDict()

    def __new__(self, name, bases, classdict):
        keys = [key for key in classdict.keys() if not key.startswith("__")]

        annotations = classdict.get("__annotations__", {})
        for key in keys:
            if key not in annotations:
                raise RuntimeError("invalid params: `{}` not annotated".format(key))

        classdict["__ordered__"] = keys

        return type.__new__(self, name, bases, classdict)


class ParamsBase(object, metaclass=ParamsMeta):
    def __iter__(self):
        for attr in self.__ordered__:
            yield getattr(self, attr)


def getargspec(params):
    args, varargs, keywords, defaults = [], None, None, []
    for name, param in params.items():
        if param.kind == param.VAR_POSITIONAL:
            varargs = name
        elif param.kind == param.VAR_KEYWORD:
            keywords = name
        else:
            args.append(name)
            if param.default is not param.empty:
                defaults.append(param.default)
    return (args, varargs, keywords, tuple(defaults) or None)


def check_module(mod):
    if not hasattr(mod, "Params"):
        raise TypeError("module does not export `Params`")
    if not hasattr(mod, "main"):
        raise TypeError("module does not export a function `main`")

    if not issubclass(mod.Params, ParamsBase):
        raise TypeError("module's `Params` export must subclass `prints.ParamsBase`")

    params = signature(mod.main).parameters
    args, varargs, _, _ = getargspec(params)
    if params[args[0]].annotation != mod.Params:
        raise TypeError(
            "module's `main` function must accept an instance of `Params` as its first parameter"
        )
