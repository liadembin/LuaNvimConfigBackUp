import numpy as np 
class Person:
    def __init__(self,name:str):
        self.name = name 
    def Speak(self):
        return "Hello, My Name Is: " + self.name 
Person p = Person("asd")
import requests
print(p.Speak())
requests.get("  https://google.com/").text.prop
