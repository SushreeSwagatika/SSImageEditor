//
//  SSLassoCropImageView.h
//  SSImageEditor
//
//  Created by Sushree Swagatika on 02/03/17.
//  Copyright © 2017 Sushree Swagatika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLassoCropImageView : UIImageView
{
    UIBezierPath *beizerPath;
    CAShapeLayer *shapeLayer;
    UIColor *strokeColor;
    CGFloat lineWidth;
    BOOL startedDrawing;
    
    UIImage *originalImage;
}

-(id)initWithImage:(UIImage *)newImage andFrame:(CGRect)framee;

-(UIImage *)cropCurrentImage;
-(UIImage *)undoAllCropping;

@end
