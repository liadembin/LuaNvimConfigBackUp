from typing import List

arr = [1, 2, 3, 4, 5, 6, 7]
target = 4


def tw_sum(arr, target) -> List[int]:
    has = {}
    for i, val in enumerate(arr):
        pair = target - val
        if pair in has:
            return [has[pair], i]
        has[val] = i
    return [-1, -1] 
