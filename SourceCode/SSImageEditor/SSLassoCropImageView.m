//
//  SSLassoCropImageView.m
//  SSImageEditor
//
//  Created by Sushree Swagatika on 02/03/17.
//  Copyright © 2017 Sushree Swagatika. All rights reserved.
//

#import "SSLassoCropImageView.h"

@implementation SSLassoCropImageView

-(id)initWithImage:(UIImage *)newImage andFrame:(CGRect)framee
{
    self = [super init];
    if (self) {
        [self setImage:newImage];
        [self setFrame:framee];
        self.userInteractionEnabled = YES;
        
        originalImage = self.image;
        startedDrawing = NO;
        
        strokeColor = [UIColor orangeColor];
        lineWidth = 2.0;
        beizerPath = [[UIBezierPath alloc]init];
    }
    return self;
}

-(void)addNewPathToImage {
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [beizerPath CGPath];
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    [self.layer addSublayer:shapeLayer];
}

-(UIImage *)cropCurrentImage
{
    if (startedDrawing) {
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        self.layer.mask = shapeLayer;
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size , false, 1);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return croppedImage;
    }
    return originalImage;
}

-(UIImage *)undoAllCropping
{
    beizerPath = [[UIBezierPath alloc]init];
    shapeLayer.path = beizerPath.CGPath;
    for (CAShapeLayer *layr in self.layer.sublayers) {
        layr.strokeColor = [UIColor clearColor].CGColor;
    }
    self.layer.mask = nil;
    self.image = originalImage;
    startedDrawing = NO;
    
    return originalImage;
}

#pragma mark - Touches Event Actions

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    startedDrawing = YES;
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [beizerPath moveToPoint:[mytouch locationInView:self]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch = [[touches allObjects] objectAtIndex:0];
    
    [beizerPath addLineToPoint:[mytouch locationInView:self]];
    [self addNewPathToImage];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch = [[touches allObjects] objectAtIndex:0];
    [beizerPath addLineToPoint:[mytouch locationInView:self]];
    [self addNewPathToImage];
    [beizerPath closePath];
}

@end
