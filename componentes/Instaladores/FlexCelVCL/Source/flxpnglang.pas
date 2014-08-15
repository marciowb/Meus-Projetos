{Portable Network Graphics Delphi Language Info (24 July 2002)}

{Feel free to change the text bellow to adapt to your language}
{Also if you have a translation to other languages and want to}
{share it, send me: gubadaud@terra.com.br                     }
unit flxpnglang;

interface

{$DEFINE English}
{.$DEFINE Polish}
{.$DEFINE Portuguese}
{.$DEFINE German}
{.$DEFINE French}
{.$DEFINE Slovenian}

{Language strings for english}
resourcestring
  {$IFDEF English}
  EPngInvalidCRCText = 'This "Portable Network Graphics" image is not valid ' +
      'because it contains invalid pieces of data (crc error)';
  EPNGInvalidIHDRText = 'The "Portable Network Graphics" image could not be ' +
      'loaded because one of its main piece of data (ihdr) might be corrupted';
  EPNGMissingMultipleIDATText = 'This "Portable Network Graphics" image is ' +
    'invalid because it has missing image parts.';
  EPNGZLIBErrorText = 'Could not decompress the image because it contains ' +
    'invalid compressed data.'#13#10 + ' Description: ';
  EPNGInvalidPaletteText = 'The "Portable Network Graphics" image contains ' +
    'an invalid palette.';
  EPNGInvalidFileHeaderText = 'The file being readed is not a valid '+
    '"Portable Network Graphics" image because it contains an invalid header.' +
    ' This file may be corruped, try obtaining it again.';
  EPNGIHDRNotFirstText = 'This "Portable Network Graphics" image is not ' +
    'supported or it might be invalid.'#13#10 + '(IHDR chunk is not the first)';
  EPNGNotExistsText = 'The png file could not be loaded because it does not ' +
    'exists.';
  EPNGSizeExceedsText = 'This "Portable Network Graphics" image is not ' +
    'supported because either it''s width or height exceeds the maximum ' +
    'size, which is 65535 pixels length.';
  EPNGUnknownPalEntryText = 'There is no such palette entry.';
  EPNGMissingPaletteText = 'This "Portable Network Graphics" could not be ' +
    'loaded because it uses a color table which is missing.';
  EPNGUnknownCriticalChunkText = 'This "Portable Network Graphics" image ' +
    'contains an unknown critical part which could not be decoded.';
  EPNGUnknownCompressionText = 'This "Portable Network Graphics" image is ' +
    'encoded with an unknown compression scheme which could not be decoded.';
  EPNGUnknownInterlaceText = 'This "Portable Network Graphics" image uses ' +
    'an unknown interlace scheme which could not be decoded.';
  EPNGCannotAssignChunkText = 'The chunks must be compatible to be assigned.';
  EPNGUnexpectedEndText = 'This "Portable Network Graphics" image is invalid ' +
    'because the decoder found an unexpected end of the file.';
  EPNGNoImageDataText = 'This "Portable Network Graphics" image contains no ' +
    'data.';
  EPNGCannotAddChunkText = 'The program tried to add a existent critical ' +
    'chunk to the current image which is not allowed.';
  EPNGCannotAddInvalidImageText = 'It''s not allowed to add a new chunk ' +
    'because the current image is invalid.';
  EPNGCouldNotLoadResourceText = 'The png image could not be loaded from the ' +
    'resource ID.';
  EPNGOutMemoryText = 'Some operation could not be performed because the ' +
    'system is out of resources. Close some windows and try again.';
  EPNGCannotChangeTransparentText = 'Setting bit transparency color is not ' +
    'allowed for png images containing alpha value for each pixel ' +
    '(COLOR_RGBALPHA and COLOR_GRAYSCALEALPHA)';
  EPNGHeaderNotPresentText = 'This operation is not valid because the ' +
    'current image contains no valid header.';
  EInvalidNewSize = 'The new size provided for image resizing is invalid.';
  EInvalidSpec = 'The "Portable Network Graphics" could not be created ' +
    'because invalid image type parameters have being provided.';
  {$ENDIF}

implementation

end.
