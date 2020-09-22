# 1
""" Реализовать скрипт, в котором должна быть предусмотрена функция расчета заработной платы сотрудника.
В расчете необходимо использовать формулу: (выработка в часах * ставка в час) + премия.
Для выполнения расчета для конкретных значений необходимо запускать скрипт с параметрами. """
#
# Воспользуемся модулем argparse
import argparse


def salary(w, r, b):
    """ Функция расчёта ЗП с округлением до 2 знаков после запятой"""
    return round(w * r + b, 2)


parser = argparse.ArgumentParser(description='Расчёт ЗП сотрудника')
parser.add_argument("--workhours", required=True, type=int, help="Выработка в часах")
parser.add_argument("--rate", required=True, type=float, help="Ставка в час")
parser.add_argument("--bonus", required=True, type=float, help="Премия")
args = parser.parse_args()
print(salary(args.workhours, args.rate, args.bonus))
