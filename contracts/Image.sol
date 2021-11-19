// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Image {
    struct PixelChunk { // 216-bit chunk - 3x3 chunk
        uint8[3][3] red;
        uint8[3][3] green;
        uint8[3][3] blue;
    }

    mapping(uint256 => mapping(uint256 => PixelChunk)) internal imageChunk; // imageChunk[x][y] = PixelChunk

    // Super expensive method 90K gas/pixel
    function editChunk(uint256 _chunkX, uint256 _chunkY, uint8 _x, uint8 _y, uint8 _red, uint8 _green, uint8 _blue) external {
        PixelChunk storage pChunk = imageChunk[_chunkX][_chunkY];

        (pChunk.red[_x][_y], pChunk.green[_x][_y], pChunk.blue[_x][_y]) = (_red, _green, _blue);
    }

    // Somewhat cheaper 34-36K gas/pixel
    function editChunk(uint256 _chunkX, uint256 _chunkY, uint8[3][3] memory _red, uint8[3][3] memory _green, uint8[3][3] memory _blue) external {
        PixelChunk storage pChunk = imageChunk[_chunkX][_chunkY];

        pChunk.red = _red;
        pChunk.green = _green;
        pChunk.blue = _blue;
    }

    function viewChunk(uint256 _chunkX, uint256 _chunkY) external view returns(PixelChunk memory) {
        return imageChunk[_chunkX][_chunkY];
    }

    // good luck
    function viewEntireImage(uint256 _maxChunkX, uint256 _maxChunkY) external view returns(PixelChunk[][] memory) {
        PixelChunk[][] memory image = new PixelChunk[][](_maxChunkX * _maxChunkY);

        for(uint256 x; x < _maxChunkX; x++) {
            for(uint256 y; y < _maxChunkY; y++) {
                image[x][y] = imageChunk[x][y];
            }
        }

        return image;
    }
}
