import Foundation

//Массив из кортежей - возвести Int в квадрат, отфильтровать только четные Int и упорядочить по строкам по возрастанию
var x = [(1, "x"), (4, "y"), (6, "a")]

func mappedFilteredSortedArrayOfTuples(array: [(int: Int, str: String)]) -> [(Int, String)]? {
    guard !array.isEmpty else { return nil }
    return array
        .map { ($0.int * $0.int, $0.str) }
        .filter { $0.int % 2 == 0}
        .sorted { $0.str < $1.str }
}

mappedFilteredSortedArrayOfTuples(array: x)
