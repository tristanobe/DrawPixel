#include <iostream>

#include <fstream>
#include <ostream>

int main(int argc, char** argv){

    const int width = 600;
    const int height = 600;
    const int pixelCount = 3;

    const int numPixels = width  * height;
    uint8_t *pixels = new uint8_t[numPixels * pixelCount];

    for (int i = 0; i < numPixels * pixelCount; i++){
        pixels[i] = 0;
    }

    uint32_t *pixels2 = new uint32_t[numPixels];

    for (int i = 0; i < numPixels; i++){
        uint32_t pixel = pixels2[i];

        uint8_t r = 0;
        uint8_t g = 0; 
        uint8_t b = 0;

        pixels2[i] = r << 24 | g << 16 | b << 8;
    }

    std::ofstream file("img.ppm");

    file << "P3\n";
    file << width << " " << height << "\n";
    file << "255\n";

    for (int i = 0; i < numPixels; i++){
        uint32_t pixel = pixels2[i];

        uint8_t r = (pixel >> 24) & 255;
        uint8_t g = (pixel >> 16) & 0xFF; 
        uint8_t b = (pixel >> 8) & 0xFF;

        file << static_cast<int>(r) << " " << static_cast<int>(g) << " " << static_cast<int>(b) << " ";
    }

    file.close();

    delete[] pixels;
    delete[] pixels2;

    return 0;
}