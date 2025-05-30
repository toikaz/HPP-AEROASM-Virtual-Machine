# Документация для AeroAssembler

## Общее описание
Данный скрипт реализует простую виртуальную машину (ВМ), которая интерпретирует и выполняет ассемблероподобные команды, загруженные из файла. ВМ использует регистры, память и поддерживает управление потоком исполнения через метки и переходы.

---

## Основные компоненты

### Регистры
- `R0` — `R9`: 10 регистров общего назначения.
- **Флаги**:
  - `ZF` — Zero Flag

### Память
- `M1` — `M9`: 9 ячеек памяти, хранящих целые значения.

### Метки
- Обнаруживаются в исходном файле строками, начинающимися с `_`.
- Используются для организации точек перехода.

---

## Входной файл
Файл с расширением `.aeroasm`, содержащий команды по формату:

- **Комментарии** недопускаются.
- **Метки**: строки вида `_ метка`.
- **Команды**: инструкции, выполняющие операции.

---

## Поддерживаемые команды

| Команда          | Описание                                                      | Пример                        |
|------------------|--------------------------------------------------------------|------------------------------|
| `_ метка`       | Определение метки для переходов                               | `_ start`                   |
| `LOAD Rn, Mx`    | Загрузка из памяти Mx в регистр Rn                            | `LOAD R1, M3`               |
| `STORE Mx, Rn`   | Сохранение значения из Rn в память Mx                          | `STORE M2, R4`               |
| `MOV Rn, Rm`     | Передача значения из Rm в Rn                                   | `MOV R2, R5`                 |
| `ADD Rn, Rm`     | Сложение Rm к Rn, результат в Rn                                | `ADD R1, R2`                 |
| `SUB Rn, Rm`     | Вычитание Rm из Rn, результат в Rn                                | `SUB R3, R4`                 |
| `MUL Rn, Rm`     | Умножение Rn на Rm, результат в Rn                                | `MUL R1, R2`                 |
| `DIV Rn, Rm`     | Деление Rn на Rm, результат в Rn                                | `DIV R3, R4`                 |
| `SET Rn, 10`     | Установка Rn в число 10                                       | `SET R1, 10`                 |
| `SET Rn, GET`    | Ввод пользователя и установка в Rn                            | `SET R1, GET`                |
| `PRINT`          | Вывод значений регистров и памяти                              |                              |
| `PRINT_MEM Mx`   | Вывод значения памяти Mx                                      | `PRINT_MEM M5`               |
| `JMP label`      | Безусловный переход к метке                                   | `JMP start`                  |
| `JZ Rn, label`   | Переход, если Rn == 0                                         | `JZ R1, end`                 |
| `JNZ Rn, label`  | Переход, если Rn != 0                                         | `JNZ R1, loop`               |
| `SYSCALL filename` | Вызов внешних программ (используется для интеграции)        | `SYSCALL myprog`             |
| `PAUSE`          | Ожидание нажатия клавиши с текстом нажмите клавишу                                |                              |
| `PAUSE>NUL`      | Ожидание нажатия клавиши без текста                                  |                              |
| `HALT`           | Завершение выполнения программы                               |                              |
| `AND Rn, Rm`    | Логическое И между Rn и Rm, результат в Rn                      | `AND R1, R2`                 |
| `OR Rn, Rm`     | Логическое ИЛИ между Rn и Rm, результат в Rn                     | `OR R1, R2`                  |
| `XOR Rn, Rm`    | Исключающее ИЛИ между Rn и Rm, результат в Rn                     | `XOR R1, R2`                 |
| `NOT Rn`        | Логическое отрицание Rn (унарная операция), результат в Rn      | `NOT R1`                     |
| `JZ_ZF label`   | Переход, если ZF == 0                                         | `JZ_ZF end`                 |
| `JNZ_ZF Rn, label`  | Переход, если ZF != 0                                         | `JNZ_ZF loop`               |
| `INC Rn`        | Увеличение Rn на 1                                              | `INC R1`                     |
| `DEC Rn`        | Уменьшение Rn на 1                                              | `DEC R1`                     |
| `MOD Rn, Rm`    | Остаток деления Rn на Rm, результат в Rn                         | `MOD R1, R2`                 |
| `PUSH Rn`       | Помещение значения Rn на стек                                    | `PUSH R1`                    |
| `POP Rn`        | Извлечение значения со стека в Rn                                | `POP R2`                     |
| `CALL label`    | Вызов подпрограммы (запоминает текущий адрес и прыгает)        | `CALL sub`                   |
| `RET`           | Возврат из подпрограммы (восстановление адреса)               | `RET`                        |

---

## Замечания
- Вся программа работает в рамках одной сессии. После команды `HALT` выполнение прекращается.
- Внимательно следите за метками и переходами, чтобы избежать зацикливания.
- Вызов `SYSCALL` предполагает наличие внешних программ `hpp.exe` и `vvm.exe`, работающих с файлами по шаблону.
- Новые команды расширяют возможности для более сложных программ и логики.
