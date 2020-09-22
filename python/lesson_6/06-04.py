# 4
""" Реализуйте базовый класс Car.
У данного класса должны быть следующие атрибуты: speed, color, name, is_police (булево).
А также методы: go, stop, turn(direction), которые должны сообщать, что машина поехала,
остановилась, повернула (куда).
Опишите несколько дочерних классов: TownCar, SportCar, WorkCar, PoliceCar.
Добавьте в базовый класс метод show_speed, который должен показывать текущую скорость автомобиля.
Для классов TownCar и WorkCar переопределите метод show_speed.
При значении скорости свыше 60 (TownCar) и 40 (WorkCar)
должно выводиться сообщение о превышении скорости.
Создайте экземпляры классов, передайте значения атрибутов.
Выполните доступ к атрибутам, выведите результат.
Выполните вызов методов и также покажите результат. """
#


class Car:
    def __init__(self, speed, color, name, is_police=False):
        self.speed = speed
        self.color = color
        self.name = name
        self.is_police = is_police

    def go(self):
        print('едем')

    def stop(self):
        print('стоим')

    def turn(self, direction):
        print('поворачиваем', direction)

    def show_speed(self):
        print('Текущая скорость', self.speed)


class TownCar(Car):
    def show_speed(self):
        if self.speed > 60:
            print('Превышение скорости')
        else:
            print('Текущая скорость', self.speed)


class SportCar(Car):
    pass


class WorkCar(Car):
    def show_speed(self):
        if self.speed > 40:
            print('Превышение скорости')
        else:
            print('Текущая скорость', self.speed)


class PoliceCar(Car):
    pass


tc = TownCar(70, 'черный', 'VW Polo')
print(f'Городской {tc.name} {tc.color}')
tc.go()
tc.turn('направо')
tc.show_speed()
tc.stop()

pc = PoliceCar(90, 'бело-синий', 'Ford')
print(f'Полиция {pc.name} {pc.color}')
pc.go()
pc.go()
pc.show_speed()
pc.stop()
