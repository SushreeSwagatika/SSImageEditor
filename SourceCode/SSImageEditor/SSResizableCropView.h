//
//  SSResizableCropView.h
//  SSImageEditor
//
//  Created by Sushree Swagatika on 02/03/17.
//  Copyright © 2017 Sushree Swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define IMAGE_CROPPER_OUTSIDE_STILL_TOUCHABLE 40.0f
#define IMAGE_CROPPER_INSIDE_STILL_EDGE 20.0f

@interface SSResizableCropView : UIView

@property (nonatomic, assign) CGRect crop;
@property (nonatomic, readonly) CGRect unscaledCrop;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain, readonly) UIImageView* imageView;

- (id)initWithImage:(UIImage*)newImage andSize:(CGSize)maxSize andStartCoordinate:(CGPoint)coordinateLocation;

- (UIImage*) getCroppedImage;

@end
