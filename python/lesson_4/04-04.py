# 4
""" Представлен список чисел. Определить элементы списка, не имеющие повторений.
Сформировать итоговый массив чисел, соответствующих требованию.
Элементы вывести в порядке их следования в исходном списке.
Для выполнения задания обязательно использовать генератор.
Пример исходного списка: [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11].
Результат: [23, 1, 3, 10, 4, 11] """
#
from random import randint


def gen_list(range_begin, range_end, count):
    """ Функция генерации списка псевдослучайных чисел размера count"""
    return [randint(range_begin, range_end) for _ in range(count)]


def new_list(my_list):
    """ Функция по созданию нового списка """
    return [el for el in my_list if my_list.count(el) == 1]


if __name__ == '__main__':
    my_list = gen_list(1, 20, 20)
    print(my_list)
    print(new_list(my_list))
