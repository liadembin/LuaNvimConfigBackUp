from typing import Dict

import numpy as np
import requests


class Human:
    def __init__(self, name: str):
        self.name = name

    def Speak(self):
        return "Hello, My Name Is: " + self.name


p = Human("asd")
print(p.Speak())
requests.get("https://google.com/")
a: Dict[str, Human] = {}
a.get("asd").Speak()
p.Speak()

if a:
    print("123")
