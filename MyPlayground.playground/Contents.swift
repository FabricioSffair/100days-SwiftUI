import UIKit

var str = "Hello, playground"

for _ in 0...2 {
    var arr: [Int] = []
    for _ in 0...5 {
        var newNum = Int.random(in: 1..<61)
        while arr.contains(newNum) {
            newNum = Int.random(in: 1..<61)
        }
        arr.append(newNum)
    }
    print(arr.sorted())
    arr = []
}
