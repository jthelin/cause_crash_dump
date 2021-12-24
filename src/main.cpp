#include <iostream>

int main() {
    std::cout << "This program will core dump in ...." << std::endl;
    for (auto i: {3, 2, 1, 0}) {
        if (i != 0) {
            std::cout << "... " << i << " " << std::flush;
        } else {
            // Ensure we flush output message before we crash
            std::cout << "... Boom!" << std::endl;

            // This will cause division-by-zero error and core dump.
            int x = 10 / i;
            // [[NEVER_REACHED]]
            std::cout << "x = " << x;
        }
    }
    // [[NEVER_REACHED]]
    return 0;
}
