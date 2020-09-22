# 1 Loto


class LotoRow:
    def __init__(self, num_list, size_num=5):
        from random import sample
        num_rand = sample(num_list, size_num)
        num_dec = [el // 10 for el in num_rand]
        self.__row_dict = {}
        while True:
            if len(set(num_dec)) == size_num:
                if not ((8 in num_dec) and (9 in num_dec)):
                    self.__row_data = sorted(num_rand)
                    break
            num_rand = sample(num_list, size_num)
            num_dec = [el // 10 for el in num_rand]
        self.__row_full_data = ['' for _ in range(0, 9)]
        for el in self.__row_data:
            row_index = el // 10
            if row_index == 9:
                row_index = 8
            self.__row_full_data[row_index] = el

    @property
    def row_print(self):
        return self.__row_data

    @property
    def row_full_print(self):
        return self.__row_full_data

    def is_unique(self, other):
        self_set = set(self.row_print)
        other_set = set(other.row_print)
        return self_set.isdisjoint(other_set)

    def __str__(self):
        row_print = '|'.join(list(map('{:>3}'.format, self.__row_full_data)))
        row_print += '\n'
        return row_print

    def bochka_in(self, num):
        if num in self.__row_data:
            return self.__row_full_data.index(num)
        else:
            return -1

    def bochka_sub(self, num):
        self.__row_data.remove(self.__row_full_data[num])
        self.__row_full_data.pop(num)
        self.__row_full_data.insert(num, '--')

    def is_empty(self):
        return True if self.__row_data == [] else False


class LotoCard:
    def __init__(self, is_user, id_card):
        self.__ident = is_user
        self.__id = id_card
        self.__rows = []
        self.__row_count = 3
        num_count = 90
        loto_nums = [i for i in range(1, num_count + 1)]
        self.__rows.append(LotoRow(loto_nums, 5))
        for i in range(1, self.__row_count):
            loto_nums = list(set(loto_nums).difference(set(self.__rows[i - 1].row_print)))
            self.__rows.append(LotoRow(loto_nums, 5))

    def get_ident(self):
        return self.__ident

    def get_id(self):
        return self.__id

    def __str__(self):
        card_print = '{:-^35}'.format(' Карточка ' + self.__ident + 'а ' + str(self.__id)) + ' ' + '\n'
        for row in self.__rows:
            card_print += str(row)
            card_print += ('-' * 35 + '\n')
        card_print += '\n'
        return card_print

    def bochka_in(self, num):
        i = 0
        for row in self.__rows:
            bochka_in = row.bochka_in(num)
            if bochka_in != -1:
                return i, bochka_in
            i += 1
        return -1

    def bochka_sub(self, bochka_index):
        self.__rows[bochka_index[0]].bochka_sub(bochka_index[1])

    def loose_game(self):
        return str(self.get_ident()) + str(self.get_id()) + ' проиграл'

    def win_game(self):
        return str(self.get_ident()) + str(self.get_id()) + ' выиграл'

    def is_empty(self):
        for row in self.__rows:
            if not row.is_empty():
                return False
        return True


class Bochka:
    def __init__(self, size):
        self.__bochka_list = [el for el in range(1, size + 1)]
        self.__bochka_left = len(self.__bochka_list)
        self.__bochka_now = 0

    def bochka_throw(self):
        from random import randint
        self.__bochka_now = self.__bochka_list[randint(0, self.__bochka_left - 1)]
        self.__bochka_list.remove(self.__bochka_now)
        self.__bochka_left = len(self.__bochka_list)

    def get_bochka_now(self):
        return self.__bochka_now


class LotoGame:
    def __init__(self):
        self.__user_player = int(input('Введите количество игроков-людей: '))
        self.__comp_player = int(input('Введите количество игроков-компьютеров: '))
        # self.__user_player = 1
        # self.__comp_player = 1
        self.__loto_players = []
        for i in range(1, self.__user_player + 1):
            self.__loto_players.append(LotoCard('Игрок', i))
        for i in range(1, self.__comp_player + 1):
            self.__loto_players.append(LotoCard('Компьютер', i))
        self.__bochka = Bochka(90)
        self.__count = 0

    def grow_count(self):
        self.__count += 1

    def __str__(self):
        game_print = 'Ход: ' + str(self.__count) + '\n'
        game_print += 'Новый бочонок: ' + str(self.__bochka.get_bochka_now()) + '\n'
        for card in self.__loto_players:
            game_print += str(card)
        return game_print

    def game_start(self):
        while True:
            self.grow_count()
            self.__bochka.bochka_throw()
            print(self)
            for card in self.__loto_players:
                if card.get_ident() == 'Компьютер':
                    bochka_in = card.bochka_in(self.__bochka.get_bochka_now())
                    if bochka_in != -1:
                        card.bochka_sub(bochka_in)
                else:
                    print(f'Зачеркнуть цифру для {card.get_ident()} {card.get_id()}? (y/n): ')
                    ask = input('')
                    if ask == 'y':
                        bochka_in = card.bochka_in(self.__bochka.get_bochka_now())
                        if bochka_in != -1:
                            card.bochka_sub(bochka_in)
                        else:
                            return card.loose_game()
                    else:
                        bochka_in = card.bochka_in(self.__bochka.get_bochka_now())
                        if bochka_in != -1:
                            return card.loose_game()
            end_game = ''
            for card in self.__loto_players:
                if card.is_empty():
                    end_game += card.win_game() + '\n'
            if end_game != '':
                return end_game


l_game = LotoGame()
#print(l_game.game_start())
print(l_game)
ask = input('Начать игру? (y/n): ')
if ask == 'y':
    print(l_game.game_start())
else:
    print('Игра окончена')
