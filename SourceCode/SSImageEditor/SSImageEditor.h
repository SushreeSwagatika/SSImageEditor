//
//  SSImageEditor.h
//  SSImageEditor
//
//  Created by Sushree Swagatika on 02/03/17.
//  Copyright © 2017 Sushree Swagatika. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SSResizableCropView.h"
#import "SSLassoCropImageView.h"

typedef enum {
    SSFilterTypeNone,
    SSFilterTypeMono,
    SSFilterTypeTonal,
    SSFilterTypeNoir,
    SSFilterTypeFade,
    SSFilterTypeChrome,
    SSFilterTypeProcess,
    SSFilterTypeTransfer,
    SSFilterTypeInstant
}SSFilterType;

typedef enum {
    SSFlipTypeUp,
    SSFlipTypeDown,
    SSFlipTypeLeft,
    SSFlipTypeRight,
    SSFlipTypeMirroredUp,
    SSFlipTypeMirroredDown,
    SSFlipTypeMirroredLeft,
    SSFlipTypeMirroredRight
}SSFlipType;

typedef enum {
    SSMaskTypeCircle,
    SSMaskTypeOvalHorizontal,
    SSMaskTypeOvalVertical,
    SSMaskTypeRectangleHorizontal,
    SSMaskTypeRectangleVertical,
    SSMaskTypeFan,
    SSMaskTypeDiamond,
    SSMaskTypePentagon,
    SSMaskTypeHexagon,
    SSMaskTypeSun
}SSMaskType;


@interface SSImageEditor : NSObject

@property (nonatomic,readonly) UIImage *originalImage;

@property (nonatomic,strong) CIContext  *context;
@property (nonatomic,strong) CIImage    *beginImage;

/*
 
 * You need to implement this method to set the base / original image first.
 * This is mandatory to implement.
 
*/

- (id)initWithImage:(UIImage *)image;


#pragma mark - Filter Section
/*
 
 * "image" takes the image to be edited .
 * "filter" takes the type of filter from the filter list in the enum above .
 
*/

- (UIImage *)filterImage:(UIImage *)image withType:(SSFilterType)filter;


#pragma mark - Flip Section
/*
 
 * "image" takes the image to be edited .
 * "flip" takes the type of flip from the flip list in the enum above .
 
*/

- (UIImage *)flipImage:(UIImage *)image withType:(SSFlipType)flip;


#pragma mark - Mask Section
/*
 
 * "bezierRect" takes the bounds of the view to be masked .
 * "radius" takes the half of width (i.e., width/2) of the frame of the view to be masked .
 * "centr" takes the centre point of the view to be masked .
 
 * This method returns a bezier path which you can use as below to get your masked image.
 
 *      CAShapeLayer *maskLayer = [CAShapeLayer layer];
 *      maskLayer.path = beizerPath.CGPath;
 *      self.imageView.layer.mask = maskLayer;
 *      self.imageView.layer.masksToBounds = YES;
 
*/

- (UIBezierPath *)maskImageWithType:(SSMaskType)mask withRect:(CGRect)bezierRect andRadius:(CGFloat)radius andCentre:(CGPoint)centr;


#pragma mark - Crop Section
/*
 
 * "imageCropper" is an type of "SSResizableCropView" .
 * You have to create a "SSResizableCropView" first using "initWithImage:andSize:andStartCoordinate:"
 * and add it to your view before using this method to get the cropped image .
 
 * Tap on the "SSResizableCropView" to get the cropper view and then you can resize it further as you like.
 
*/

- (UIImage *)getCroppedImageFromResizableCropView:(SSResizableCropView *)imageCropper;

/*
 
 * "imageCropper" is an type of "SSLassoCropImageView" .
 * You have to create a "SSLassoCropImageView" first using "initWithImage:andFrame:"
 * and add it to your view before using this method to get the cropped image .
 
 * Draw on the "SSLassoCropImageView" with the shape you want to crop .
 
*/

- (UIImage *)getLassoCroppedImageWithOriginalBaseImage:(SSLassoCropImageView *)imageCropper;


#pragma mark - Shading Section
/*
 
 * "image" takes the image to be edited .
 * "newVal" takes the new float value .
 
*/

- (UIImage *)shadeImage:(UIImage *)image withContrastValue:(CGFloat)newVal;
- (UIImage *)shadeImage:(UIImage *)image withBrightnessValue:(CGFloat)newVal;
- (UIImage *)shadeImage:(UIImage *)image withSharpnessValue:(CGFloat)newVal;
- (UIImage *)shadeImage:(UIImage *)image withSaturationValue:(CGFloat)newVal;


#pragma mark - Red Eye Removal
/*
 
 * "image" takes the image to be edited .
 * The method returns an UIImage after removing the red eye from the image .
 
*/

-(UIImage*)removeRedEyeFromImage:(UIImage*)image;

@end
