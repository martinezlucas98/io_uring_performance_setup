import math

def percentile(values, percent, key=lambda k: k):
    assert isinstance(values, (list,tuple))

    idx = (len(values)-1) * percent
    floor = math.floor(idx)
    ceil = math.ceil(idx)
    if floor == ceil:
        return key(values[int(idx)])

    a = key(values[int(floor)]) * (ceild - idx)
    b = key(values[int(ceil)]) * (idx - floor)

    return a + b