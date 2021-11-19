// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Image {
    struct PixelChunk { // 216-bit chunk
        uint8[3][3] red;
        uint8[3][3] green;
        uint8[3][3] blue;
    }
    
    mapping(uint256 => PixelChunk) internal imageChunk; 
    
    // Super expensive method 90K gas/pixel
    function editChunk(uint256 _chunk, uint8 _x, uint8 _y, uint8 _red, uint8 _green, uint8 _blue) external {
        PixelChunk storage pChunk = imageChunk[_chunk];
        
        (pChunk.red[_x][_y], pChunk.green[_x][_y], pChunk.blue[_x][_y]) = (_red, _green, _blue);
    }
    
    // Somewhat cheaper 34-36K gas/pixel
    function editChunk(uint256 _chunk, uint8[3][3] memory _red, uint8[3][3] memory _green, uint8[3][3] memory _blue) external {
        PixelChunk storage pChunk = imageChunk[_chunk];
        
        pChunk.red = _red;
        pChunk.green = _green;
        pChunk.blue = _blue;
    }
}
