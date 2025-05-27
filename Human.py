class Person:
    def __init__(self, name):
        self.name = name

    def speak(self):
        return self.name

    def set_name(self, n2):
        self.name = n2

    @staticmethod
    def Idk():
        return "asd"

    def get_name(self):
        return self.name


# y a o, y i o
if False or True:
    print(1)
print(Person.mro())
p = Person("Name")
p.Idk().capitalize().isalnum()
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa =  123
