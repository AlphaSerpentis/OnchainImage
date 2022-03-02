// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Image {
    struct Pixel {
        uint8 red;
        uint8 green;
        uint8 blue;
    }
    
    mapping(uint256 => mapping(uint256 => Pixel)) internal image;
    
    // zero-value -> non-zero = 44.6K
    // non-zero -> non-zero = 27.5K
    // non-zero -> zero-value = 22.7K
    function editPixel(uint256 _x, uint256 _y, uint8 _red, uint8 _green, uint8 _blue) external {
        Pixel storage pixel = image[_x][_y];
        
        pixel.red = _red;
        pixel.green = _green;
        pixel.blue = _blue;
    }
    
    // zero-value -> non-zero = 24.97K/pixel (16 pixels changed)
    // non-zero -> non-zero = 9.88/pixel (16 pixels changed)
    // non-zero -> zero-value = 7.13K/pixel (16 pixels changed)
    function editPixel(uint256[] memory _x, uint256[] memory _y, uint8[][] memory _red, uint8[][] memory _green, uint8[][] memory _blue) external {

        unchecked {
            uint256 x;
            uint256 y;
            for(uint256 i; i < _x.length; i++) {
                x = _x[i];
                y = _y[i];
                
                Pixel storage pixel = image[x][y];
                
                pixel.red = _red[0][i];
                pixel.green = _green[0][i];
                pixel.blue = _blue[0][i];
                
            }
        }
        
    }
}