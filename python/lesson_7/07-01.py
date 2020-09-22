# 1
"""  Реализовать класс Matrix (матрица).
Обеспечить перегрузку конструктора класса (метод __init__()),
который должен принимать данные (список списков) для формирования матрицы.
Следующий шаг — реализовать перегрузку метода __str__() для вывода матрицы в привычном виде.
Далее реализовать перегрузку метода __add__()
для реализации операции сложения двух объектов класса Matrix (двух матриц).
Результатом сложения должна быть новая матрица."""
#


class Matrix:
    def __new__(cls, *args, **kwargs):
        if len(args) != 1:
            print('Должен быть один аргумент')
            return None
        if len(kwargs) > 0:
            print('Именованных аргументов не должно быть')
            return None
        if not isinstance(args[0], list):
            print(args[0])
            print('В качестве аргумента должен быть передан список')
            return None
        for l in args[0]:
            if not isinstance(l, list):
                print('В качестве аргумента должен быть передан список списков')
                return None
            else:
                for i in l:
                    if not isinstance(i, int):
                        print('В качестве аргумента должен быть передан список списков целых чисел')
                        return None
        if max(map(len, args[0])) != min(map(len, args[0])):
            print('Матрица должна быть прямоугольной')
            return None
        return super().__new__(cls)

    def __init__(self, matrix_data):
        self.__matrix_data = matrix_data

    @property
    def matrix_size(self):
        return len(self.__matrix_data), len(self.__matrix_data[0])

    def __str__(self):
        matrix_print = ''
        for row in self.__matrix_data:
            for col in row:
                matrix_print += '{:4d}'.format(col)
            matrix_print += '\n'
        return matrix_print

    def __add__(self, other):
        matrix_sum = []
        if not isinstance(other, Matrix):
            print('Складываем между собой только матрицы')
            return None
        if self.matrix_size != other.matrix_size:
            print('Матрицы должны быть одного размера')
            return None
        for i in range(0, self.matrix_size[0]):
            row_i = []
            for j in range(0, self.matrix_size[1]):
                row_i.append(self.__matrix_data[i][j] + other.__matrix_data[i][j])
            matrix_sum.append(row_i)
        return Matrix(matrix_sum)


my_matrix1 = Matrix([[1, 2, 3], [3, 1, 2], [1, 3, 2], [3, 2, 1]])
my_matrix2 = Matrix([[3, 2, 1], [1, 3, 2], [3, 1, 2], [1, 2, 3]])
if my_matrix1 and my_matrix2:
    print('Складываем матрицу:')
    print(my_matrix1.matrix_size)
    print(my_matrix1)
    print('и матрицу:')
    print(my_matrix2.matrix_size)
    print(my_matrix2)
    print('Сумма:')
    print(my_matrix1 + my_matrix2)
