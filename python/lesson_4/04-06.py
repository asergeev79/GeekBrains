# 6
""" Реализовать два небольших скрипта:
а) итератор, генерирующий целые числа, начиная с указанного,
б) итератор, повторяющий элементы некоторого списка, определенного заранее.
Подсказка: использовать функцию count() и cycle() модуля itertools.
Обратите внимание, что создаваемый цикл не должен быть бесконечным.
Необходимо предусмотреть условие его завершения.
Например, в первом задании выводим целые числа, начиная с 3, а при достижении числа 10 завершаем цикл.
Во втором также необходимо предусмотреть условие,
при котором повторение элементов списка будет прекращено. """
#
from itertools import count, cycle
while True:
    try:
        n_start = int(input('Введите начало последовательности: '))
        n_end = int(input('Введите конец последовательности: '))
        break
    except ValueError:
        print('Введите целое число')
for el in count(n_start):
    if el <= n_end:
        print(el)
    else:
        break
#
#
from random import randint
while True:
    try:
        n_size = int(input('Введите размер последовательности: '))
        n_count = int(input('Введите кол-во повторений: '))
        break
    except ValueError:
        print('Введите целые числа')
my_list = [randint(0, 20) for _ in range(n_size)]
print('Исходный список:')
print(my_list)
i = 0
for el in cycle(my_list):
    if i < n_count:
        print(el)
        i += 1
    else:
        break
