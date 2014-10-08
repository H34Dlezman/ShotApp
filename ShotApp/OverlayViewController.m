//
//  OverlayViewController.m
//  ShotApp
//
//  Created by Parsa Amini on 07.10.14.
//  Copyright (c) 2014 PAMA. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *flashBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchCamBtn;

@end

@implementation OverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    self.pickerReference.cameraFlashMode =
    UIImagePickerControllerCameraFlashModeOff;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePhoti:(id)sender {
    [self.pickerReference takePicture];
}
- (IBAction)flashlight:(id)sender {
    if (self.pickerReference.cameraFlashMode ==
        UIImagePickerControllerCameraFlashModeOff) {
        NSLog(@"1");
        if ([UIImagePickerController
             isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear ])
            
        {
            NSLog(@"2");
            self.pickerReference.cameraFlashMode =
            UIImagePickerControllerCameraFlashModeOn;
        }
    }
    else
    {
        NSLog(@"3");
        self.pickerReference.cameraFlashMode =
        UIImagePickerControllerCameraFlashModeOff;
    }
}
- (IBAction)switchCam:(id)sender {
    if (self.pickerReference.cameraDevice==UIImagePickerControllerCameraDeviceFront) {
        self.pickerReference.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        self.flashBtn.hidden=false;
    }else{
        self.pickerReference.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        self.flashBtn.hidden=true;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
