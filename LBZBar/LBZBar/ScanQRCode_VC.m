//
//  ScanQRCode_VC.m
//  LBZBar
//
//  Created by kingly on 15/12/16.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "ScanQRCode_VC.h"
#import "ColorUtil.h"

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define kScreenWidth ([[UIScreen mainScreen]bounds].size.width)//屏幕宽度

@interface ScanQRCode_VC ()

@end

@implementation ScanQRCode_VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-290)/2, 25, 290, 75)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines = 4;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text =@"将二维码图像置于矩形方框内,离手机摄像头10CM左右,系统会自动识别.";
    labIntroudction.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:labIntroudction];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-300)/2, 100, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-220)/2, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [scanButton setTintColor:[UIColor whiteColor]];
    [scanButton setBackgroundColor:[UIColor BtnBgColor]];
    scanButton.frame = CGRectMake(labIntroudction.frame.origin.x, 420, 120, 40);
    scanButton.layer.cornerRadius = 4;
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    UIButton * ptoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ptoButton setTitle:@"相册" forState:UIControlStateNormal];
    [ptoButton setTintColor:[UIColor whiteColor]];
    [ptoButton setBackgroundColor:[UIColor BtnBgColor]];
    ptoButton.frame = CGRectMake(labIntroudction.frame.origin.x +labIntroudction.frame.size.width - 120, 420, 120, 40);
    ptoButton.layer.cornerRadius = 4;
    [ptoButton addTarget:self action:@selector(phoOverlayView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ptoButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((kScreenWidth-220)/2, 110+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((kScreenWidth-220)/2, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (SIMULATOR) {
        NSLog(@"注意：该二维码扫描功能需要在真机上才能正常使用！");
    }else{
        [self setupCamera];

    }
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake((kScreenWidth-280)/2,110,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        if ([_delegate respondsToSelector:@selector(captureQRCode:)])
        {
            [_delegate captureQRCode:stringValue];
        }
    }
    
    [_session stopRunning];
    [self dismissViewControllerAnimated:YES completion:^
     {
         [timer invalidate];
     }];
}


#pragma mark - 点击相册
-(void)phoOverlayView:(id)sender{
    [_session stopRunning];
    [self dismissViewControllerAnimated:NO completion:^{
        [timer invalidate];
        if ([_delegate respondsToSelector:@selector(photoScan)])
        {
            [_delegate photoScan];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}


@end
