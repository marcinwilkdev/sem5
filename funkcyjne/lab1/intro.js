/*
Wprawki w programowanieu w JavaScript
*/


// do ćwiczenia
function myFnc(x,y) {
    return x*(x+y);
}

// JS nie ma list jako typu natywnego
// modelować je będziemy jako tablice

function isEmpty(arr){
    return arr.length==0
}

//pierwszy element listy
function head(arr) {
    return arr[0];
}

//Ogon listy
function tail(arr) {
    return arr.slice(1)
}

//rekurencyjna wersja sumy

function mySum(arr) {
    if (isEmpty(arr)) {return 0;}
    else {return head(arr) + mySum(tail(arr));}
}

// ZADANIE: przerób mySum na wersję indukcji ogonowej     