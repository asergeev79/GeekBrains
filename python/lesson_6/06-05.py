# 5
""" Реализовать класс Stationery (канцелярская принадлежность).
Определить в нем атрибут title (название) и метод draw (отрисовка).
Метод выводит сообщение “Запуск отрисовки.”
Создать три дочерних класса Pen (ручка), Pencil (карандаш), Handle (маркер).
В каждом из классов реализовать переопределение метода draw.
Для каждого из классов методы должен выводить уникальное сообщение.
Создать экземпляры классов и проверить, что выведет описанный метод для каждого экземпляра. """
#


class Stationery:
    def __init__(self, title):
        self.title = title

    def draw(self):
        print('Запуск отрисовки')


class Pen(Stationery):
    def draw(self):
        print('Пишем ручкой')


class Pencil(Stationery):
    def draw(self):
        print('Пишем карандашом')


class Handle(Stationery):
    def draw(self):
        print('Пишем маркером')


s = Stationery('Канцелярия')
print(s.title, end=' ')
s.draw()
#
p = Pen('Ручка')
print(p.title, end=' ')
p.draw()
#
pl = Pencil('Карандаш')
print(pl.title, end=' ')
pl.draw()
#
h = Handle('Маркер')
print(h.title, end=' ')
h.draw()
