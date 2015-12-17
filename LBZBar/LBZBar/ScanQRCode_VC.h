//
//  ScanQRCode_VC.h
//  LBZBar
//
//  Created by kingly on 15/12/16.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanQRCodeVCDelegate <NSObject>
- (void) captureQRCode:(NSString*)code;
@optional
-(void)photoScan;
@end

@interface ScanQRCode_VC : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, weak) id<ScanQRCodeVCDelegate> delegate;
@end
