from typing import Any
from numbers import Number

# Wprawki w programowaniu w Python'ie
# Staramy się programować starannie, używając gdzie można "Type Hinting" -
#   po to są te importy w nagłówku
# Ale: jeśli student posługuje się starszymi wersjami Pythona,
# to można mu odpuścić typowanie

# to jest funkcja do eksperymentowania w przyszłości
def myFnc(x, y):
    return x * (x + y)


# Python ma listy
# robimy kilka swoich funkcji pomocniczych

def isEmpty(li : list) -> bool:
    return len(li)==0

# pierwszy element listy
def head(li : list) -> Any: 
    return li[0]

# Ogon listy
def tail(li : list) -> list:
    return li[1:]


# rekurencyjna wersja sumy
def mySum(li : list[Number]) -> Number :
    if isEmpty(li) : 
      return 0;
    else:  
      return head(li) + mySum(tail(li))

def mySumInd(li : list[Number]) -> Number :
    return mySumIndReq(li, 0);

def mySumIndReq(li: list[Number], sum: Number) -> Number :
    if isEmpty(li) :
        return sum;
    else:
        return mySumIndReq(tail(li), sum + head(li));

# ZADANIE: przerób mySum na wersję indukcji ogonowej

def main():
    myList = [1, 2, 3, 4, 5];
    firstSum = mySum(myList);
    secondSum = mySumInd(myList);

    if (firstSum == secondSum):
        print("MySumInd works");
    else:
        print("MySumInd doesn't work");

main()
