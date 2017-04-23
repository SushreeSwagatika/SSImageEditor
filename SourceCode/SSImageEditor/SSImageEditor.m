//
//  SSImageEditor.m
//  SSImageEditor
//
//  Created by Sushree Swagatika on 02/03/17.
//  Copyright © 2017 Sushree Swagatika. All rights reserved.
//

#import "SSImageEditor.h"
#import "GPUImage.h"

@interface SSImageEditor()

@property (nonatomic) GPUImageContrastFilter *contrastFilter;
@property (nonatomic) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic) GPUImageExposureFilter *sharpnessFilter;
@property (nonatomic) GPUImageSaturationFilter *saturationFilter;

@end

@implementation SSImageEditor

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _originalImage  = image;
        _context        = [CIContext contextWithOptions:nil];
        _beginImage     = [[CIImage alloc] initWithImage:_originalImage];
        
        _contrastFilter = [[GPUImageContrastFilter alloc] init];
        _brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
        _sharpnessFilter = [[GPUImageExposureFilter alloc] init];
        _saturationFilter = [[GPUImageSaturationFilter alloc] init];
    }
    return self;
}

#pragma mark - Filter Section

- (UIImage *)filterImage:(UIImage *)image withType:(SSFilterType)filter
{
    if( !self.originalImage )
        return nil;
    
    CIFilter *filterr;
    
    switch (filter) {
        case SSFilterTypeNone:
            return image;
            
            break;
        case SSFilterTypeMono:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectMono"];
            break;
        case SSFilterTypeTonal:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
            break;
        case SSFilterTypeNoir:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectNoir"];
            break;
        case SSFilterTypeFade:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectFade"];
            break;
        case SSFilterTypeChrome:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
            break;
        case SSFilterTypeProcess:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectProcess"];
            break;
        case SSFilterTypeTransfer:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
            break;
        case SSFilterTypeInstant:
            filterr = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
            break;
            
        default:
            break;
    }
    [filterr setValue:[CIImage imageWithCGImage:image.CGImage] forKey:kCIInputImageKey];
    CIImage *output = filterr.outputImage;
    
    CGImageRef cgImg = [_context createCGImage:output fromRect:[output extent]];
    UIImage *imgFiltered = [UIImage imageWithCGImage:cgImg];
    
    return imgFiltered;
}

#pragma mark - Flip Section

- (UIImage *)flipImage:(UIImage *)image withType:(SSFlipType)flip
{
    if( !self.originalImage )
        return nil;
    
    UIImage* flippedImage;
    switch (flip) {
        case SSFlipTypeUp:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationUp];
            break;
        case SSFlipTypeDown:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationDown];
            break;
        case SSFlipTypeLeft:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationLeft];
            break;
        case SSFlipTypeRight:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationRight];
            break;
        case SSFlipTypeMirroredUp:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationUpMirrored];
            break;
        case SSFlipTypeMirroredDown:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationDownMirrored];
            break;
        case SSFlipTypeMirroredLeft:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationLeftMirrored];
            break;
        case SSFlipTypeMirroredRight:
            flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationRightMirrored];
            break;
            
        default:
			flippedImage = [UIImage imageWithCGImage:image.CGImage
                                               scale:image.scale
                                         orientation:UIImageOrientationUp];
            break;
    }
    
    return flippedImage;
}

#pragma mark - Mask Section

- (UIBezierPath *)maskImageWithType:(SSMaskType)mask withRect:(CGRect)bezierRect andRadius:(CGFloat)radius andCentre:(CGPoint)centr
{
    UIBezierPath *currentMaskPath;
    switch (mask) {
        case SSMaskTypeCircle:
            currentMaskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(bezierRect.size.width/2 -(1.5*radius)/2, bezierRect.size.height/2 -(1.5*radius)/2, 1.5*radius, 1.5*radius) cornerRadius:radius];
            break;
        case SSMaskTypeOvalHorizontal:
            currentMaskPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bezierRect.size.width/2 -(1.5*radius)/2, bezierRect.size.height/2 -(radius)/2, 1.5*radius, radius)];
            break;
        case SSMaskTypeOvalVertical:
            currentMaskPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bezierRect.size.width/2 -(radius)/2, bezierRect.size.height/2 -(1.5*radius)/2, radius, 1.5*radius)];
            break;
        case SSMaskTypeRectangleHorizontal:
            currentMaskPath = [UIBezierPath bezierPathWithRect:CGRectMake(bezierRect.size.width/2 -(1.5*radius)/2, bezierRect.size.height/2 -(radius)/2, 1.5*radius, radius)];
            break;
        case SSMaskTypeRectangleVertical:
            currentMaskPath = [UIBezierPath bezierPathWithRect:CGRectMake(bezierRect.size.width/2 -(radius)/2, bezierRect.size.height/2 -(1.5*radius)/2, radius, 1.5*radius)];
            break;
        case SSMaskTypeFan:
            currentMaskPath = [self getStarredBeizerPathWithNumberOfPoints:3 andRect:bezierRect andCentre:centr];
            break;
        case SSMaskTypeDiamond:
            currentMaskPath = [self getStarredBeizerPathWithNumberOfPoints:4 andRect:bezierRect andCentre:centr];
            break;
        case SSMaskTypePentagon:
            currentMaskPath = [self getStarredBeizerPathWithNumberOfPoints:5 andRect:bezierRect andCentre:centr];
            break;
        case SSMaskTypeHexagon:
            currentMaskPath = [self getStarredBeizerPathWithNumberOfPoints:6 andRect:bezierRect andCentre:centr];
            break;
        case SSMaskTypeSun:
            currentMaskPath = [self getStarredBeizerPathWithNumberOfPoints:10 andRect:bezierRect andCentre:centr];
            break;
            
        default:
            break;
    }
    
    return currentMaskPath;
}

-(CGPoint)pointFromangle: (CGFloat)angle radius:(CGFloat)radius offset:(CGPoint)offset
{
    return CGPointMake(radius * cos(angle) + offset.x, radius * sin(angle) + offset.y);
}

-(UIBezierPath*)getStarredBeizerPathWithNumberOfPoints:(int)points andRect:(CGRect)bezierRect andCentre:(CGPoint)centreOfStar
{
    UIBezierPath *starredPath = [UIBezierPath bezierPath];
    CGRect rectt = bezierRect;
    float starExtrusion = 45.0;
    
    CGPoint centerr = centreOfStar;
    
    int pointsOnStar = points ;
    CGFloat anglee = - M_PI / 2.0;
    CGFloat angleIncrement = M_PI * 2.0 / (double)pointsOnStar;
    float radiuss = rectt.size.width / 2.0;
    
    BOOL firstPoint = YES;
    
    for (int i=1; i<=pointsOnStar; i++) {
        CGPoint point = [self pointFromangle:anglee radius:radiuss offset:centerr];
        CGPoint nextPoint = [self pointFromangle:anglee + angleIncrement radius: radiuss offset: centerr];
        CGPoint midPoint = [self pointFromangle:anglee + angleIncrement / 2.0 radius: starExtrusion offset: centerr];
        
        if (firstPoint) {
            firstPoint = NO;
            [starredPath moveToPoint:point];
        }
        
        [starredPath addLineToPoint:midPoint];
        [starredPath addLineToPoint:nextPoint];
        
        anglee+=angleIncrement;
    }
    
    [starredPath closePath];
    
    return starredPath;
}

#pragma mark - Crop Section

- (UIImage *)getCroppedImageFromResizableCropView:(SSResizableCropView *)imageCropper
{
    return [imageCropper getCroppedImage];
}

- (UIImage *)getLassoCroppedImageWithOriginalBaseImage:(SSLassoCropImageView *)imageCropper
{
    return [imageCropper cropCurrentImage];
}

#pragma mark - Shading Section

- (UIImage *)shadeImage:(UIImage *)image withContrastValue:(CGFloat)newVal
{
    UIImage *imgg = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:image.imageOrientation];
    
    // set the new value
    [_contrastFilter setContrast:newVal];
    UIImage *imm =[_contrastFilter imageByFilteringImage:imgg];
    
    // return new image with new shaded value
    return [UIImage imageWithCGImage:imm.CGImage scale:imm.scale orientation:imgg.imageOrientation];
}

- (UIImage *)shadeImage:(UIImage *)image withBrightnessValue:(CGFloat)newVal
{
    UIImage *imgg = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:image.imageOrientation];
    
    // set the new value
    [_brightnessFilter setBrightness:newVal];
    UIImage *imm =[_brightnessFilter imageByFilteringImage:imgg];
    
    // return new image with new shaded value
    return [UIImage imageWithCGImage:imm.CGImage scale:imm.scale orientation:imgg.imageOrientation];
}

- (UIImage *)shadeImage:(UIImage *)image withSharpnessValue:(CGFloat)newVal
{
    UIImage *imgg = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:image.imageOrientation];
    
    // set the new value
    [_sharpnessFilter setExposure:newVal];
    UIImage *imm =[_sharpnessFilter imageByFilteringImage:imgg];
    
    // return new image with new shaded value
    return [UIImage imageWithCGImage:imm.CGImage scale:imm.scale orientation:imgg.imageOrientation];
}

- (UIImage *)shadeImage:(UIImage *)image withSaturationValue:(CGFloat)newVal
{
    UIImage *imgg = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:image.imageOrientation];
    
    // set the new value
    [_saturationFilter setSaturation:newVal];
    UIImage *imm =[_saturationFilter imageByFilteringImage:imgg];
    
    // return new image with new shaded value
    return [UIImage imageWithCGImage:imm.CGImage scale:imm.scale orientation:imgg.imageOrientation];
}

#pragma mark - Red Eye Removal

-(UIImage*)removeRedEyeFromImage:(UIImage*)image
{
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    // Get the filters and apply them to the image
    NSArray* filters = [ciImage autoAdjustmentFiltersWithOptions:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:kCIImageAutoAdjustEnhance]];
    for (CIFilter* filter in filters)
    {
        [filter setValue:ciImage forKey:kCIInputImageKey];
        ciImage = filter.outputImage;
    }
    
    // Create the corrected image
    CIContext* ctx = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [ctx createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage* finalImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return finalImage;
}

@end
