# 2
""" Представлен список чисел. Необходимо вывести элементы исходного списка,
значения которых больше предыдущего элемента.
Подсказка: элементы, удовлетворяющие условию, оформить в виде списка.
Для формирования списка использовать генератор.
Пример исходного списка: [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55].
Результат: [12, 44, 4, 10, 78, 123]. """
#
#
from random import randint


def gen_list(range_begin, range_end, count):
    """ Функция генерации списка псевдослучайных чисел размера count"""
    return [randint(range_begin, range_end) for _ in range(count)]


def new_list(my_list):
    """ Функция по созданию нового списка """
    return [my_list[i] for i in range(1, len(my_list)) if my_list[i] > my_list[i - 1]]


if __name__ == '__main__':
    my_list = gen_list(1, 500, 20)
    print(my_list)
    print(new_list(my_list))
