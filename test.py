import requests

import numpy as np


class Human:
    def __init__(self, name: str):
        self.name = name

    def Speak(self):
        return "Hello, My Name Is: " + self.name


p = Human("asd")
print(p.Speak())

requests.get("https://google.com/").text
