# SSImageEditor
  
  This is a simple library providing image editing features to filter, flip, mask, crop, shading and red eye removal to apply to an UIImage.

## Usage

  Drag and drop the folder named SSImageEditor. Add the .a type file to your project. Import the SSimageEditor.h file as below: 
  ```objective-c
  #import "SSImageEditor.h"
  ```
  Tadaa !!! You are all setup to use the editing features of this library.

## Description

  NOTE : Read the comments in 'SSImageEditor.h' before implementing the library into your project that contains detailed description of the usage of the methods.
         Don't forget to preserve your original image first using "initWithImage:" .
  
  * Filter section contains the common basic filters that should be available for all apple devices. Select one of the options from 'SSFilterType' enum list.
  
  * Flip section contains a list of options to select from 'SSFlipType' that includes flipping up, down, left, right, mirrored up, mirrored down, mirrored left and mirrored right.
  
  * Mask section contains a list of options to choose from 'SSMaskType' to mask your image in circular , oval-shaped(both in horizontal and vertical manner), rectangular-shaped(both in horizontal and vertical manner), and a number of different star-shaped manners.
  ```objective-c
    The method returns a bezier path which you can use as below to get your masked image.
 
 *      CAShapeLayer *maskLayer = [CAShapeLayer layer];
 *      maskLayer.path = beizerPath.CGPath;
 *      self.imageView.layer.mask = maskLayer;
 *      self.imageView.layer.masksToBounds = YES;
  ```
  
  * Crop section has been categorized into Lasso-cropping and Resizable-cropping ways.
  
  * Shading section comprises of adjusting the image contrast, brightness, exposure and saturation that is totally based upon [GPUImage](https://github.com/BradLarson/GPUImage). It is a great library that has a lot more !!! Check it out for more features.
  
  * Last but not the least, correction of red-eye images has been provided.
  
## Requirements

- iOS 7.0 or later
- Xcode 7.3 or later

## License

 Read the [License section](https://github.com/SushreeSwagatika/SSImageEditor/License.md)

