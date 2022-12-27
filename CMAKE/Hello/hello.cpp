#include <iostream>
#include "config.h"
#include "addaction.h"
#include "subtion.h"
using namespace std;

int main(int argc, char **argv)
{

    cout << "hello world" << endl;
    cout << HELLO_VERSION_MAJOR << "." << HELLO_VERSION_MINOR << endl;
    cout << DATE << endl;
    cout << " 1 + 2 = " << add(1, 2) << endl;
    cout << " 1 - 2 = " << sub(1, 2) << endl;
    return 0;
}

