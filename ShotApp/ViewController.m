//
//  ViewController.m
//  ShotApp
//
//  Created by Parsa Amini on 06.10.14.
//  Copyright (c) 2014 PAMA. All rights reserved.
//

#import "ViewController.h"
#import "OverlayViewController.h"
#import <GPUImage/GPUImage.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImagePickerController *picker;
@property (nonatomic) OverlayViewController *overlay;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    origImg = self.imageView.image;
}
- (IBAction)zeigphoto:(id)sender {
    // Do any additional setup after loading the view, typically from a nib.
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.picker.showsCameraControls = NO;
    self.picker.navigationBarHidden = YES;
    self.picker.toolbarHidden = YES;
    self.picker.extendedLayoutIncludesOpaqueBars = YES;
    
    // Insert the overlay
    self.overlay = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:nil];
    self.overlay.pickerReference = self.picker;
    [self.picker.cameraOverlayView addSubview:self.overlay.view];
    self.picker.delegate = self;
    
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 71.0); //This slots the preview exactly in the middle of the screen by moving it down 71 points
    self.picker.cameraViewTransform = translate;
    
    CGAffineTransform scale = CGAffineTransformScale(translate, 1.333333, 1.333333);
    self.picker.cameraViewTransform = scale;
    
    [self presentViewController:self.picker animated:NO
                     completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    origImg = image;
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //[self.capturedImages addObject:image];
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.picker = nil;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)setFilter:(id)sender {
    GPUImageFilter *selectedFilter;
    
    switch (((UIButton*)sender).tag) {
        case 0:
            selectedFilter = [[GPUImageGrayscaleFilter alloc] init];
            break;
        case 1:
            selectedFilter = [[GPUImageSepiaFilter alloc] init];
            break;
        case 2:
            selectedFilter = [[GPUImageSketchFilter alloc] init];
            break;
        case 3:
            selectedFilter = [[GPUImagePixellateFilter alloc] init];
            ((GPUImagePixellateFilter*)selectedFilter).fractionalWidthOfAPixel = 0.01;
            break;
        case 4:
            selectedFilter = [[GPUImageColorInvertFilter alloc] init];
            break;
        case 5:
            selectedFilter = [[GPUImageToonFilter alloc] init];
            break;
        case 6:
            selectedFilter = [[GPUImageAmatorkaFilter alloc] init];
            break;
        case 7:
            selectedFilter = [[GPUImageMissEtikateFilter alloc] init];
            break;
        case 8:
            selectedFilter = [[GPUImageSoftEleganceFilter alloc] init];
            break;
        case 9:
            selectedFilter = [[GPUImageHazeFilter alloc] init];
            break;
        case 10:
            selectedFilter = [[GPUImageFilter alloc] init];
            break;
        default:
            break;
    }
    
    UIImage *filteredImage = [selectedFilter imageByFilteringImage:origImg];
    [self.imageView setImage:filteredImage];
}

@end
