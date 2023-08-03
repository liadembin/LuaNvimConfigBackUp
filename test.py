import requests
import numpy as np


class Person:

    def __init__(self, name: str):

        self.name = name

    def Speak(self):
        return "Hello, My Name Is: " + self.name


p = Person("asd")

print(p.Speak())
requests.get("  https://google.com/").text
(p.Speak().find("123").__int__().__int__() or False).to_bytes()
