from ._version import VERSION as __version__  # noqa: F401

from collections import OrderedDict


class ParamsMeta(type):
    @classmethod
    def __prepare__(cls, *args, **kwargs):
        return OrderedDict()

    def __new__(self, name, bases, classdict):
        classdict["__ordered__"] = [
            key
            for key in classdict.keys()
            if key not in ("__module__", "__qualname__", "__annotations__")
        ]
        return type.__new__(self, name, bases, classdict)


class ParamsBase(object, metaclass=ParamsMeta):
    def __iter__(self):
        for attr in self.__ordered__:
            yield getattr(self, attr)
