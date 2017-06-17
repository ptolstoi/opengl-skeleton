#include <iostream>
#include <fstream>

using namespace std;

int main(int argc, char ** argv) {
    cout << "HALLO HALLO HALLO" << endl;
    cout << argc  << endl;

    for (int i = 0; i < argc; ++i) {
        cout << i << ": " << argv[i] << endl;
    }

    ofstream myfile;
    myfile.open(argv[2]);
    myfile << "#define TEEEEEEEEEST 1" << endl;
    myfile.close();

    return 0;
}