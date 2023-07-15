import requests


class Person:

    def __init__(self, name: str):

        self.name = name

    def Speak(self):

        return "Hello, My Name Is: " + self.name


p = Person("asd")

print(p.Speak())

requests.get("  https://google.com/").text
